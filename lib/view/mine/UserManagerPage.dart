import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/utils/DateUtils.dart';
import 'package:createunion/utils/SizeUtils.dart';
import 'package:createunion/utils/StringRegUtils.dart';
import 'package:createunion/widget/BasePage.dart';
import 'package:createunion/widget/ConfirmDialog.dart';
import 'package:createunion/widget/FullBasePage.dart';
import 'package:createunion/widget/Line.dart';
import 'package:createunion/widget/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

//验证页
class UserManagerPage extends StatefulWidget {
  int status;

  var userInfo;
  bool isEdit = false;

  UserManagerPage({Key k, this.userInfo, this.isEdit}) : super(key: k);

  @override
  _UserManagerPageState createState() => _UserManagerPageState();
}

class _UserManagerPageState extends State<UserManagerPage> {
  //姓名
  TextEditingController _nameCardController;

  //电话
  TextEditingController _phoneController;

  //身份证
  TextEditingController _codeController;

  //身份证
  TextEditingController _idCardController;



  //年龄
  TextEditingController _ageController;

  //紧急联系人
  TextEditingController _jjController;

  //紧急联系人号码
  TextEditingController _jjmobileController;

  FocusNode focus = FocusNode();

  bool isShow = false;
  Status status = Status.NONE;



  ScrollController _scrollController = new ScrollController();

  List<String> titleList = ["男", "女", "取消"];
  String sex = "请选择";


  int currentIndex = 0;


  Map userInfo = {};
  bool isEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameCardController = TextEditingController();
    _phoneController = TextEditingController();
    _codeController= TextEditingController();
    _idCardController = TextEditingController();
    _ageController = TextEditingController();
    _jjController = TextEditingController();
    _jjmobileController = TextEditingController();

    isEdit = widget.isEdit ?? false;
    if (isEdit) {
      _nameCardController.text = widget.userInfo['name'] ?? "";
      _phoneController.text = widget.userInfo['mobile'] ?? "";
      _idCardController.text = widget.userInfo['idCard'].toString();
      _ageController.text =
          DateUtils.getAgeWithIDCard(widget.userInfo['idCard'].toString())
              .toString();
      sex = widget.userInfo['gender'] == 0
          ? '未知'
          : widget.userInfo['gender'] == 1
              ? '男'
              : '女';
      _codeController.text="19981212";
      _jjmobileController.text =  widget.userInfo['contractMobile'] ?? "18698746233";
      _jjController.text =  widget.userInfo['contract'] ?? "姚琛";

    }
  }

  getHeight(int length) {
    if (length < 80) {
      return 116.px;
    } else if (length < 100) {
      return 140.px;
    } else if (length < 120) {
      return 160.px;
    } else if (length <= 150) {
      return 180.px;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
      title: isEdit ? '编辑用户' : "新增用户",
      child: ListView(
        controller: _scrollController,
        padding: EdgeInsets.only(top: (10.px)),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.px),
            padding: EdgeInsets.symmetric(horizontal: 16.px),
            decoration: BoxDecoration(color: Mcolors.white, boxShadow: [
              BoxShadow(
                  color: Mcolors.CDFEFFB,
                  offset: Offset(0, 1),
                  blurRadius: 3.px),
            ]),
            child: Column(
              children: <Widget>[
                getWidget('姓名', _nameCardController, "请输入真实姓名", require:!isEdit),
                Line(color: Mcolors.CE9E9E9),
                getWidget('电话', _phoneController, "请输入手机号", require: !isEdit),
                Line(color: Mcolors.CE9E9E9),
                getWidget('邀请码', _codeController, "请输入邀请码", require: !isEdit),// 别
                Line(color: Mcolors.CE9E9E9),
                Container(

                  color: Colors.white,
                  height: 54.px,
                  child: Row(
                    children: <Widget>[
                      Offstage(
                        offstage: isEdit,
                        child: Text("*",
                            style: TextStyle(
                              color: Mcolors.CFA5051,
                              fontSize: 15.px,
                            )),
                      ),
                      Text(
                        "性别",
                        style: TextStyle(
                          color: Mcolors.C333333,
                          fontSize: (15),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (isEdit) return;
                              chooseSex();
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(sex,
                                      style: TextStyle(
                                        color: sex == '请选择'
                                            ? Mcolors.CCCCCCC
                                            : Mcolors.C666666,
                                        fontSize: (15),
                                      )),
                                  Offstage(
                                      offstage: isEdit,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: (5)),
                                        child: Image.asset(
                                          "images/ic_right.png",
                                          width: 9.px,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ), //性
                Offstage(
                  child: Column(
                    children: [
                      Line(color: Mcolors.CE9E9E9),
                      getWidget("居民身份证", _idCardController, "请输入证件号"),
                      Line(color: Mcolors.CE9E9E9),
                      getWidget('年龄', _ageController, "请输入年龄"),
                    ],
                  ),
                  offstage: !isEdit,
                )
              ],
            ),
          ),
          Offstage(
            offstage: !isEdit,
            child:   Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Mcolors.CDFEFFB,
                    offset: Offset(0, 1),
                    blurRadius: 3.px),
              ]),
              child: Column(
                children: [
                  getWidget("紧急联系人", _jjController, "请输入紧急联系人"),
                  Line(color: Mcolors.CE9E9E9),
                  getWidget(
                    '紧急联系人电话',
                    _jjmobileController,
                    "请输入紧急联系人电话",
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isEdit) {
                /// 删除
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmDialog(
                        content: "您确实要删除该就诊人吗?",
                        onConfirm: () {
                          delete();
                        },
                        confirmColor: Mcolors.primaryColor,
                      );
                    });
              } else {
                save();
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: 20.px, left: 18.px, right: 18.px, bottom: 24.px),
              alignment: Alignment.center,
              height: 48.px,
              decoration: BoxDecoration(
                  color: Mcolors.primaryColor,
                  borderRadius: BorderRadius.circular(4.px),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(8, 82, 80, 0.10),
                      blurRadius: 16.px,
                      offset: Offset(0, (1)),
                    )
                  ]),
              child: Text(
                isEdit ? '删除用户' : '添加用户',
                style: TextStyle(
                  fontSize: 16.px,
                  color: Mcolors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getWidget(title, controller, hintText, {require = false}) {
    return Container(
      color: Colors.white,
      height: 54.px,
      child: Row(
        children: <Widget>[
          Offstage(
            offstage: !require,
            child: Text("*",
                style: TextStyle(
                  color: Mcolors.CFA5051,
                  fontSize: 15.px,
                )),
          ),
          Text(title,
              style: TextStyle(
                color: Mcolors.C333333,
                fontSize: 15.px,
              )),
          Expanded(
            child: TextField(
              keyboardAppearance: Brightness.light,
              maxLength: hintText == '请输入证件号'
                  ? 21
                  : hintText == '请输入年龄'
                      ? 2
                      : 11,
              controller: controller,
              keyboardType: '请输入手机号' == hintText
                  ? TextInputType.number
                  : TextInputType.text,
              textAlign: TextAlign.right,
              enabled: title == '电话' ? true : !isEdit,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Mcolors.CCCCCCC,
                  fontSize: 15.px,
                ),
              ),
              style: TextStyle(
                color: Mcolors.C666666,
                fontSize: 15.px,
              ),
              onChanged: (text) {
                //计算年纪和性别
                List number = [15, 18];
                bool contains = number.contains(_idCardController.text.length);
                if (hintText == '请输入证件号' && !contains) {
                  setState(() {
                    _ageController.text = '';
                    sex = "请选择";
                  });
                  return;
                }
                if (hintText == '请输入证件号') {
                  String cardNo;
                  if (_idCardController.text.length == 15) {
                    cardNo = DateUtils.get18Ic(_idCardController.text);
                  } else {
                    cardNo = _idCardController.text;
                  }
                  _ageController.text =
                      DateUtils.getAgeWithIDCard(cardNo).toString();
                  setState(() {
                    sex = DateUtils.getSex(_idCardController.text);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void save() {
    if (_nameCardController.text.length == 0) {
      Toast.toast('请输入姓名!');
      return;
    }
    if (_phoneController.text.length == 0) {
      Toast.toast('请输入手机号!');
      return;
    }
    if (_codeController.text.length == 0) {
      Toast.toast('请邀请码手机号!');
      return;
    }
    if (_phoneController.text.length != 11 ||
        !StringRegUtils.isChinaPhoneLegal(_phoneController.text)) {
      Toast.toast('请输入正确的手机号');
      return;
    }

    Map params = {
      "realName": _nameCardController.text.toString(),
      "idCard": _idCardController.text.toString(),
      "mobile": _phoneController.text.toString(),
    };

    if (isEdit) {
      params.putIfAbsent('id', () {
        return widget.userInfo['id'];
      });
    }
  }

  delete() {}

  void chooseSex() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              color: Color(0xfff5f5f9),
              height: titleList.length * 50.px + 10.px,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index != 2) {
                        setState(() {
                          currentIndex = index;
                          sex = titleList[index];
                        });
                      }

                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(
                        titleList[index],
                        style: TextStyle(
                            fontSize: 15.px,
                            color: currentIndex == index
                                ? Mcolors.primaryColor
                                : Mcolors.C333333),
                      ),
                      height: 50.px,
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    index == titleList.length - 2
                        ? Container(height: 10.px)
                        : Line(),
                itemCount: titleList.length,
              ));
        }).then((_) {
      unFocus(context);
    });
  }

  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }

  bool isRegular() {
    String regular = r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{3,21}$";
    RegExp mobile = RegExp(regular);
    return mobile.hasMatch(_idCardController.text);
  }
}
