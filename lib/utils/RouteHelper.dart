import 'dart:async';
// import 'dart:js';

import 'package:createunion/view/enter/GuidePage.dart';
import 'package:createunion/view/enter/LoginPage.dart';
import 'package:flutter/material.dart';

class RouteHelper {
  static var routers = {
    '/': (context) => GuidePage(),
    LoginPage.routerName: (context) => LoginPage(),
  };
  //CustomNavigatorObserver.getInstance().navigator.pushNamed(ContinueListPage.routerName);
  static Future<T> pushWidget<T>(
    BuildContext context,
    Widget widget, {
    bool replaceRoot = false,
    bool replaceCurrent = false,
    RoutePredicate rootRoute,
  }) {
    return pushRoute(context, MaterialPageRoute(builder: (ctx) => widget),
        replaceRoot: replaceRoot,
        replaceCurrent: replaceCurrent,
        rootRoute: rootRoute);
  }

  static Future<T> pushRoute<T>(
    BuildContext context,
    PageRoute<T> route, {
    bool replaceRoot = false,
    bool replaceCurrent = false,
    RoutePredicate rootRoute,
  }) {
    assert(!(replaceRoot == true && replaceCurrent == true));
    assert(!(replaceRoot == true && rootRoute == null));
    if (replaceRoot == true) {
      return Navigator.pushAndRemoveUntil(
        context,
        route,
        rootRoute,
      );
    }
    if (replaceCurrent == true) {
      return Navigator.pushReplacement(context, route);
    }
    return Navigator.push(context, route);
  }
}
