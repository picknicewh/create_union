import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {
  String _token = '';
  Map _info = {};

  get token => _token;

  get info => _info;

  setToken(String tk) {
    _token = tk ?? '';
    notifyListeners();
  }

  update(Map info) {
    _info = info ?? {};
    notifyListeners();
  }

  clear() {
    _token = '';
    _info = {};
    notifyListeners();
  }
}
