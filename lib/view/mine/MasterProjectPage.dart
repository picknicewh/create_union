import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/view/mine/OderDetailPage.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/ConfirmDialog.dart';
import 'package:createunion/widget/EditDialog.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/PullListView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MasterProjectPage extends StatefulWidget {
  @override
  _MasterProjectPageState createState() => _MasterProjectPageState();
}

class _MasterProjectPageState extends State<MasterProjectPage> {
  Status mStatus = Status.NONE;
  List projectList = [
    {
      "name": "抖音推广",
      "path":
          "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
      "price": "599",
      "available": false,
      "status": "wait_check"
    },
    {
      "name": "淘宝刷单",
      "path":
          "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png",
      "price": "299",
      "available": true,
      "status": "finish"
    },
    {
      "name": "问卷调查",
      "path":
          "https://wanandroid.com/blogimgs/bfcf57e5-aa5d-4ca3-9ca9-245dcbfd31e9.png",
      "price": "188",
      "available": false,
      "status": "making"
    },
    {
      "name": "工商银行推广",
      "path":
          "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
      "price": "288",
      "available": true,
      "status": "cancel"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: '我的项目',
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
                currentState.onRefreshData(projectList);
              },
            ))
          ],
        ));
  }

  Widget _itemBuilder(context, index, projectList) {
    var item = projectList[index];
    Map status = exchangeStatus(item["status"]);
    return GestureDetector(
      onTap: () {
        RouteHelper.pushWidget(context, OderDetailPage(item));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 12.px),
        margin: EdgeInsets.only(bottom: 10.px),
        decoration: BoxDecoration(
          color: Mcolors.white,
          boxShadow: [
            BoxShadow(
              color: Mcolors.CDFEFFB, //阴影颜色
              blurRadius: 2.px,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringRegUtils.safeGetMap(item, "name"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Mcolors.C333333,
                    fontSize: 16.px,
                  ),
                ),
                Text(
                  StringRegUtils.safeGetMap(status, "desc"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: status["color"],
                    fontSize: 16.px,
                  ),
                )
              ],
            ),
            Line(
              marginTop: 10.px,
              marginBottom: 10.px,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "￥${item["price"]}",
                  style: TextStyle(
                      color: Mcolors.CEC5348,
                      fontSize: 16.px,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "    李天琪",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Mcolors.C666666,
                    fontSize: 14.px,
                  ),
                ),
              ],
            ),
            Container(
              height: 8.px,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "2020-10-21 10:18",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Mcolors.C666666,
                    fontSize: 14.px,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Map exchangeStatus(String status) {
    Map sort = {
      "desc": "待审核",
      "color": Mcolors.primaryColor,
    };
    if (status == "wait_heck") {
      sort = {
        "desc": "待审核",
        "color": Mcolors.CFEA101,
      };
    } else if (status == "finish") {
      sort = {
        "desc": "已完成",
        "color": Mcolors.C3AC9A8,
      };
    } else if (status == "making") {
      sort = {
        "desc": "进行中",
        "color": Mcolors.CFA5051,
      };
    } else if (status == "cancel") {
      sort = {
        "desc": "已取消",
        "color": Mcolors.CFA5051,
      };
    }
    return sort;
  }
}
