import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


///重置密码页面
class ResetPassword extends StatefulWidget {
  final String phoneNumber;
  final String pushFrom;

  ResetPassword({this.phoneNumber, this.pushFrom});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passController =
      TextEditingController.fromValue(TextEditingValue(text: ""));
  final TextEditingController _repassController =
      TextEditingController.fromValue(TextEditingValue(text: ""));
  bool enable = false; //是否填写完整
  bool canSeePass = true; //是否查看密码
  bool canSeeRePass = true; //是否查看密码

  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }

  @override
  Widget build(BuildContext mContext) {
    return FullBasePage(
      title: "修改密码",
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          unFocus(mContext);
        },
        child: Column(
          children: <Widget>[
            Container(
                height: 80.px,
                padding: EdgeInsets.only(left: 24.px),
                alignment: Alignment.centerLeft,
                child: Text(
                  "设置新密码",
                  style: TextStyle(
                    color: Mcolors.C333333,
                    fontSize: 28.px,
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.px),
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
                          keyboardAppearance: Brightness.light,

                          obscureText: canSeePass,
                          maxLength: 32,
                          controller: _passController,
                          style: TextStyle(
                              color:Mcolors.C333333,
                              fontSize: 16.px,
                              fontFamily: ''),
                          onChanged: (s) {
                            setState(() {
                              //  isPassword = s.length>0;
                              if (s.length > 0 &&
                                  _repassController.text.length > 0)
                                enable = true;
                              else
                                enable = false;
                            });
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            counterText: '',
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  canSeePass = !canSeePass;
                                });
                              },
                              child: Image.asset(
                                !canSeePass
                                    ? "images/login_open.png"
                                    : "images/login_close.png",
                                width: 18.px,
                                height: 18.px,
                              ),
                            ),
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Mcolors.CE8E8E8, //边框颜色为绿色
                              width: 1, //宽度为5
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color:Mcolors.primaryColor, //边框颜色为绿色
                              width: 1, //宽度为5
                            )),
                            hintText: "请输入密码",
                            hintStyle: TextStyle(
                                color: Mcolors.CCCCCCC,
                                fontSize: 16.px,
                                height: 1.0),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: 64.px,
                    width: SizeUtils.screenW - 48.px,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          keyboardAppearance: Brightness.light,
                          obscureText: canSeeRePass,
                          controller: _repassController,
                          maxLines: 1,
                          style: TextStyle(
                              color: Mcolors.C333333,
                              fontSize: 16.px,
                              fontFamily: ''),
                          onChanged: (s) {
                            setState(() {
                              //isRePassword = s.length>0;
                              if (s.length > 0 &&
                                  _passController.text.length > 0)
                                enable = true;
                              else
                                enable = false;
                            });
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  canSeeRePass = !canSeeRePass;
                                });
                              },
                              child: Image.asset(
                                !canSeeRePass
                                    ? "images/login_open.png"
                                    : "images/login_close.png",
                                width: 18.px,
                                height: 18.px,
                              ),
                            ),
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Mcolors.CE8E8E8, //边框颜色为绿色
                              width: 1, //宽度为5
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Mcolors.primaryColor, //边框颜色为绿色
                              width: 1, //宽度为5
                            )),
                            hintText: "请确认密码",
                            hintStyle: TextStyle(
                                color: Mcolors.CCCCCCC,
                                fontSize: 16.px,
                                height: 1.0),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 32.px, left: 24.px, right: 24.px),
              height: 48.px,
              child: RaisedButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.px)),
                ),
                onPressed: enable
                    ? () {
                        unFocus(mContext);

                        // 登录到首页
                        if (_passController.text != _repassController.text) {
                          Toast.toast('两次输入不一致');
                          return;
                        }

                        /// 数字  大小写字母 以及特殊字符 至少包含两种
                        // 正则
                        bool match = RegExp(
                                r"^(?![A-Z]*$)(?![a-z]*$)(?![0-9]*$)(?![^a-zA-Z0-9]*$)\S+")
                            .hasMatch(_repassController.text);
                        if (!match ||
                            _repassController.text.length < 6 ||
                            _repassController.text.length > 32) {
                          Toast.toast('请输入6-32个字符,至少包含数字、大写字母、小写字母、特殊字符中的两种类型');
                          return;
                        }
                      }
                    : null,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          enable ? Mcolors.primaryColor :Mcolors.CCCCCCC,
                          enable ? Mcolors.primaryColor:Mcolors.CCCCCCC,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4.px)),
                  child: Text(
                    "确定",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.px,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
