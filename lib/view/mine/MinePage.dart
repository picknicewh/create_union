import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/view/mine/AboutPage.dart';
import 'package:createunion/view/mine/MasterProjectPage.dart';
import 'package:createunion/view/mine/MyProjectPage.dart';
import 'package:createunion/view/mine/ResetPassword.dart';
import 'package:createunion/view/mine/Setting.dart';
import 'package:createunion/view/mine/MyUserListPage.dart';
import 'package:createunion/view/wallet/WalletPage.dart';
import 'package:createunion/widget/ConfirmDialog.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 240.px,
              ),
              Image.asset(
                "images/me_top_bg.png",
                height: 200.px,
                fit: BoxFit.cover,
                width: SizeUtils.screenW,
              ),
              Container(
                height: 200.px,
                //  color: Mcolors.C333333,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(36.px),
                      child: FadeInImage(
                        width: 36.px,
                        height: 36.px,
                        placeholder: AssetImage("images/ic_default_image.png"),
                        image: NetworkImage(
                            "https://www.wanandroid.com/resources/image/pc/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(height: 8.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "姓名",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.px,
                            color: Mcolors.C333333,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(width: 5.px),
                        Text(
                          "13735484622",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.px,
                            color: Mcolors.C666666,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                child: myTypeView(),
                left: 10.px,
                bottom: 10.px,
              )
            ],
          ),
          funItemView("me_setting", "用户管理"),
          funItemView("me_change_password", "修改密码"),
          funItemView("me_about", "关于"),
          funItemView("me_setting", "设置"),
        ],
      ),
    );
  }

  Widget myTypeView() {
    return Container(
      height: 80.px,
      width: SizeUtils.screenW - 20.px,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Mcolors.CDFEFFB, offset: Offset(0, 1), blurRadius: 3.px)
          ],
          borderRadius: BorderRadius.circular(4.px)),
      child: Row(children: [
        Expanded(
          child: GestureDetector(
              onTap: () {
             //   RouteHelper.pushWidget(context, MyProjectPage());
                RouteHelper.pushWidget(context, MasterProjectPage());
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 20.px),
                child: Row(children: [
                  ClipOval(
                      child: Container(
                    child: Image.asset(
                      'images/me_project.png',
                      width: 38.px,
                      height: 38.px,
                    ),
                  )),
                  Container(
                    width: 18.px,
                  ),
                  Text(
                    '我的项目',
                    style: TextStyle(fontSize: 15.px, color: Color(0xFF4A4A4A)),
                  )
                ]),
              )),
        ),
        Container(
          height: 26.px,
          color: Color(0x80CCCCCC),
          width: 1,
        ),
        Expanded(
          child: GestureDetector(
              onTap: () {
                 RouteHelper.pushWidget(context, WalletPage());
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 20.px),
                child: Row(children: [
                  ClipOval(
                      child: Container(
                    child: Image.asset(
                      'images/me_wallet.png',
                      width: 38.px,
                      height: 38.px,
                    ),
                  )),
                  Container(
                    width: 10.px,
                  ),
                  Text(
                    '我的钱包',
                    style: TextStyle(fontSize: 15.px, color: Color(0xFF4A4A4A)),
                  )
                ]),
              )),
        )
      ]),
    );
  }

  Widget funItemView(icon, title, {color}) {
    return GestureDetector(
        onTap: () {
          if (title == "设置") {
            RouteHelper.pushWidget(context, Setting());
          } else if (title == "修改密码") {
            RouteHelper.pushWidget(context, ResetPassword());
          }else if(title=="关于"){
            RouteHelper.pushWidget(context, AboutPage());
          }else if(title=="用户管理"){
            RouteHelper.pushWidget(context, MyUserListPage());
          }
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 10.px),
            height: 54.px,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.px),
              boxShadow: [
                BoxShadow(
                    color: Mcolors.CDFEFFB,
                    offset: Offset(0, 1),
                    blurRadius: 3.px)
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.px),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/$icon.png',
                  width: 20.px,
                  height: 20.px,
                  color: color,
                ),
                Container(width: 14.px),
                Text(
                  title,
                  style: TextStyle(fontSize: 16.px, color: Mcolors.C666666),
                ),
                Expanded(child: Container()),
                Image.asset(
                  'images/ic_right.png',
                  width: 9.px,
                  height: 9.px,
                )
              ],
            )));
  }



  @override
  void dispose() {
    super.dispose();
  }
}
