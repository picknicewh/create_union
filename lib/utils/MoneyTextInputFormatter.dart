import 'package:flutter/services.dart';

class MoneyTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.01;
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newvalueText = newValue.text;

    if (newvalueText == ".") {
      //第一个数为.
      newvalueText = "0.";
    } else if (newvalueText != "" &&
        newvalueText != defaultDouble.toString() &&
        strToFloat(newvalueText, defaultDouble) == defaultDouble) {
      newvalueText = oldValue.text;
    } else if (newvalueText.contains(".")) {
      if (newvalueText.lastIndexOf(".") != newvalueText.indexOf(".")) {
        //输入了2个小数点
        newvalueText = newvalueText.substring(0, newvalueText.lastIndexOf('.'));
      } else if (newvalueText.length - 1 - newvalueText.indexOf(".") > 2) {
        //输入了1个小数点 小数点后两位
        newvalueText = newvalueText.substring(0, newvalueText.indexOf(".") + 3);
      }
    }

    return TextEditingValue(
      text: newvalueText,
      selection: new TextSelection.collapsed(offset: newvalueText.length),
    );
  }
}
