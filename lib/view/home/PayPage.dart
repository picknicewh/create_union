import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:flutter/material.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return FullBasePage(
      title: "充值",
      child: Column(
        children: [

          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.px),
                child: Image.asset(
                  "images/ewcode.png",
                  width: 200.px,
                ),
              ),
              Text(
                "无法支付？点击刷新",
                style: TextStyle(fontSize: 18.px, color: Mcolors.C333333),
              ),
            ],
          )),
          Container(
            margin: EdgeInsets.only(bottom: 100.px,right: 30.px,left: 30.px),
            alignment: Alignment.bottomCenter,
            child:   Text(
              "充值请备注账号，如超过30分钟未到账，请联系客服，客服微信：whecit",
              style: TextStyle(fontSize: 18.px, color: Mcolors.C333333),
            ),
          ),

        ],
      ),
    );
  }
}
