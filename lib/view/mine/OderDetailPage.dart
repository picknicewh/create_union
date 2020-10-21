import 'package:createunion/http/Api.dart';
import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/Constant.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/view/home/ProjectSubmitPage.dart';
import 'package:createunion/view/home/RechargePage.dart';
import 'package:createunion/view/wallet/WalletPage.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/ConfirmDialog.dart';
import 'package:createunion/widget/CustomDotBuilder.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:createunion/widget/Marquee.dart';
import 'package:createunion/widget/PhotoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OderDetailPage extends StatefulWidget {
  Map projectInfo;

  OderDetailPage(this.projectInfo);

  @override
  _OderDetailPageState createState() => _OderDetailPageState();
}

class _OderDetailPageState extends State<OderDetailPage> {
  Map status;
  List pictureList = [
    {
      "path":
          "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png"
    },
    {
      "path":
          "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png"
    },
    {
      "path":
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3746149156,3846202622&fm=26&gp=0.jpg"
    },
    {
      "path":
          "https://wanandroid.com/blogimgs/bfcf57e5-aa5d-4ca3-9ca9-245dcbfd31e9.png"
    },
    {
      "path":
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603260774857&di=c435408716d44725767da4284ca6e8a3&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F06%2F02%2F19300534106437134465026151672.jpg"
    },
    {
      "path":
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603260774858&di=6c4bbb0fed8515cc50afaa8cad2e4797&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F18%2F56%2F14300000958002128488569856508.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();
    status = exchangeStatus(widget.projectInfo["status"]);
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: "项目详情",
        child: Column(
          children: [
            Line(),
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: status["status"] == "待审核" ? 90.px : 120.px,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.px, horizontal: 20.px),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Mcolors.CDFEFFB,
                        offset: Offset(0, 1),
                        blurRadius: 3.px),
                  ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              status["status"],
                              style: TextStyle(
                                  color: status["color"], fontSize: 18.px),
                            ),
                            Container(
                              height: 12.px,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  status["desc"],
                                  style: TextStyle(
                                      color: Mcolors.C999999, fontSize: 18.px),
                                ),
                                Offstage(
                                  offstage: status["status"] != "已通过",
                                  child: GestureDetector(
                                    onTap: () {
                                      RouteHelper.pushWidget(
                                          context, WalletPage());
                                    },
                                    child: Text(
                                      "立即查看",
                                      style: TextStyle(
                                          color: Mcolors.C3AC9A8,
                                          decoration: TextDecoration.underline,
                                          fontSize: 18.px),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Offstage(
                        offstage: status["status"] == "待审核",
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: MText(
                                "处理人: 李天琪",
                                style: TextStyle(
                                  color: Mcolors.C666666,
                                  fontSize: 12.px,
                                ),
                              ),
                            ),
                            MText(
                              "处理时间: 2020-10-21 11:01",
                              style: TextStyle(
                                color: Mcolors.C666666,
                                fontSize: 12.px,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.px),
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.px, vertical: 10.px),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Mcolors.CDFEFFB,
                          offset: Offset(0, 1),
                          blurRadius: 3.px),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.px, bottom: 20.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 10.px,
                                width: 2.px,
                                color: Mcolors.primaryColor,
                                margin: EdgeInsets.only(right: 6.px),
                              ),
                              Expanded(
                                child: MText(
                                  "提交详情",
                                  style: TextStyle(
                                      color: Mcolors.C333333,
                                      fontSize: 16.px,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              MText(
                                "2020-10-21 11:13",
                                style: TextStyle(
                                  color: Mcolors.C999999,
                                  fontSize: 14.px,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MText(
                              "图片信息",
                              style: TextStyle(
                                fontSize: 16.px,
                                color: Mcolors.C666666,
                              ),
                            ),
                            Container(
                              height: 10.px,
                            ),
                            Container(
                              height: 85.px * ((pictureList.length / 4).ceil()),
                              alignment: Alignment.center,
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 5.px,
                                          crossAxisSpacing: 5.px,
                                          crossAxisCount: 4,
                                          childAspectRatio: 1),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        RouteHelper.pushWidget(
                                            context,
                                            PhotoView(
                                                imgs: pictureList,
                                                currentIndex: index));
                                      },
                                      child: Container(
                                        width: 75.px,
                                        height: 75.px,
                                        color: Mcolors.CF0F0F0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.px),
                                          child: Image.network(
                                            '${pictureList[index]["path"]}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: pictureList.length),
                            ),
                            Line(
                              color: Mcolors.CE9E9E9,
                              marginTop: 5.px,
                              marginBottom: 10.px,
                            ),
                            MText(
                              "文字信息",
                              style: TextStyle(
                                fontSize: 16.px,
                                color: Mcolors.C666666,
                              ),
                            ),
                            Container(
                              height: 10.px,
                            ),
                            MText(
                              "这里是提交的文字信息，在通用文字识别（标准版）的基础上，提供更高精度的识别服务，支持更多语种识别（丹麦语、荷兰语、马来语、瑞典语、印尼语、波兰语、罗马尼亚语、土耳其语、希腊语、匈牙利语），并将字库从1w+扩展到2w+，能识别所有常用字和大部分生僻字",
                              style: TextStyle(
                                fontSize: 14.px,
                                color: Mcolors.C333333,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),

//
              ],
            )),
            Offstage(
              offstage: status["status"] == "待审核" || status["status"] == "已通过",
              child: GestureDetector(
                onTap: () {
                  if (widget.projectInfo["available"]) {
                    RouteHelper.pushWidget(context, ProjectSubmitPage());
                  } else {
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
                    "重新提交",
                    style: TextStyle(color: Mcolors.white, fontSize: 18.px),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Map exchangeStatus(String status) {
    Map sort = {
      "status": "待审核",
      "color": Mcolors.primaryColor,
      "desc": "审核中，请耐心等待....."
    };
    if (status == "wait_heck") {
      sort = {
        "status": "待审核",
        "color": Mcolors.CFEA101,
        "desc": "审核中，请耐心等待....."
      };
    } else if (status == "pass") {
      sort = {"status": "已通过", "color": Mcolors.C3AC9A8, "desc": "审核通过，佣金已到账"};
    } else if (status == "reject") {
      sort = {
        "status": "已拒绝",
        "color": Mcolors.CFA5051,
        "desc": "审核拒绝，请查看您提交的信息是否正确"
      };
    } else if (status == "less") {
      sort = {
        "status": "缺材料",
        "color": Mcolors.CFA5051,
        "desc": "缺少材料，请添加您提交的材料"
      };
    }
    return sort;
  }
}
