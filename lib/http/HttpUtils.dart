import 'dart:io';

import 'package:createunion/utils/CommonUtils.dart';
import 'package:createunion/utils/Constant.dart';
import 'package:createunion/utils/CustomNavigatorObserver.dart';
import 'package:createunion/widget/Toast.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';


class HttpUtils {
  Dio _dio;
  BaseOptions _options;
  static HttpUtils _instance;
  static InterceptorsWrapper _interceptorsWrapper;
  static LogInterceptor _logInterceptor;
  factory HttpUtils({bool needAuthor}) => _getInstance(needAuthor ?? true);

  HttpUtils._internal() {
    _options = BaseOptions();
    _dio = Dio(_options);
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true; //无条件允许https证书通行
      };
    };
    _logInterceptor = LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: true);
    _interceptorsWrapper =
        InterceptorsWrapper(onRequest: (RequestOptions options) {
      if (options.headers["Authorization"] == null) {
//        if (Constant.appContext.read<UserInfo>().token.isNotEmpty)
//          options.headers["Authorization"] =
//              "Bearer " + Constant.appContext.read<UserInfo>().token;
//              print('${options.headers["Authorization"]}');
      }
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError error) {
      if (null != error.response  && error.response.statusCode == 401) {
        CommonUtils.throttle(() {
          Toast.toast('登录失效,请重新登陆!');
//          CustomNavigatorObserver.getInstance()
//              .navigator
//              .pushNamed(Login.routerName);
        }, durationTime: 2000);
      }else if(error.message.contains('Failed host lookup') || error.message.contains('Connection refused')){
          Toast.toast('似乎已断开与互联网的连接!');
          return '似乎已断开与互联网的连接!';
      }
      return error;
    });
  }

  static HttpUtils _getInstance(bool needAuthor) {
    if (_instance == null) {
      _instance = HttpUtils._internal();
    }
    _instance._dio.interceptors.clear();
    _instance._dio.interceptors.add(_logInterceptor);
    if (needAuthor) {
      _instance._dio.interceptors.add(_interceptorsWrapper);
    }
    return _instance;
  }

  Future get(String path, {data, Options options, CancelToken cancelToken}) {
    return _dio
        .get(path, queryParameters: data, options: options)
        .then((response) {
      return response.data;
    });
  }

  Future<dynamic> post(String path,
      {data,
      Options options,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken}) {
    return _dio
        .post(path,
            data: data, options: options, queryParameters: queryParameters)
        .then((response) {
      return response.data;
    });
  }

  Future<Map> put(String path,
      {data, Options options, CancelToken cancelToken}) {
    return _dio.put(path, data: data, options: options).then((response) {
      return response.data;
    });
  }

  Future<Map> delete(String path,
      {data, Options options, CancelToken cancelToken}) {
    return _dio.delete(path, data: data, options: options).then((response) {
      return response.data;
    });
  }

  Future<Response> downloadFile(String urlPath, String savePath,
      {Options option, ProgressCallback onReceiveProgress}) {
    return _dio
        .download(urlPath, savePath,
            options: option, onReceiveProgress: onReceiveProgress)
        .then((response) {
      return response;
    });
  }
}
