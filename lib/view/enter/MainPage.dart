import 'package:createunion/view/home/HomePage.dart';
import 'package:createunion/view/mine/MinePage.dart';
import 'package:createunion/view/wallet/WalletPage.dart';
import 'package:createunion/widget/MyBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  List _bodys;
  PageController _pageController;
  MyBottomNavigationBar mNVBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bodys = [HomePage(),  MinePage()];
    _pageController = PageController();
    mNVBar = MyBottomNavigationBar(
      callBack: (index) {
        _pageController.jumpToPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            child: PageView.builder(
              itemCount: _bodys.length,
              itemBuilder: (context, index) => _bodys[index],
              controller: _pageController,
            ),
            value: SystemUiOverlayStyle.dark,
          ),
          bottomNavigationBar: mNVBar,
        ),
        onWillPop: () {
          return Future.value(true);
        });
  }
}
