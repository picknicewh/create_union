import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/EditDialog.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:flutter/material.dart';

class WalletSettingPage extends StatefulWidget {
  @override
  _WalletSettingPageState createState() => _WalletSettingPageState();
}

class _WalletSettingPageState extends State<WalletSettingPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: "钱包设置",
        titleBackgroundColor: Colors.white,
        titleColor: Mcolors.C333333,
        child: Column(
          children: [
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
                      onTap: () {
                        EditDialog.show(context, "支付宝账号", "13991281982",
                            isNumber: true, onConfirm: (val) {});
                      },
                      child: Row(
                        children: [
                          Text(
                            "13991281982  ",
                            style: TextStyle(
                                color: Mcolors.C666666, fontSize: 16.px),
                          ),
                          Image.asset(
                            'images/ic_right.png',
                            width: 9.px,
                            height: 9.px,
                          )
                        ],
                      ))
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
                      onTap: () {
                        EditDialog.show(
                            context, "银卡卡账号", "628991292192210901920010",
                            isNumber: true, onConfirm: (val) {});
                      },
                      child: Row(
                        children: [
                          Text(
                            "628991292192210901920010  ",
                            style: TextStyle(
                                color: Mcolors.C666666, fontSize: 16.px),
                          ),
                          Image.asset(
                            'images/ic_right.png',
                            width: 9.px,
                            height: 9.px,
                          )
                        ],
                      ))
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
