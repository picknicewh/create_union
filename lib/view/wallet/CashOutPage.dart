import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:flutter/material.dart';

class CashOutPage extends StatefulWidget {
  @override
  _CashOutPageState createState() => _CashOutPageState();
}

class _CashOutPageState extends State<CashOutPage> {
  TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _passController = TextEditingController();

  }

  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }
  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: "申请提现",
        titleBackgroundColor: Colors.white,
        titleColor: Mcolors.C333333,
        child: Column(
          children: [
            Container(
              height: 180.px,
              color: Mcolors.C333333,
              alignment: Alignment.center,
              child:


              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("可申请提现金额（元）",
                      style:
                      TextStyle(color: Mcolors.C999999, fontSize: 16.px)),
                  Container(height: 12.px),
                  Text("17.54",
                      style: TextStyle(color: Mcolors.white, fontSize: 36.px)),

                 Container(
                 //  height: 40.px,
                      margin: EdgeInsets.only(top: 30.px),
                   padding: EdgeInsets.symmetric(horizontal: 30.px),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("提现信息：",
                               style:
                               TextStyle(color: Mcolors.white, fontSize: 18.px)),
                           Container(height: 12.px),
                           Text("xxxxx",
                               style: TextStyle(color: Mcolors.white, fontSize: 18.px)),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("姓名：",
                               style:
                               TextStyle(color: Mcolors.white, fontSize: 18.px)),
                           Container(height: 12.px),
                           Text("李天琪",
                               style: TextStyle(color: Mcolors.white, fontSize: 18.px)),
                         ],
                       ),
                     ],
                   )
                 )
                ],
              ),


            ),




            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 20.px),
              alignment: Alignment.centerLeft,
              child: Text(
                "提现到支付宝/银行卡",
                style: TextStyle(color: Mcolors.C333333, fontSize: 18.px),
              ),
            ),
            Line(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              height: 48.px,
              color: Mcolors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "支付宝账号",
                    style: TextStyle(color: Mcolors.C333333, fontSize: 16.px),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "13991281982",
                      style: TextStyle(color: Mcolors.C666666, fontSize: 16.px),
                    ),
                  )
                ],
              ),
            ),
            Line(),
            Container(

              padding: EdgeInsets.symmetric(horizontal: 16.px),
              height: 48.px,
              color: Mcolors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "银卡卡账号",
                    style: TextStyle(color: Mcolors.C333333, fontSize: 16.px),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "628991292192210901920010",
                      style: TextStyle(color: Mcolors.C666666, fontSize: 16.px),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 48.px,
              margin: EdgeInsets.only(top: 10.px),
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              alignment: Alignment.centerLeft,
              color: Mcolors.white,
              child: Row(
                children: <Widget>[
                  Text(
                    "登录密码",
                    style: TextStyle(color: Mcolors.C333333, fontSize: 16.px),
                  ),
                  Expanded(
                      child: TextField(
                    keyboardAppearance: Brightness.light,
                    autofocus: false,
                    maxLength: 32,
                    controller: _passController,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Mcolors.C333333,
                        fontSize: 16.px,
                        fontFamily: ''),
                    onChanged: (s) {},
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: "请输入密码",
                      hintStyle: TextStyle(
                          color: Mcolors.CCCCCCC, fontSize: 16.px, height: 1.0),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 20.px),
              height: 48.px,
              decoration: BoxDecoration(
                  color: Mcolors.primaryColor,
                  borderRadius: BorderRadius.circular(24.px)),
              alignment: Alignment.center,
              child: Text(
                "申请提现",
                style: TextStyle(color: Mcolors.white, fontSize: 18.px),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
