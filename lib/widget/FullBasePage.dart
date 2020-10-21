import 'dart:ui';

import 'package:createunion/res/Mcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'CustomAppBar.dart';

class FullBasePage extends StatelessWidget {
  Key mKey;
  String title;
  Color titleColor;
  Color titleBackgroundColor;
  Widget leftWidget;
  Widget rightWidget;
  Widget child;
  bool statusStyleDark;
  Color backgroundColor;
  Function backCallBack;
  bool resizeToBottomInset;

  FullBasePage({
    @required this.title,
    this.mKey,
    this.leftWidget,
    this.rightWidget,
    this.backgroundColor = Mcolors.CF8F9FA,
    this.titleColor = Mcolors.C333333,
    this.titleBackgroundColor = Mcolors.white,
    this.statusStyleDark = true,
    this.resizeToBottomInset = false,
    this.backCallBack,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mKey,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToBottomInset,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: statusStyleDark
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: Column(
          children: <Widget>[
            CustomAppBar(
              contentTitle: title,
              contentTitleColor: titleColor,
              backColor: titleBackgroundColor,
              leftWidget: leftWidget,
              rightWidget: rightWidget,
              backCallBack: backCallBack,
            ),
            Expanded(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
