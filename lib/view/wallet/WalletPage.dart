import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/view/wallet/CashOutPage.dart';
import 'package:createunion/view/wallet/WalletSettingPage.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  List detailList = [1, 2, 4, 4];

  //当前列表的状态0--没有更多，1上拉加载更多
  bool currentListStatus = true;
  int _page = 1;
  ScrollController _scrollController;

  Status mStatus = Status.NONE;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: "钱包",
        titleBackgroundColor: Colors.white,
        titleColor: Mcolors.C333333,

        rightWidget: GestureDetector(
          onTap: () {
            RouteHelper.pushWidget(context, WalletSettingPage());
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16.px),
            child: MText(
              "设置",
              style: TextStyle(color: Mcolors.C666666, fontSize: 14.px),
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 140.px,
              width: SizeUtils.screenW,
              margin: EdgeInsets.only(left: 20.px, right: 20.px, top: 20.px,bottom: 10.px),
              padding: EdgeInsets.only(left: 18.px, right: 18.px, top: 18.px),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg_wallet.png'),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "可提现金额（元）",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.px,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.px, bottom: 10.px),
                          child: Text(
                            '0.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.px,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: (){
                        RouteHelper.pushWidget(context, CashOutPage());
                      },
                      child: Container(
                        height: 28.px,
                        width: 66.px,
                        decoration: BoxDecoration(
                          color: Mcolors.C66E5983E,
                          borderRadius: BorderRadius.circular(4.px),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/tixian.png',
                              height: 12.px,
                            ),
                            Text(
                              "  提现",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.px,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    right: 0,
                    top: 0,
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    child:Container(
                      color: Mcolors.white,
                      height: 60.px,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '￥0.00',
                            style: TextStyle(
                              color: currentIndex == 1
                                  ? Mcolors.C333333
                                  : Mcolors.primaryColor,
                              fontSize: 16.px,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(height: 8.px),
                          Text(
                            "待结算总金额",
                            style: TextStyle(
                              color: currentIndex == 1
                                  ? Mcolors.C999999
                                  : Mcolors.primaryColor,
                              fontSize: 16.px,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Line(width: 1.px,),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: Container(
                      color: Mcolors.white,
                      height: 60.px,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '￥0.00',
                            style: TextStyle(
                              color: currentIndex == 0
                                  ? Mcolors.C333333
                                  : Mcolors.primaryColor,
                              fontSize: 16.px,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(height: 8.px),
                          Text(
                            "本月总成单金额",
                            style: TextStyle(
                              color: currentIndex == 0
                                  ? Mcolors.C999999
                                  : Mcolors.primaryColor,
                              fontSize: 16.px,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                child: BasePage(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.px),
                    itemCount: detailList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == detailList.length)
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 20.px),
                          alignment: Alignment.center,
                          child: Text(
                            currentListStatus ? "上拉加载更多" : "没有更多了",
                            style: TextStyle(
                              color: Mcolors.CCCCCCC,
                              fontSize: 14.px,
                            ),
                          ),
                        );
                      else {
                        return _itemBuilder(context, index);
                      }
                    },
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                  ),
                  status: mStatus,
                ),
                onRefresh: _onRefresh,
              ),
            ),
          ],
        ));
  }

  Future _onRefresh() async {
    _page = 1;
  }

  Widget _itemBuilder(context, index) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 20.px,
          vertical: 16.px,
        ),
        margin: EdgeInsets.only(bottom: 1.px),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.px),
              child: Image.asset(
                'images/ic_wallet_m.png',
                width: 20.px,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "项目一的收款啊 ",
                    style: TextStyle(
                      color: Mcolors.C333333,
                      fontSize: 15.px,
                      height: 1.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "2020年10月15日 14:39",
                    style: TextStyle(
                      color: Mcolors.C999999,
                      fontSize: 12.px,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "+10.00",
              style: TextStyle(
                color: Mcolors.primaryColor,
                fontSize: 16.px,
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
