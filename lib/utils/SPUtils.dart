import 'package:shared_preferences/shared_preferences.dart';
import 'Constant.dart';

class SPUtils {
  static Future<bool> setString(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<List<String>> getStringList(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setStringList(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  static Future<bool> clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int d = await SPUtils.getInt(Constant.MODEL);
    bool b = await SPUtils.getBool(Constant.AGREE);
    await sp.clear();
    await sp.setInt(Constant.MODEL, d);
    await sp.setBool(Constant.AGREE, b);
    return true;
  }
}
