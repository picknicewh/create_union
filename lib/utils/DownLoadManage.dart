import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'Constant.dart';
import 'SPUtils.dart';

/*
 * 文件下载
 * 懒加载单例
 */
class DownLoadManage {
  static const undefined = 0;
  static const enqueued = 1;
  static const running = 2;
  static const complete = 3;
  static const failed = 4;
  static const canceled = 5;
  static const paused = 6;
  //用于记录正在下载的url，避免重复下载
//  var downloadingUrls = new List();
  var downloadingUrls = new Map<String, CancelToken>();

  // 单例公开访问点
  factory DownLoadManage() => _getInstance();

  // 静态私有成员，没有初始化
  static DownLoadManage _instance;

  // 私有构造函数
  DownLoadManage._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static DownLoadManage _getInstance() {
    if (_instance == null) {
      _instance = DownLoadManage._();
    }
    return _instance;
  }

  StreamController<Map> steamControl = StreamController.broadcast();
  /*
   *下载
   */
  Future download(url, savePath, var info, var userInfo,
      {ProgressCallback onReceiveProgress,
      Function done,
      Function failed}) async {
    int downloadStart = 0;
    bool fileExists = false;
    File f = File(savePath);
    if (await f.exists()) {
      downloadStart = f.lengthSync();
      fileExists = true;
    }
    info['status'] = DownLoadManage.undefined;
    steamControl.add(info);
    if (fileExists && downloadingUrls.containsKey(url)) {
      //正在下载
      return;
    }
    var dio = Dio();
    int contentLength = await _getContentLength(dio, url, info, userInfo);
    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.connectTimeout = 1000 * 15;
      options.receiveTimeout = 1000 * 15;
      options.sendTimeout = 1000 * 15;
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError e) {
      return e;
    }));

    if (downloadStart == contentLength) {
      //存在本地文件，命中缓存
      setState(complete, info, userInfo);
      done();
      return;
    }
    CancelToken cancelToken = new CancelToken();
    downloadingUrls[url] = cancelToken;

    Future downloadByDio(String url, int start) async {
      try {
        Response response = await dio.get(
          url,
          options: Options(
            responseType: ResponseType.stream,
            followRedirects: false,
            headers: {"range": "bytes=$start-"},
          ),
        );
        File file = new File(savePath.toString());

        var raf = file.openSync(mode: FileMode.append);
        Completer completer = new Completer<Response>();
        Future future = completer.future;

        int received = start;
        int total =
            int.tryParse(response.headers.value(Headers.contentLengthHeader));
        info['total'] = total + start;
        SPUtils.getString(Constant.DOWNLOAD).then((s) {
          if (s == null) {
            SPUtils.setString(Constant.DOWNLOAD, json.encode([info])).then((s) {
              progress(response, raf, received, onReceiveProgress, total, start,
                  cancelToken, info, completer, done, url, userInfo, failed);
            });
          } else {
            List old = json.decode(s);
            bool isContain = false;
            for (int i = 0; i < old.length; i++) {
              if (old[i]['path'] == info['path']) {
                old[i]['total'] = info['total'];
                isContain = true;
              }
            }
            if (!isContain) {
              old.add(info);
            }
            SPUtils.setString(Constant.DOWNLOAD, json.encode(old)).then((s) {
              progress(response, raf, received, onReceiveProgress, total, start,
                  cancelToken, info, completer, done, url, userInfo, failed);
            });
          }
        });

        return await _listenCancelForAsyncTask(cancelToken, future);
      } catch (e) {
        formatError(e, info, userInfo);
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          //下载异常  或者  中断  需要重新进行下载
//          setState(DownLoadManage.failed, info, userInfo);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
//          setState(DownLoadManage.failed, info, userInfo);
        }
        if (CancelToken.isCancel(e)) {
          setState(DownLoadManage.paused, info, userInfo);
        } else {
          if (failed != null) {
            failed(e);
          }
          setState(DownLoadManage.failed, info, userInfo);
        }
        downloadingUrls.remove(url);
      }
    }

    await downloadByDio(url, downloadStart);
  }

  void progress(response, raf, received, onReceiveProgress, total, start,
      cancelToken, info, completer, done, url, userInfo, failed) {
    Stream<List<int>> stream = response.data.stream;
    StreamSubscription subscription;
    Future asyncWrite;
    subscription = stream.listen(
      (data) {
        subscription.pause();
        // Write file asynchronously
        asyncWrite = raf.writeFrom(data).then((_raf) {
          // Notify progress
          received += data.length;
          if (onReceiveProgress != null) {
            onReceiveProgress(received, total + start);
          }
          raf = _raf;
          if (cancelToken == null || !cancelToken.isCancelled) {
            info['received'] = received;
            info['total'] = total + start;
            info['status'] = received == (total + start) ? complete : running;
            info['progress'] = (received / (total + start)) * 100;
            steamControl.add(info);
            subscription.resume();
          }
        });
      },
      onDone: () async {
        try {
          await asyncWrite;
          await raf.close();
          completer.complete(response);
          downloadingUrls.remove(url);
          if (done != null) {
            done();
            setState(DownLoadManage.complete, info, userInfo);
          }
        } catch (e) {
          downloadingUrls.remove(url);
          completer.completeError(_assureDioError(e));

          if (failed != null) {
            failed(e);
            setState(DownLoadManage.failed, info, userInfo);
          }
        }
      },
      onError: (e) async {
        try {
          await asyncWrite;
          await raf.close();
          downloadingUrls.remove(url);
          if (failed != null) {
            failed(e);
            setState(DownLoadManage.failed, info, userInfo);
          }
        } finally {
          completer.completeError(_assureDioError(e));
        }
      },
      cancelOnError: true,
    );
    // ignore: unawaited_futures
    cancelToken?.whenCancel?.then((_) async {
      await subscription.cancel();
      await asyncWrite;
      await raf.close();
    });
  }

  /*
   * 获取下载的文件大小
   */
  Future _getContentLength(Dio dio, url, info, userInfo) async {
    try {
      Response response = await dio.head(url);
      return int.tryParse(response.headers.value(Headers.contentLengthHeader));
    } catch (e) {
      setState(DownLoadManage.failed, info, userInfo);
      return 0;
    }
  }

  void stop(String url) {
    if (downloadingUrls.containsKey(url)) {
      downloadingUrls[url].cancel();
    }
  }

  Future<T> _listenCancelForAsyncTask<T>(
      CancelToken cancelToken, Future<T> future) {
    Completer completer = new Completer();
    if (cancelToken != null && cancelToken.cancelError == null) {
      return Future.any([completer.future, future]).then<T>((result) {
        return result;
      }).catchError((e) {
        throw e;
      });
    } else {
      return future;
    }
  }

  DioError _assureDioError(err) {
    if (err is DioError) {
      return err;
    } else {
      var _err = DioError(error: err);
      if (err is Error) {
        _err.error = err.stackTrace;
      }
      return _err;
    }
  }

  void setState(int status, var info, var userInfo) {
    info['status'] = status;
    switch (status) {
      case undefined:
        steamControl.add(info);
        break;
      case enqueued:
        steamControl.add(info);
        break;
      case running:
        steamControl.add(info);
        break;
      case complete:
        info['progress'] = 100;
        saveToSP(info, userInfo);
        break;
      case failed:
        info['progress'] = -1;
        saveToSP(info, userInfo);
        break;
      case canceled:
        steamControl.add(info);
        break;
      case paused:
        steamControl.add(info);
        break;
    }
  }

  ///未进入我的下载中  文件已下载完成  （文件过小或者一直在后台下的情况）
  ///异常情况  需要记录当前状态
  void saveToSP(info, userInfo) {
    List datas = [];
    SPUtils.getString(Constant.DOWNLOAD).then((_) {
      if (_ == null || _.isEmpty) if (userInfo['iuid'] == info['iuid'] &&
          datas.length == 0) {
        datas.add(info);
        SPUtils.setString(Constant.DOWNLOAD, json.encode(datas));
        return;
      } else {
        List copy = json.decode(_);
        datas = json.decode(_);
        for (int i = 0; i < copy.length; i++) {
          if (i == copy.length - 1 && userInfo['iuid'] == info['iuid']) {
            datas.add(info);
            SPUtils.setString(Constant.DOWNLOAD, json.encode(datas));
          }
        }
      }
      steamControl.add(info);
    });
  }

  //计算速度
  static void getSpeed(data) {
    int sizeOld = 0;
    int sizeNew = 0;
    if (!File(data['path']).existsSync()) {
      return;
    }
    File(data['path']).length().then((length) {
      sizeOld = length;
      Future.delayed(Duration(seconds: 1)).then((d) {
        File(data['path']).length().then((length) {
          sizeNew = length;
          String speed = ((sizeNew - sizeOld) / 1024).toString();
          if (speed.contains(".")) {
            if (speed.substring(0, speed.indexOf(".")).length > 3) {
              //5552.12313 kb/s
              speed = ((sizeNew - sizeOld) / 1024 / 1024).toString();
              if (speed.contains(".") &&
                  speed.substring(speed.indexOf(".")).length > 4) {
                //0.995M
                speed = speed.substring(0, speed.indexOf(".") + 3) + "m/s";
              } else {
                speed = speed + "m/s";
              }
            } else {
              if (speed.substring(speed.indexOf(".")).length > 4) {
                speed = speed.substring(0, speed.indexOf(".") + 3) + "k/s";
              } else {
                speed = speed + "k/s";
              }
            }
          } else {
            speed = speed + "k/s";
          }
          data['speed'] = speed.toString();
        });
      });
    });
  }

  ///* error统一处理*/

  void formatError(DioError e, info, userInfo) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
// It occurs when url is opened timeout.

      setState(DownLoadManage.failed, info, userInfo);
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
// It occurs when url is sent timeout.

      setState(DownLoadManage.failed, info, userInfo);
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
//It occurs when receiving timeout
      setState(DownLoadManage.failed, info, userInfo);
    } else if (e.type == DioErrorType.RESPONSE) {
// When the server response, but with a incorrect status, such as 404, 503...
      setState(DownLoadManage.failed, info, userInfo);
    } else if (e.type == DioErrorType.CANCEL) {
// When the request is cancelled, dio will throw a error with this type.

    } else {
//DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.

    }
  }
}
