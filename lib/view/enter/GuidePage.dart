import 'package:createunion/utils/Constant.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SPUtils.dart';

import 'package:createunion/view/enter/LoginPage.dart';
import 'package:createunion/view/home/HomePage.dart';
import 'package:createunion/widget/Toast.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<StatefulWidget> {
  @override
  void initState() {
    super.initState();
    SPUtils.getString(Constant.TOKEN).then((token) {
      if (token == null || token.isEmpty) {
        RouteHelper.pushWidget(context, LoginPage(), replaceCurrent: true);
      } else {
        RouteHelper.pushWidget(context, HomePage(), replaceCurrent: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }

//  requestAuthor() {
//    SPUtils.getString(Constant.TOKEN).then((token) {
//      if (token == null || token.isEmpty)
//        RouteHelper.pushWidget(context, LoginPage(), replaceCurrent: true);
//      else {
//        Constant.appContext.read<UserInfo>().setToken(token);
//        LoginViewModel().getUserInfo().then((data) {
//          if (data["state"] == 200) {
//            if (data["results"] != null && data["results"]["bizRole"] != null) {
//              if (data["results"]["bizRole"]["roleLevel"] == 1) {
//                Toast.toast("您的账号暂无权限，请联系医院管理员");
//              }
//              Constant.appContext.read<UserInfo>().update(data["results"]);
//              RouteHelper.pushWidget(context, HomePage(), replaceCurrent: true);
//            } else
//              RouteHelper.pushWidget(context, LoginPage(), replaceCurrent: true);
//          } else if (data["state"] == 4001 && data["subCode"] == "40086") {
//            //当前账号是游客
//            SPUtils.getString(Constant.PHONE).then((phone){
//              LoginViewModel().getAuthenticationDetail(phone).then((res) {
//                if (res["state"] == 200) {
//                  Constant.appContext.read<UserInfo>().updateAuth(
//                      res["results"]);
//                  RouteHelper.pushWidget(context, HomePage(), replaceCurrent: true);
//                }
//              });
//            });
//          } else {
//            String message = (data["msg"] ?? "") + "-" + data["subMsg"];
//            Toast.toast(message ?? "网络异常，稍后重试");
//            RouteHelper.pushWidget(context, LoginPage(), replaceCurrent: true);
//          }
//        }).catchError((onError) {
//          RouteHelper.pushWidget(context, LoginPage(), replaceCurrent: true);
//        });
//      }
//    });
//  }
}
