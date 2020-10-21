import 'dart:ui';

import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:flutter/material.dart';

import 'MText.dart';

class MyBottomNavigationBar extends StatefulWidget {
  Function callBack;
  var vps;
  MyBottomNavigationBar({
    Key key,
    this.callBack,
  }) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  var _tabImages;
  var _appBarTitles;
  int _currentPageIndex;

  Widget getTabImage(path,isSelect) {
    return  isSelect ?Image.asset(
      path,
      width: 20.px,
      height:  20.px,
      color: Mcolors.primaryColor,
    ):Image.asset(
      path,
      width: 20.px,
      height:  20.px,

    );
  }

  Widget getTabIcon(int curIndex) {
    if (curIndex == _currentPageIndex) {
      return _tabImages[curIndex][1];
    } else
      return _tabImages[curIndex][0];
  }

  void initData() {
    _currentPageIndex = 0;
    _appBarTitles = ['首页', '我的'];
    _tabImages = [
      [getTabImage('images/tab_home.png',false), getTabImage('images/tab_home_s.png',true)],

      [getTabImage('images/tab_mine.png',false), getTabImage('images/tab_mine_s.png',true)]
    ];
  }

  MText getTabTitle(int curIndex) {
    if (curIndex == _currentPageIndex) {
      return MText(
        _appBarTitles[curIndex],
        style: TextStyle(
            color: Mcolors.primaryColor, fontSize: 12.px, height: 1.6),
      );
    } else {
      return MText(
        _appBarTitles[curIndex],
        style: TextStyle(
            color: Mcolors.C999999, fontSize: 12.px, height: 1.6),
      );
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  update(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  48.px + SizeUtils.bottomBar,
      padding: EdgeInsets.only(top:  8.px),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(27, 75, 157, 0.08), //阴影颜色
            blurRadius: 8,
            offset: Offset(0, -1)),
      ]),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                update(0);
                handleCallBack(0, widget.callBack);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    getTabIcon(0),
                    getTabTitle(0),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                update(1);
                handleCallBack(1, widget.callBack);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    getTabIcon(1),
                    getTabTitle(1),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  void handleCallBack(int index, Function callBack) {
    if (callBack != null) {
      callBack(index);
    }
  }
}
