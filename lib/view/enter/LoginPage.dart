import 'dart:async';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/view/enter/MainPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/widget/CustomAppBar.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:createunion/widget/Toast.dart';


class LoginPage extends StatefulWidget {
  static final routerName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _useController =
  TextEditingController.fromValue(TextEditingValue(text: "111"));
  final TextEditingController _passController =
  TextEditingController.fromValue(TextEditingValue(text: "222222"));
  bool enable = false; //是否填写完整
  bool isPassword = false; //是否密码有内容
  bool canSeePass = true; //是否查看密码
  FocusNode _userFocus = FocusNode();
  FocusNode _passFocus = FocusNode();


  @override
  void initState() {
    super.initState();
    if (_useController.text.length > 0 && _passController.text.length > 0)
      enable = true;
    else
      enable = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () {
            _userFocus.unfocus();
            _passFocus.unfocus();
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CustomAppBar(
                    backColor: Colors.white,
                  ),
                  GestureDetector(
                    onLongPress: () {
                    },
                    child: Container(
                        height: 80.px,
                        padding: EdgeInsets.only(left: 24.px),
                        alignment: Alignment.centerLeft,
                        child: MText(
                          "欢迎登录",
                          style: TextStyle(
                              color: Mcolors.C333333,
                              fontSize: 28.px,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 64.px,
                          width: SizeUtils.screenW - 48.px,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    focusNode: _userFocus,
                                    maxLength: 11,
                                    controller: _useController,
                                    onChanged: (s) {
                                      setState(() {
                                        if (s.length > 0 &&
                                            _passController.text.length > 0)
                                          enable = true;
                                        else
                                          enable = false;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(20)
                                      //限制长度
                                    ],
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(_userFocus);
                                      _passFocus.unfocus();
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText:
                                      "请输入手机号",
                                      hintStyle: TextStyle(
                                          color: Mcolors.CCCCCCC,
                                          fontSize: 15.px,
                                          height: 1),
                                    ),
                                  )),
                              Offstage(
                                  offstage: _useController.text.length == 0,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _useController.text = "";
                                        });
                                      },
                                      child: Image.asset(
                                        "images/ic_user_del.png",
                                        width: 14.px,
                                      )))
                            ],
                          ),
                        ),
                        _userFocus.hasFocus
                            ? Line(
                            color: Mcolors.primaryColor,
                            height: 1.px)
                            : Line(
                          height: 1.px,
                        ),
                        Container(
                          height: 64.px,
                          width: SizeUtils.screenW - 48.px,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextField(
                                    obscureText:
                                    canSeePass,
                                    controller: _passController,
                                    focusNode: _passFocus,
                                    style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 16.px,
                                        fontFamily: ''),
                                    onChanged: (s) {
                                      setState(() {
                                        isPassword = s.length > 0;
                                        if (s.length > 0 &&
                                            _useController.text.length > 0)
                                          enable = true;
                                        else
                                          enable = false;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(20)
                                      //限制长度
                                    ],
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(_passFocus);
                                      _userFocus.unfocus();
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:  "请输入密码",
                                      hintStyle: TextStyle(
                                          color: Mcolors.CCCCCCC,
                                          fontSize: 15.px,
                                          height: 1.0),
                                    ),
                                  )),


                              GestureDetector(
                                onTap: () {
                                  if (isPassword) {
                                    setState(() {
                                      canSeePass = !canSeePass;
                                    });
                                  }
                                },
                                child: Image.asset(
                                  isPassword
                                      ? "images/ic_pass_open.png"
                                      : "images/ic_pass_close.png",
                                  width: 14.px,
                                ),
                              )

                            ],
                          ),
                        ),
                        _passFocus.hasFocus
                            ? Line(
                          color: Mcolors.primaryColor,
                          height: 1.px,
                        )
                            : Line(
                          height: 1.px,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 14.px,
                  ),
                  Material(
                    color: enable ? Mcolors.primaryColor : Mcolors.CCCCCCC,
                    borderRadius:
                    BorderRadius.all(Radius.circular(4.px)),
                    child: InkWell(
                      onTap:_login,
                      child: Container(
                        height: 48.px,
                        width: 327.px,
                        alignment: Alignment.center,
                        child: MText("登录",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.px)),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          bottom: 36.px, top: 15.px),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MText('登录即同意强创联合app',
                                style: TextStyle(
                                    fontSize: 14.px,
                                    color: Mcolors.C666666)),
                            GestureDetector(
                                onTap: () {
                                  /// 用户服务协议
//                                  RouteHelper.pushWidget(
//                                      context, WebViewPage(TYPE.AGREEMEMT));
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.px),
                                    child: MText('《用户服务协议》',
                                        style: TextStyle(
                                            fontSize: 12.px,
                                            color: Mcolors.primaryColor))))
                          ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    if (enable) {
      _unFocus(context);
   //   Toast.toastIndicator();
      RouteHelper.pushWidget(context, MainPage());
//      LoginViewModel()
//          .login(_useController.text ?? "", _passController.text ?? "")
//          .then((data) {
//        if (data["state"] == 200) {
//          Constant.appContext
//              .read<UserInfo>()
//              .setToken(data["results"]["access_token"]);
//          SPUtils.setString(Constant.TOKEN, data["results"]["access_token"]);
//          _getUserInfo();
//        } else {
//          Toast.toast(data["subMsg"] ?? "登录异常");
//        }
//      }).catchError((error) {
//        Toast.dissMiss();
//        Toast.toast("登录异常");
//      });
    }
  }


  _unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }

  @override
  void dispose() {
    super.dispose();

  }
}