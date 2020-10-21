import 'package:createunion/http/Api.dart';
import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/Constant.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/view/home/ProjectDetailPage.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/CustomDotBuilder.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:createunion/widget/Marquee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  SwiperController mSwiperController;
  Status mStatus = Status.NONE;
  List bannerList = [
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
          "https://wanandroid.com/blogimgs/bfcf57e5-aa5d-4ca3-9ca9-245dcbfd31e9.png"
    }
  ];
  List projectList = [
    {
      "name": "抖音推广",
      "path":
          "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
      "price":"599",
      "available":false,
    },
    {
      "name": "淘宝刷单",
      "path":
          "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png",
      "price":"299",
      "available":true,
    },
    {
      "name": "问卷调查",
      "path":
          "https://wanandroid.com/blogimgs/bfcf57e5-aa5d-4ca3-9ca9-245dcbfd31e9.png",
      "price":"188",
      "available":false,
    },
    {
      "name": "在线打卡学习",
      "path":
          "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png",
      "price":"358",
      "available":false,
    },
    {
      "name": "工商银行推广",
      "path":
          "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
      "price":"288",
      "available":false,
    },
  ];

  @override
  void initState() {
    super.initState();
    mSwiperController = SwiperController();
    if (mSwiperController != null) {
      if (bannerList.length == 0) {
        mSwiperController.stopAutoplay();
      } else {
        mSwiperController.startAutoplay();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 16.px,
                  top: 5.px + SizeUtils.statusBar,
                  right: 16.px,
                  bottom: 5.px),
              //    margin: EdgeInsets.only(top: SizeUtils.statusBar, ),
              color: Colors.white,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36.px),
                    child: FadeInImage(
                      width: 36.px,
                      height: 36.px,
                      placeholder: AssetImage("images/ic_default_image.png"),
                      image: NetworkImage(
                          "https://www.wanandroid.com/resources/image/pc/logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 16.px,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MText(
                            "姓名",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16.px,
                              color: Mcolors.C333333,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(height: 5.px),
                          MText(
                            "13735484622",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14.px,
                              color: Mcolors.C666666,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    "images/ic_hint_msg.png",
                    width: 24.px,
                    color: Mcolors.C333333,
                  )
                ],
              ),
            ),
            Line(
              height: 1.px,
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                bannerList.isEmpty
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(
                            top: 10.px,
                            left: 10.px,
                            right: 10.px,
                            bottom: 5.px),
                        height: 106 / 361 * (SizeUtils.screenW - 15) + 30.px,
                        child: ClipRRect(
                          child: AspectRatio(
                            aspectRatio: 361 / 106,
                            child: Swiper(
                              onTap: (index) {},
                              itemCount: bannerList.length,
                              itemBuilder: bannerItemBuilder,
                              loop: false,
                              outer: false,
                              autoplay: true,
                              viewportFraction: 1,
                              scale: 0.95,
                              controller: mSwiperController,
                              pagination: SwiperPagination(
                                margin: EdgeInsets.only(bottom: 3.px),
                                builder: CustomDotBuilder(
                                    color: Color(0x87ffffff),
                                    activeColor: Mcolors.primaryColor,
                                    size: 3.px,
                                    activeSize: 3.px,
                                    // ratio: 2.px,
                                    space: 5.px,
                                    haveBorder: true),
                              ),
                            ),
                          ),
                        ),
                      ),
                noticeBarView(),
                projectList.isEmpty
                    ? Container(height: 1.px)
                    : Container(
                        padding: EdgeInsets.only(
                          left: 10.px,
                          right: 10.px,
                          bottom: 20.px,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 38.px,
                              alignment: Alignment.centerLeft,
                              child: MText(
                                "项目推荐",
                                style: TextStyle(
                                    color: Mcolors.C333333,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.px),
                              ),
                            ),
                            projectList.isEmpty
                                ? Container(
                                    color: Mcolors.CE8E8E8,
                                    height: 20.px,
                                  )
                                : ListView.builder(
                                    padding:
                                        EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: getRecommondItem,
                                    itemCount: projectList.length)
                          ],
                        ),
                      ),
              ],
            ))
          ],
        ));
  }

  //通知
  Widget noticeBarView() {
    List notice = ['呵呵,呵呵,呵呵', '琴键上彩绘的玻璃窗', '一段流浪,忧伤'];
    return Container(
        height: 40.px,
        margin: EdgeInsets.all(10.px),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: 20.px,
          right: 14.px,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Mcolors.CDFEFFB, offset: Offset(0, 1), blurRadius: 3.px)
        ], color: Colors.white, borderRadius: BorderRadius.circular(6.px)),
        child: Row(children: [
          Image.asset(
            'images/ic_home_notice.png',
            width: 18.px,
            height: 14.px,
            fit: BoxFit.cover,
          ),
          Container(width: 10.px),
          Expanded(
              child: Marquee(notice.length, (ctx, index) {
            return Container(
                alignment: Alignment.centerLeft,
                child: MText(
                  notice[index],
                  style: TextStyle(
                    fontSize: 15.px,
                    color: Mcolors.C666666,
                  ),
                  overflow: TextOverflow.ellipsis,
                ));
          }))
        ]));
  }

  Widget bannerItemBuilder(BuildContext context, int index) {
    Map bannerItem = bannerList.length > 0 ? bannerList[index] : {};
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xffececec),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6.px),
        boxShadow: [
          BoxShadow(
            color: Mcolors.CDFEFFB, //阴影颜色
            blurRadius: 2.px,
            offset: Offset(0, 1),
          )
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage('${bannerItem['path']}'),
          //  AssetImage("images/ic_banner.png"),
        ),
      ),
    );
  }

  Widget getRecommondItem(context, index) {
    var item = projectList[index];
    return GestureDetector(
      onTap: () {
        RouteHelper.pushWidget(context, ProjectDetailPage(item));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.px,vertical: 12.px),
        margin: EdgeInsets.only(bottom: 10.px),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(6.px),
          color: Mcolors.white,
          boxShadow: [
            BoxShadow(
              color: Mcolors.CDFEFFB, //阴影颜色
              blurRadius: 2.px,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(

              child: Container(
                color: Mcolors.CF0F0F0,
                width: 120.px,
                margin: EdgeInsets.only(
                  left: 5.px,
                ),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('images/ic_home_video.png'),
                  image: NetworkImage(item["path"]),
                ),
              ),
              borderRadius: BorderRadius.circular(4.px),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10.px,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MText(
                    StringRegUtils.safeGetMap(item, 'name'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Mcolors.C333333,
                        fontSize: 14.px,
                        fontWeight: FontWeight.bold,
                        height: 1.2),
                  ),
                  Container(height: 10.px),
                  MText(
                     "这里是项目的简介啊啊",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Mcolors.C333333,
                        fontSize: 14.px,
                    ),
                  ),
                  Container(height: 8.px),
                  MText(
                    "￥${item["price"]}",
                    style: TextStyle(
                      color: Mcolors.CEC5348,
                      fontSize: 16.px,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (mSwiperController != null) mSwiperController.dispose();

    super.dispose();
  }
}
