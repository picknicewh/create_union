import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/Toast.dart';
import 'package:flutter/material.dart';

class EditDialog extends Dialog {
 final String title;
 final String content;
 final bool isNumber;
 final  Function(String content) onConfirm;

  EditDialog({this.title, this.content, this.isNumber=false, this.onConfirm});

  static void show(context, title, content, {isNumber, onConfirm}) {
    showDialog(
        context: context,
        builder: (context) => EditDialog(
              title: title,
              content: content,
              isNumber: isNumber,
              onConfirm: onConfirm,
            ));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = content;
    return Center(
      child: Container(
        width: 270.px,
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
                padding: EdgeInsets.symmetric(vertical: 10.px),
                child: Text(
                  title ?? "修改参数",
                  style: TextStyle(
                      color: Mcolors.C333333,
                      fontSize: 16.px,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                height: 36.px,
                padding: EdgeInsets.symmetric(horizontal: 5.px),
                margin: EdgeInsets.symmetric(horizontal: 10.px),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.px),
                    border: Border.all(color: Mcolors.CE9E9E9, width: 1.px)),
                child: TextField(
                  keyboardAppearance: Brightness.light,
                  maxLength: 20,
                  maxLines: 1,
                  controller: _controller,
                  keyboardType:
                      isNumber ? TextInputType.number : TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    isDense: true,
                    counterText: "",
                    border: InputBorder.none,
                    hintText: "请输入",
                    hintStyle: TextStyle(
                      fontSize: 14.px,
                      color: Mcolors.CCCCCCC,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14.px,
                    color: Mcolors.C333333,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5.px))),
                          child: Container(
                            height: 48.px,
                            alignment: Alignment.center,
                            child: Text(
                              "取消",
                              softWrap: false,
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 16.px,
                              ),
                            ),
                          )),
                    ),
                  ),
                  Line(height: 18.px, width: 0.5),
                  Expanded(
                      child: Container(
                    child: FlatButton(
                        onPressed: () {
                          if (_controller.text.isEmpty) {
                            Toast.toast("您还没有输入内容");
                            return;
                          }
                          Navigator.pop(context);
                          handleCallBack(onConfirm, _controller.text ?? "");
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5.px))),
                        child: Container(
                            height: 48.px,
                            alignment: Alignment.center,
                            child: Text(
                              "确认",
                              style: TextStyle(
                                color: Mcolors.C333333,
                                fontSize: 16.px,
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

  void handleCallBack(Function callBack, content) {
    if (callBack != null) {
      callBack(content);
    }
  }
}
