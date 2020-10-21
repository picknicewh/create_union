import 'dart:ui';
import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:flutter/material.dart';


import 'Line.dart';
import 'MText.dart';

class CustomAppBar extends StatelessWidget {
  String contentTitle;
  bool hideDivide;
  double height;
  Color backColor;
  Color contentTitleColor;
  AssetImage backGroundImage;
  Widget leftWidget;
  Widget rightWidget;
  Function backCallBack;

  CustomAppBar(
      {this.contentTitle = "",
      this.height,
      this.backColor = Mcolors.C3E86FF,
      this.contentTitleColor = Mcolors.C333333,
      this.hideDivide = true,
      this.backGroundImage,
      this.leftWidget,
      this.rightWidget,
      this.backCallBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: height ?? (44.px + SizeUtils.statusBar),
          padding: EdgeInsets.only(top: SizeUtils.statusBar),
          decoration: backGroundImage == null
              ? BoxDecoration(color: backColor)
              : BoxDecoration(
                  image: DecorationImage(
                      image: backGroundImage, fit: BoxFit.cover)),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: MText(
                  contentTitle,
                  style: TextStyle(
                      fontSize: 18.px,
                      color: contentTitleColor,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Positioned(
                right: 0,
                child: rightWidget ?? Container(),
              ),
              leftWidget ??
                  GestureDetector(
                    onTap: () {
                      if (backCallBack != null) {
                        backCallBack();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(10.px),
                      child: Image.asset(
                        "images/_return.png",
                        height: 17.px,
                        color: contentTitleColor,
                      ),
                    ),
                  ),
            ],
          ),
        ),
        Offstage(
          offstage: hideDivide,
          child: Line(
            color: Mcolors.CE9E9E9,
          ),
        ),
      ],
    );
  }
}
