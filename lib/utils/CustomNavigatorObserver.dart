import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver{
  static CustomNavigatorObserver _instance;
  factory CustomNavigatorObserver() => getInstance();

  static CustomNavigatorObserver getInstance() {
    if (_instance == null) {
      _instance = CustomNavigatorObserver._();
    }
    return _instance;
  }

   CustomNavigatorObserver._();
}