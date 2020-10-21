import 'package:createunion/utils/SizeUtils.dart';
import 'package:flutter/material.dart';

import 'Line.dart';
import 'MText.dart';

class ConfirmDialog extends Dialog {
  String title;
  String content;
  VoidCallback onConfirm;
  VoidCallback onCancel;
  String cancelTitle;
  String confirmTitle;
  Color cancelColor;
  Color confirmColor;
  bool cancelHide;
  bool closePop;
  ConfirmDialog(
      {this.title,
      this.content,
      this.onConfirm,
      this.onCancel,
      this.cancelTitle = "取消",
      this.confirmTitle = "确定",
      this.cancelColor,
      this.confirmColor,
      this.cancelHide = false,
      this.closePop = false});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:270.px,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.px),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 20.px,
              ),
              Offstage(
                offstage: title == null,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 20.px,
                      right: 20.px,
                      bottom: 15.px),
                  alignment: Alignment.center,
                  child: MText(
                    title ?? "",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16.px,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 20.px, right: 20.px),
                alignment: Alignment.center,
                child: MText(
                  content ?? "",
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16.px,
                  ),
                ),
              ),
              Container(
                height: 20.px,
              ),
              Line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  cancelHide
                      ? Container()
                      : Expanded(
                          child: Container(
                            child: FlatButton(
                                onPressed: () {
                                  if (!closePop) Navigator.pop(context);
                                  handleCallBack(onCancel);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(5.px))),
                                child: Container(
                                  height: 48.px,
                                  alignment: Alignment.center,
                                  child: MText(
                                    cancelTitle,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: cancelColor ?? Color(0xFF333333),
                                      fontSize: 14.px,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                  cancelHide
                      ? Container()
                      : Line(height: 48.px, width: 0.5),
                  Expanded(
                      child: Container(
                    child: FlatButton(
                        onPressed: () {
                          if (!closePop) Navigator.pop(context);
                          handleCallBack(onConfirm);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(5.px))),
                        child: Container(
                            height: 48.px,
                            alignment: Alignment.center,
                            child: MText(
                              confirmTitle,
                              style: TextStyle(
                                color: confirmColor ?? Color(0xFF333333),
                                fontSize: 14.px,
                              ),
                            ))),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleCallBack(Function callBack) {
    if (callBack != null) {
      callBack();
    }
  }
}
