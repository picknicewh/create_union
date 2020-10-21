import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return FullBasePage(
      title: "关于",
      child: Column(
        children: [
          Line(),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Mcolors.CDFEFFB, //阴影颜色
                  blurRadius: 3.px,
                  offset: Offset(0, 1)),
            ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    //       RouteHelper.pushWidget(context, WebViewPage(TYPE.AGREEMEMT));
                  },
                  child: Container(
                    height: 50.px,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 24.px, right: 18.px),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "用户服务协议",
                          style: TextStyle(
                              color: Mcolors.C666666, fontSize: 14.px),
                        )),
                        Image.asset(
                          "images/ic_left_grey.png",
                          width: 6.px,
                        )
                      ],
                    ),
                  ),
                ),
                Line(),
                GestureDetector(
                  onTap: () {
                    //   RouteHelper.pushWidget(context, WebViewPage(TYPE.PRIVACY));
                  },
                  child: Container(
                    height: 50.px,
                    alignment: Alignment.center,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 24.px, right: 18.px),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "隐私政策",
                          style: TextStyle(
                              color: Mcolors.C666666, fontSize: 14.px),
                        )),
                        Image.asset(
                          "images/ic_left_grey.png",
                          width: 6.px,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
