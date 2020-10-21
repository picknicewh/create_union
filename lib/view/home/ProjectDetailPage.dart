import 'package:createunion/http/Api.dart';
import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/Constant.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/view/home/ProjectSubmitPage.dart';
import 'package:createunion/view/home/RechargePage.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/ConfirmDialog.dart';
import 'package:createunion/widget/CustomDotBuilder.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:createunion/widget/Marquee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProjectDetailPage extends StatefulWidget {
  Map projectInfo;

  ProjectDetailPage(this.projectInfo);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: "项目详情",
        child: Column(
          children: [
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Image.network(widget.projectInfo["path"],
                    width: SizeUtils.screenW, fit: BoxFit.fitWidth),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.px, horizontal: 15.px),
                  alignment: Alignment.centerLeft,
                  color: Mcolors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.projectInfo["name"] ?? "",
                        style: TextStyle(
                            color: Mcolors.C333333,
                            fontSize: 18.px,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.px, bottom: 5.px),
                        child: Text(
                          "￥" + widget.projectInfo["price"] ?? "",
                          style: TextStyle(
                              color: Mcolors.CFA5051,
                              fontSize: 18.px,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "李天祺",
                            style: TextStyle(
                              color: Mcolors.C666666,
                              fontSize: 14.px,
                            ),
                          )),
                          Text(
                            "2020年10月19日 14:01",
                            style: TextStyle(
                              color: Mcolors.C666666,
                              fontSize: 14.px,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 10.px),
                      Text(
                        "这里是项目简介啊，这里是项目简介啊，这里是项目简介啊，这里是项目简介啊，这里是项目简介啊,这里是项目简介啊，这里是项目简介啊",
                        style: TextStyle(
                            color: Mcolors.C666666,
                            fontSize: 14.px,
                            height: 1.2),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.px, horizontal: 15.px),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "操作流程",
                        style: TextStyle(
                            color: Mcolors.C333333,
                            fontSize: 20.px,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(height: 10.px),
                      Row(
                        children: [
                          Image.asset(
                            "images/ic_word.png",
                            width: 30.px,
                          ),
                          Text(
                            " 这里是文件的名称",
                            style: TextStyle(
                              color: Mcolors.C666666,
                              fontSize: 16.px,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
            GestureDetector(
              onTap: () {
                if(widget.projectInfo["available"]){
                  RouteHelper.pushWidget(context, ProjectSubmitPage());
                }else{
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmDialog(
                          title: "充值押金",
                          content: "你还未交押金，无押金则项目就无法进行操作，去充值押金？",
                          onConfirm: () {
                            RouteHelper.pushWidget(context, RechargePage());
                          },

                        );
                      });


                }


              },
              child: Container(
                height: 48.px,
                color: Mcolors.primaryColor,
                alignment: Alignment.center,
                child: Text(
                  "开始提交",
                  style: TextStyle(color: Mcolors.white, fontSize: 18.px),
                ),
              ),
            )
          ],
        ));
  }
}
