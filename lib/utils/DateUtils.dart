import 'dart:math';

import 'package:common_utils/common_utils.dart';

@Deprecated("请使用common_utils三方库中标准方法")
class DateUtils {
  //计算年龄
  static int getAge({DateTime date}) {
    int now = DateTime.now().year;
    DateTime d = date ?? now;
    return now - d.year;
  }

  // 根据身份证号计算 年龄
  static int getAgeWithIDCard(String idCard) {
    // -1 说明出错
    int age = -1;
    try {
      int year = int.parse(idCard.substring(6, 10));
      int month = int.parse(idCard.substring(10, 12));
      int day = int.parse(idCard.substring(12, 14));
      DateTime now = DateTime.now();
      int cYear = now.year;
      int cMonth = now.month;
      int cDay = now.day;
      int age = cYear - year;
      if (month > cMonth) {
        age = age - 1;
      }
      if (month == cMonth && day > cDay) {
        age = age - 1;
      }
      return age;
    } catch (e) {}
    return age;
  }
  //根据身份证计算性别
  static String getSex(String idCard) {
    String sex = '男';
    if (idCard != null && idCard != "" ) {
      if(idCard.length == 18){
        sex = int.parse(idCard.substring(idCard.length - 4, idCard.length - 1)) % 2 == 0 ? "女" : "男";
      }else {
        sex = int.parse(idCard.substring(idCard.length - 3, idCard.length)) % 2 == 0 ? "女" : "男";
      }
    }
    return sex;
  }
  //根据生日计算年龄
  static String getAgeByBirthday1(String birthday) {
    int age = 0;
    if (birthday != null || birthday != "") {
      try {
        DateTime birth = DateTime.parse(birthday);
        age = getAge(date: birth);
      } catch (e) {
        age = 0;
      }
    }
    return "$age";
  }

  // 根据身份证号计算 年龄
  static String getBirthdayDCard(String idCard) {
    // -1 说明出错
    if (idCard == null || idCard == "" || idCard.length < 16) {
      return "";
    }
    return idCard.substring(6, 14);
  }

  //根据生日计算年龄
  static String getAgeByBirthday(String birthday) {
    int age = 0;
    if (birthday != null || birthday != "") {
      try {
        DateTime birth = DateTime.parse(birthday);
        age = getAge(date: birth);
      } catch (e) {
        age = 0;
      }
    }
    return "$age岁";
  }

  //根据生日计算年龄
  static int getAgeByBirthday2(String birthday) {
    int age = 0;
    if (birthday != null || birthday != "") {
      try {
        DateTime birth = DateTime.parse(birthday);
        age = getAge(date: birth);
      } catch (e) {
        age = 0;
      }
    }
    return age;
  }

  static String getFormatedDateTime(String dt) {
    List<String> mList = dt.split(" ");
    List<String> d = mList[0].split("/");
    List<String> t = mList[1].split(":");
    return d[0] +
        "-" +
        (d[1].length == 1 ? "0" + d[1] : d[1]) +
        "-" +
        (d[2].length == 1 ? "0" + d[2] : d[2]) +
        " " +
        (t[0].length == 1 ? "0" + t[0] : t[0]) +
        (t[1].length == 1 ? "0" + t[1] : t[1]) +
        (t[2].length == 1 ? "0" + t[2] : t[2]);
  }

  static bool isCardId(String cardId) {
    if (cardId.length == 15) {
      cardId = get18Ic(cardId);
    } else if (cardId.length > 15 && cardId.length < 18) {
      cardId = cardId.trim();
      if (cardId.length == 15) {
        cardId = get18Ic(cardId);
      }
    }
    if (cardId.length != 18) {
      return false; // 位数不够
    }
    // 身份证号码正则
    RegExp postalCode = new RegExp(
        r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');

    // 通过验证，说明格式正确，但仍需计算准确性
    if (!postalCode.hasMatch(cardId)) {
      return false;
    }
    //将前17位加权因子保存在数组里
    final List idCardList = [
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2",
      "1",
      "6",
      "3",
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2"
    ];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    final List idCardYArray = [
      '1',
      '0',
      '10',
      '9',
      '8',
      '7',
      '6',
      '5',
      '4',
      '3',
      '2'
    ];
    // 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;

    for (int i = 0; i < 17; i++) {
      int subStrIndex = int.parse(cardId.substring(i, i + 1));
      int idCardWiIndex = int.parse(idCardList[i]);
      idCardWiSum += subStrIndex * idCardWiIndex;
    }
    // 计算出校验码所在数组的位置
    int idCardMod = idCardWiSum % 11;
    // 得到最后一位号码
    String idCardLast = cardId.substring(17, 18);
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
      if (idCardLast != 'x' && idCardLast != 'X') {
        return false;
      }
    } else {
      //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
      if (idCardLast != idCardYArray[idCardMod]) {
        return false;
      }
    }
    return true;
  }

// 15位转18位身份证号
  static String get18Ic(String identityCard) {
    String retId = "";
    String id17 = "";
    int sum = 0;
    int y = 0;
    // 定义数组存放加权因子（weight factor）
    List wf = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
    // 定义数组存放校验码（check code）
    List cc = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"];
    // 加上两位年19
    id17 = identityCard.substring(0, 6) + "19" + identityCard.substring(6);
    // 十七位数字本体码加权求和
    for (int i = 0; i < 17; i++) {
      sum = sum + int.parse(id17.substring(i, i + 1)) * wf[i];
    }
    // 计算模
    y = sum % 11;
    // 通过模得到对应的校验码 cc[y]
    retId = id17 + cc[y];
    return retId;
  }

  static String getAgeByIDNumber(String idNumber) {
    String dateStr;
    if (idNumber.length == 15) {
      dateStr = "19" + idNumber.substring(6, 12);
    } else if (idNumber.length == 18) {
      dateStr = idNumber.substring(6, 14);
    } else {
      //默认是合法身份证号，但不排除有意外发生
      return "";
    }
    return DateUtil.formatDateStr(dateStr, format: "yyyy-MM-dd");
  }

  static bool isPhone(String phoneNum) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    //bool matched = exp.hasMatch(phoneNum);
    RegExp ex = RegExp(r'^(0\d{2,3}\-)?([2-9]\d{6,7})+(\-\d{1,6})?$');
    return exp.hasMatch(phoneNum) || ex.hasMatch(phoneNum);
  }

  static String formatNum(double num, int position) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        position) {
      //小数点后有几位小数
      return num.toStringAsFixed(position)
          .substring(0, num.toString().lastIndexOf(".") + position + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + position + 1)
          .toString();
    }
  }
}
