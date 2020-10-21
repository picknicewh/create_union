import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';


import 'Toast.dart';

enum InputType { NAME, PHONE }

class InputDialog extends Dialog {
  String title;
  String content;
  Function onConfirm;
  Function onChange;
  Function onCancel;
  String cancelTitle;
  String confirmTitle;
  Color cancelColor;
  Color confirmColor;
  bool cancelHide;
  InputType inputType;
  TextEditingController _useCcontroller;
  String _content = '';

  InputDialog({
    Key key,
    this.title,
    this.content = "",
    this.onConfirm,
    this.onChange,
    this.onCancel,
    this.cancelTitle = "取消",
    this.confirmTitle = "确定",
    this.cancelColor,
    this.confirmColor,
    this.inputType,
    this.cancelHide = false,
  }) : super(key: key) {
    _useCcontroller =
        TextEditingController.fromValue(TextEditingValue(text: content ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StatefulBuilder(builder: (btContext, state) {
      return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width:227.px,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.px),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(height:20.px),
                Offstage(
                  offstage: title == null,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20.px,
                        right: 20.px,
                        bottom: 10.px),
                    alignment: Alignment.center,
                    child: MText(
                      title ?? "",
                      style: TextStyle(
                        color: Mcolors.C333333,
                        fontSize:14.px,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 15.px,
                      right: 15.px,
                      bottom: 20.px),
                  padding: EdgeInsets.symmetric(horizontal:8.px),
                  alignment: Alignment.center,
                  height: 30.px,
                  decoration: BoxDecoration(
                    border: Border.all(color: Mcolors.CCCCCCC),
                    borderRadius: BorderRadius.circular(3.px),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _useCcontroller,
                          autofocus: true,
                          style: TextStyle(
                            color: Mcolors.C333333,
                            fontSize: 14.px,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "请填写...",
                            hintStyle: TextStyle(
                              color: Mcolors.CCCCCCC,
                              fontSize: 14.px,
                            ),
                          ),
                          keyboardType: inputType == InputType.PHONE
                              ? TextInputType.phone
                              : TextInputType.text,
                          inputFormatters: inputType == InputType.PHONE
                              ? <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(11)
                                ]
                              : <TextInputFormatter>[],
                          onChanged: (s) {
                            state(() {
                              _content = s;
                            });
                            handleCallBack(_content, onChange);
                          },
                        ),
                      ),
                      Offstage(
                        offstage: _content.length == 0,
                        child: GestureDetector(
                          onTap: () {
                            state(() {
                              _useCcontroller.text = '';
                              _content = '';
                            });
                          },
                          child: Image.asset('images/ic_user_del.png',
                              color: Mcolors.CCCCCCC, width: 17.px),
                        ),
                      ),
                    ],
                  ),
                ),
                Line(color: Mcolors.CE8E8E8),
                Container(
                  height:40.px,
                  child: Row(
                    children: <Widget>[
                      cancelHide
                          ? Container()
                          : Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  handleCallBack(_content, onCancel);
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(5.px),
                                  ),
                                ),
                                child: Container(
                                  height: 40.px,
                                  alignment: Alignment.center,
                                  child: MText(
                                    cancelTitle,
                                    style: TextStyle(
                                      color: cancelColor ?? Mcolors.C999999,
                                      fontSize: 14.px,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      cancelHide
                          ? Container()
                          : Line(
                              height: 40.px,
                              width: 1.px,
                              color: Mcolors.CE8E8E8),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            if (_content.isEmpty)
                              Toast.toast("请输入内容");
                            else {
                              if (inputType == InputType.PHONE &&
                                  _content.length != 11)
                                Toast.toast("请输入正确的手机号");
                              else {
                                handleCallBack(_content, onConfirm);
                                Navigator.pop(context);
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5.px),
                            ),
                          ),
                          child: Container(
                            height: 40.px,
                            alignment: Alignment.center,
                            child: MText(
                              confirmTitle,
                              style: TextStyle(
                                color: confirmColor ?? Mcolors.primaryColor,
                                fontSize: 14.px,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  handleCallBack(String content, Function callBack) {
    if (callBack != null) {
      callBack(content);
    }
  }
}
