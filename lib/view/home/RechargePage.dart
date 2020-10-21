import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/view/home/PayPage.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:flutter/material.dart';

class RechargePage extends StatefulWidget {
  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  List rechargeList = [
    {"price": "1", "oldPrice": "1", "count": "1", "type": "number"},
    {"price": "9.9", "oldPrice": "10", "count": "10", "type": "number"},
    {"price": "89.9", "oldPrice": "100", "count": "100", "type": "number"},
    {"price": "5.9", "oldPrice": "7", "count": "7", "type": "day"},
    {"price": "18.9", "oldPrice": "30", "count": "30", "type": "day"},
    {"price": "288", "oldPrice": "365", "count": "1", "type": "year"},
  ];
   int currentIndex=-1;
  @override
  Widget build(BuildContext context) {
    return FullBasePage(
      title: "充值",
      child: Column(
        children: [
          Line(),
          GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.px, vertical: 20.px),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10.px,
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.95,
              ),
              itemBuilder: _itemBuilder,
              itemCount: rechargeList.length),
          GestureDetector(
            onTap:(){
              RouteHelper.pushWidget(context, PayPage());
            },
            child:Container(
              margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 20.px),
              height: 48.px,
              decoration: BoxDecoration(
                  color: Mcolors.primaryColor,
                  borderRadius: BorderRadius.circular(24.px)),
              alignment: Alignment.center,
              child: Text(
                "立即充值",
                style: TextStyle(color: Mcolors.white, fontSize: 18.px),
              ),
            ) ,
          )

        ],
      ),
    );
  }

  Widget _itemBuilder(context, index) {
    Map item = rechargeList[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Mcolors.white,
            border: Border.all(color:currentIndex==index?Mcolors.primaryColor: Mcolors.CE8E8E8, width: 1),
            borderRadius: BorderRadius.circular(10.px)),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(StringRegUtils.safeGetMap(item, "count"),
                    style: TextStyle(color: Mcolors.C666666, fontSize: 18.px)),
                Text(
                  item["type"] == "number"
                      ? "次"
                      : item["type"] == "day"
                          ? "天"
                          : "年",
                  style: TextStyle(color: Mcolors.C666666, fontSize: 18.px),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "￥",
                  style:
                      TextStyle(color: Mcolors.primaryColor, fontSize: 18.px),
                ),
                Text(StringRegUtils.safeGetMap(item, "price"),
                    style: TextStyle(
                        color: Mcolors.primaryColor, fontSize: 26.px)),
              ],
            ),
            Text(
              "￥${item["oldPrice"]}",
              style: TextStyle(
                color: Mcolors.C999999,
                fontSize: 14.px,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
