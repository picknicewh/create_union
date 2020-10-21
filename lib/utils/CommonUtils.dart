import 'dart:async';
import 'dart:convert' as convert;

class CommonUtils {


  //是否包含中文
  static bool isContainChinese(String str) {
    RegExp exp = RegExp(r"[\u4e00-\u9fa5]");
    Iterable<Match> matches = exp.allMatches(str);
    return matches.length != 0;
  }

  static String getDefault(gender) {
    String imageUrl = gender == "18-1"
        ? "images/app_avatar_female-01.png"
        : gender == "18-2"
            ? "images/app_avatar_male-01.png"
            : "images/ic_default_head.png";
    return imageUrl;
  }

  // 防抖函数: eg:输入框连续输入，用户停止操作300ms才执行访问接口
  static const deFaultDurationTime = 300;
  static Timer timer;

  static antiShake(Function doSomething, {durationTime = deFaultDurationTime}) {
    timer?.cancel();
    timer = new Timer(Duration(milliseconds: durationTime), () {
      doSomething?.call();
      timer = null;
    });
  }

  // 节流函数: eg:300ms内，只会触发一次
  static int startTime = 0;

  static throttle(Function doSomething, {durationTime = deFaultDurationTime}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - startTime > durationTime) {
      doSomething?.call();
      startTime = DateTime.now().millisecondsSinceEpoch;
    }
  }
  /*
  * Base64加密
  */
  static String base64Encode(String data){
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    return digest;
  }

}
