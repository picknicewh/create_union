import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashLine extends StatelessWidget {
//   double width; //总宽度
  final double height; //总高度
  final Color color; //分割线颜色
  final double dashWidth; //虚线长度
  final double width;
  DashLine({this.height = 1,this.width, this.color = Colors.black, this.dashWidth = 5.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //可以返回一个根据父view 的size 创建的view ,  BoxConstraints  存储父view 的信息
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = width??constraints.constrainWidth();
        final dashWidth = this.dashWidth;
        final dashHeight = height; //虚线高度
        final dashCount = (boxWidth / (1.5 * dashWidth)).floor(); //虚线数量
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
