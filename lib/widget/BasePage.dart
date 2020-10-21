import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'MText.dart';

enum Status {
  LOADING,
  NONE,
  EMPTY,
  ERROR,
}

class BasePage extends StatelessWidget {
  final Status status;
  final String hint;
  final Widget child;
  final Widget customWidget;
  final enableRefresh;
  final List<Widget> _childrens = [];

  BasePage(
      {@required this.child,
      @required this.status,
      this.hint,
      this.customWidget,
      this.enableRefresh = true});

  @override
  Widget build(BuildContext context) {
    _childrens.clear();
    switch (status) {
      case Status.LOADING:
        _childrens.add(
          customWidget ??
              Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width:30.px,
                    height: 30.px,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Mcolors.accentColor),
                    ),
                  ),
                  MText(
                    "${(hint != null && hint != '') ? (hint + '\n') : '加载中...'}",
                    style: TextStyle(
                        fontSize: 15.px,
                        color: Mcolors.C666666,
                        height: 2),
                  )
                ]),
              ),
        );
        break;
      case Status.EMPTY:
        _childrens.add(
          customWidget ??
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "images/ic_no_pre.png",
                      width:94.px,
                    ),
                    MText(
                      "${(hint != null && hint != '') ? (hint + '\n') : '暂无数据'}",
                      style: TextStyle(
                          fontSize:15.px,
                          color: Mcolors.C8FCCFE,
                          height: 2.5),
                    ),
                  ],
                ),
              ),
        );
        _childrens.add(
          ListView(
            physics: enableRefresh ? null : NeverScrollableScrollPhysics(),
            children: <Widget>[],
          ),
        );
        break;
      case Status.ERROR:
        _childrens.add(
          customWidget ??
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset(
                      "images/error.svg",
                      width:94.px,
                    ),
                    MText(
                      "${(hint != null && hint != '') ? (hint + '\n') : ''}请下拉刷新重试",
                      style: TextStyle(
                        fontSize: 15.px,
                        color: Mcolors.CCCCCCC,
                      ),
                    ),
                  ],
                ),
              ),
        );
        _childrens.add(
          ListView(
            physics: enableRefresh ? null : NeverScrollableScrollPhysics(),
            children: <Widget>[],
          ),
        );
        break;
      default:
        _childrens.add(child);
        break;
    }

    return Stack(
      children: _childrens,
    );
  }
}
