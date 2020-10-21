import 'package:createunion/utils/SizeUtils.dart';
import 'package:flutter/material.dart';


class Line extends StatelessWidget {
  Color color;
  double width;
  double height;
  double marginLeft;
  double marginTop;
  double marginRight;
  double marginBottom;

  Line(
      {this.color,
      this.width,
      this.height = 0.5,
      this.marginLeft = 0.0,
      this.marginTop = 0.0,
      this.marginRight = 0.0,
      this.marginBottom = 0.0})
      : assert(marginLeft != null),
        assert(marginTop != null),
        assert(marginRight != null),
        assert(marginBottom != null);

  @override
  Widget build(BuildContext context) {
    if (width != null && height != null)
      return Container(
        width:width.px,
        height: height.px,
        margin: EdgeInsets.only(
            left: marginLeft ??= 0.0,
            top: marginTop ??= 0.0,
            right: marginRight ??= 0.0,
            bottom: marginBottom ??= 0.0),
        color: color ??= Color(0xffECECEC),
      );
    else if (width != null && height == null) {
      return Container(
        width:width.px,
        margin: EdgeInsets.only(
            left: marginLeft ??= 0.0,
            top: marginTop ??= 0.0,
            right: marginRight ??= 0.0,
            bottom: marginBottom ??= 0.0),
        color: color ??= Color(0xffECECEC),
      );
    } else if (width == null && height != null) {
      return Container(
        height:height.px,
        margin: EdgeInsets.only(
            left: marginLeft ??= 0.0,
            top: marginTop ??= 0.0,
            right: marginRight ??= 0.0,
            bottom: marginBottom ??= 0.0),
        color: color ??= Color(0xffECECEC),
      );
    } else
      // Divider();
      // VerticalDivider();
      return Container();
  }
}
