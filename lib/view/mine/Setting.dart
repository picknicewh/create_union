import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/widget/ConfirmDialog.dart';
import 'package:createunion/widget/EditDialog.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController nickController = TextEditingController();
  String headPicurl = '';
  String phone = "13735484622";

  @override
  void initState() {
    if (!mounted) {
      return;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: '账号设置',
        child: Column(
          children: <Widget>[
            Line(
              color: Mcolors.CE8E8E8,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.px),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          left: 24.px, right: 20.px),
                      height: 50.px,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('账号',
                              style: TextStyle(
                                  fontSize: 15.px,
                                  color: Color(0xff4A4A4A))),
                          Text(StringRegUtils.handleThePhoneStr(phone),
                              style: TextStyle(
                                  fontSize:  15.px,
                                  color: Mcolors.C4A4A4A)),
                        ],
                      )),
                  Line(),
                  Container(
                      padding: EdgeInsets.only(left: 24.px, right: 20.px),
                      height: 50.px,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('工号',
                              style: TextStyle(
                                  fontSize: 15.px, color: Mcolors.C4A4A4A)),
                          Text("468281",
                              style: TextStyle(
                                  fontSize: 15.px, color: Mcolors.C4A4A4A)),
                        ],
                      )),
                  Line(),
                  Container(
                      padding: EdgeInsets.only(left: 24.px, right: 20.px),
                      height: 50.px,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('身份证号',
                              style: TextStyle(
                                  fontSize: 15.px, color: Mcolors.C4A4A4A)),
                          Text("360222199309044725",
                              style: TextStyle(
                                  fontSize: 15.px, color: Mcolors.C4A4A4A)),
                        ],
                      )),
                ],
              ),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Mcolors.CDFEFFB,
                  offset: Offset(0, 1),
                  blurRadius:  3.px,
                )
              ]),
            ),

            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    EditDialog.show(context, "紧急联系人", "李天祺",isNumber:false,onConfirm: (val){

                    });
                  },
                  child:  Container(
                      padding: EdgeInsets.only(left: 24.px, right: 20.px),
                      height: 50.px,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child:   Text('紧急联系人',
                              style: TextStyle(
                                  fontSize: 15.px, color: Mcolors.C4A4A4A)),),
                          Text("李天祺  ",
                              style: TextStyle(
                                  fontSize: 15.px, color: Mcolors.C4A4A4A)),
                          Image.asset(
                            'images/ic_right.png',
                            width: 9.px,
                            height: 9.px,
                          )
                        ],
                      )),
                ),

                Line(),
               GestureDetector(
                 onTap: (){
                   EditDialog.show(context, "手机号", "13735484622",isNumber: false,onConfirm: (val){

                   });
                 },
                 child:  Container(
                     padding: EdgeInsets.only(left: 24.px, right: 20.px),
                     height: 50.px,
                     color: Colors.white,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Expanded(child:Text('手机号',
                             style: TextStyle(
                                 fontSize: 15.px, color: Mcolors.C4A4A4A))),
                         Text("13735484622  ",
                             style: TextStyle(
                                 fontSize: 15.px, color: Mcolors.C4A4A4A)),
                         Image.asset(
                           'images/ic_right.png',
                           width: 9.px,
                           height: 9.px,
                         )
                       ],
                     )),
               )
              ],
            ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                          content: "你确定要退出账号吗？",
                          onConfirm: () {

                          },
                          onCancel: () {},
                        );
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.px),
                  padding: EdgeInsets.symmetric(horizontal:24.px),
                  height:50.px,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Mcolors.CDFEFFB,
                      offset: Offset(0, 1),
                      blurRadius: 3.px,
                    )
                  ]),
                  child: Text('退出登录',
                      style: TextStyle(
                          fontSize:14.px,
                          color: Color(0xff4A4A4A),
                          fontWeight: FontWeight.bold)),
                ))
          ],
        ));
  }

}
