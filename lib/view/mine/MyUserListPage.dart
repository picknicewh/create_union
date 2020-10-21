import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/view/mine/OderDetailPage.dart';
import 'package:createunion/view/mine/UserManagerPage.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/ConfirmDialog.dart';
import 'package:createunion/widget/EditDialog.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:createunion/widget/PullListView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyUserListPage extends StatefulWidget {
  @override
  _MyUserListPageState createState() => _MyUserListPageState();
}

class _MyUserListPageState extends State<MyUserListPage> {
  Status mStatus = Status.NONE;
  List userList = [
    {
      "name": "李天琪",
      "count": "599",
      "gender":1,
      "idCard":"429006199405254814",
      'mobile':"13982761722",
      'isVertify':true
    },
    {
      "name": "姚小城",
      "count": "299",
      "gender":1,
      "idCard":"429006199405254814",
      "mobile":"13897127355",
      'isVertify':true
    },
    {
      "name": "周岑你",
      "count": "188",
      "gender":2,
      "idCard":"360222199405254816",
      "mobile":"13762836290",
      'isVertify':false
    },
    {
      "name": "夏至",
      "count": "358",
      "gender":1,
      "idCard":"360222199509124815",
      "mobile":"13762833802",
      'isVertify':false
    },
    {
      "name": "赵沁媛",
      "count": "288",
      "gender":2,
      "idCard":"429006199405254817",
      "mobile":"15937291762",
      'isVertify':true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: '用户管理',
        rightWidget: GestureDetector(
          onTap: (){
            RouteHelper.pushWidget(context, UserManagerPage(isEdit: false));
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16.px),
            child: MText("添加用户",style: TextStyle(color: Mcolors.C333333,fontSize: 14.px),),
          ),
        ),
        child: Column(
          children: <Widget>[
            Line(
              color: Mcolors.CE8E8E8,
            ),
            Expanded(
                child: PullListView(
              padding: EdgeInsets.only(top: 10.px),
              itemBuilder: _itemBuilder,
              getDataList: (currentState, page) {
                currentState.onRefreshData(userList);
              },
            )),
          
          ],
        ));
  }

  Widget _itemBuilder(context, index, userList) {
    var item = userList[index];
    String mobile = item['mobile'];
    bool isVertify = item["isVertify"]??false;
    return GestureDetector(
      onTap: (){
        RouteHelper.pushWidget(context, UserManagerPage(isEdit: true,userInfo: item));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        margin: EdgeInsets.only(bottom: 1.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.px),
                  child: Row(
                    children: <Widget>[
                      Text(
                        item['name'] ?? '',
                        style: TextStyle(
                          fontSize:  16.px,
                          color: Mcolors.C4A4A4A,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:  10.px),
                        child: Image.asset(
                            item['gender'] == 2
                                ? "images/b_female.png"
                                : "images/b_male.png",
                            height:16.px,
                            fit: BoxFit.cover),
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 12.px, bottom: 19.px),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '手机号码:  ',
                        style: TextStyle(
                          fontSize: 13.px,
                          color: Mcolors.C999999,
                        ),
                      ),
                      Text(
                        mobile ?? '',
                        style: TextStyle(
                          fontSize: 13.px,
                          color: Mcolors.C999999,
                        ),
                      ),


                    ],
                  ),
                ),
                Line(
                  marginRight: 5.px,
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 21.px),
              padding: EdgeInsets.only(left: 4.px, right: 4.px),
              height: 18.px,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isVertify ? Mcolors.C37C2BC : Mcolors.CCCCCCC,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.px)),
              ),
              child: Text(
                isVertify ? '已认证' : '未认证',
                style: TextStyle(
                  fontSize:12.px,
                  color: isVertify ? Mcolors.C37C2BC : Mcolors.CCCCCCC,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
