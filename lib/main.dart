import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'bean/UserInfo.dart';
import 'package:createunion/utils/Constant.dart';
import 'package:createunion/utils/CustomNavigatorObserver.dart';
import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/RouteHelper.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserInfo()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Constant.appContext = this.context;
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "强创联合",
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      // debug 标签设置这一属性即可
      navigatorObservers: [
        BotToastNavigatorObserver(),
        CustomNavigatorObserver()
      ],
      initialRoute: '/',
      routes: RouteHelper.routers,
      theme: ThemeData(
          fontFamily: 'NotoSansSC',
          platform: TargetPlatform.iOS,
          primaryColor: Mcolors.primaryColor,
          primaryColorDark: Mcolors.primaryColorDark,
          accentColor: Mcolors.accentColor,
          scaffoldBackgroundColor: Mcolors.scaffoldBackgroundColor,
          brightness: Brightness.light),
      onGenerateRoute: (RouteSettings settings) {
        Map obj = settings.arguments;
        var routes = <String, WidgetBuilder>{};
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh', 'CH'),
      ],
    );
  }

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    super.dispose();
  }
}
