import 'dart:io';

import 'package:createunion/http/Api.dart';
import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/Constant.dart';
import 'package:createunion/utils/RouteHelper.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/CustomDotBuilder.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/MText.dart';
import 'package:createunion/widget/Marquee.dart';
import 'package:createunion/widget/PhotoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';

class ProjectSubmitPage extends StatefulWidget {
  ProjectSubmitPage();

  @override
  _ProjectSubmitPageState createState() => _ProjectSubmitPageState();
}

class _ProjectSubmitPageState extends State<ProjectSubmitPage> {
  Status mStatus = Status.LOADING;
  String patientName = "请选择";
  Map patientInfo;
  final TextEditingController _remarkController =
      TextEditingController.fromValue(TextEditingValue(text: ""));
  List<String> picList = [];
  List imageList = ["images/ic_add_image.png"];
  Map submitData;
  ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: "项目详情",
        child: Column(children: [
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.px, bottom: 10.px),
                padding:
                    EdgeInsets.symmetric(horizontal: 24.px, vertical: 15.px),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Mcolors.CDFEFFB,
                      offset: Offset(0, 1),
                      blurRadius: 3.px),
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MText(
                      "请将要业务提交的照片上传",
                      style: TextStyle(
                          color: Mcolors.C333333,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.px),
                    ),
                    Container(
                      height: 5.px,
                    ),
                    MText(
                      "请保证照片的完整、清晰 最多可上传9张",
                      style: TextStyle(color: Mcolors.C999999, fontSize: 14.px),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5.px,
                          mainAxisSpacing: 5.px),
                      itemBuilder: getImageWidget,
                      itemCount: imageList.length,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Mcolors.CDFEFFB,
                      offset: Offset(0, 1),
                      blurRadius: 3.px),
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MText(
                      "描述文字信息",
                      style: TextStyle(color: Mcolors.C666666, fontSize: 16.px),
                    ),
                    TextField(
                      keyboardAppearance: Brightness.light,
                      maxLength: 300,
                      controller: _remarkController,
                      style: TextStyle(
                        color: Mcolors.C333333,
                        fontSize: 14.px,
                      ),
                      maxLines: 8,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: "其他文字描述信息",
                        hintStyle: TextStyle(
                          color: Mcolors.C999999,
                          fontSize: 14.px,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Mcolors.primaryColor,
              alignment: Alignment.center,
              height: 48.px,
              child: MText('立即提交',
                  style: TextStyle(fontSize: 16.px, color: Colors.white)),
            ),
          )
        ]));
  }

  Widget getImageWidget(context, index) {
    String item = imageList[index];
    double width = (SizeUtils.screenW - 48.px) / 4;
    String lastImage = "images/ic_add_image.png";
    return Stack(children: <Widget>[
      GestureDetector(
        onTap: () {
          if (item == lastImage) {
            selectPic();
          } else {
            List temp = [];
            temp = imageList.sublist(0, imageList.length - 1);
            RouteHelper.pushWidget(
                context, PhotoView(imgs: temp, currentIndex: index));
          }
        },
        child: Container(
          width: width,
          height: width,
          margin: EdgeInsets.only(top: 8.px, right: 8.px),
          child: item == lastImage
              ? Image.asset(
                  item,
                  width: width,
                  height: width,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(item),
                  width: width,
                  height: width,
                  fit: BoxFit.cover,
                ),
        ),
      ),
      Positioned(
        right: 0,
        child: Offstage(
          offstage: item == lastImage,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  imageList.removeAt(index);
                  // picList.removeAt(index);
                  if (imageList.length == 8) imageList.add(lastImage);
                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 4.px, left: 10.px, bottom: 10.px),
                child: Image.asset("images/ic_wrong.png", width: 18.px),
              )),
        ),
      )
    ]);
  }

  selectPic() {
    var titles = ["相机", "相册", "取消"];
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              color: Mcolors.CF5F5F9,
              height: titles.length * 50.px + 10.px,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      if (index == 2) return;
                      _pickImage(index);
                    },
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: MText(
                        titles[index],
                        style:
                            TextStyle(fontSize: 15.px, color: Mcolors.C333333),
                      ),
                      height: 50.px,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  if (index == titles.length - 2)
                    return Container(
                      height: 10.px,
                    );
                  return Line(
                    color: Mcolors.CECECEC,
                  );
                },
                itemCount: titles.length,
              ));
        });
  }

  _pickImage(int source) {
    ImagePicker.pickImage(
            source: source == 0 ? ImageSource.camera : ImageSource.gallery,
            maxHeight: 960,
            maxWidth: 540)
        .then((file) {
      if (file == null) {
        return;
      }
      setState(() {
        imageList.insert(imageList.length - 1, file.path);
        if (imageList.length == 10) imageList.removeLast();
      });
    });
  }
}

