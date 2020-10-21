
import 'package:bot_toast/bot_toast.dart';
import 'package:createunion/res/Mcolors.dart';
import 'package:createunion/widget/MText.dart';
import 'package:flutter/material.dart';
import 'package:createunion/utils/SizeUtils.dart';

import 'ConfirmDialog.dart';

class Toast {
  static void toast(text, {disMiss = true}) {
    if (disMiss) dissMiss();
    BotToast.showText(
        text: text,
        textStyle: TextStyle(fontSize: 14.px, color: Colors.white, height: 1.3),
        borderRadius: BorderRadius.circular(2.px),
        contentPadding:
            EdgeInsets.only(left: 12.px, right: 12.px, top: 8.px, bottom: 8.px),
        align: Alignment.center);
  }

  static void toastIndicator({text, clickClose = true}) {
    dissMiss();
    BotToast.showCustomLoading(
        clickClose: clickClose,
        allowClick: false,
        crossPage: true,
        ignoreContentClick: false,
        animationDuration: Duration(milliseconds: 150),
        animationReverseDuration: Duration(milliseconds: 150),
        backgroundColor: Colors.transparent,
        align: Alignment.center,
        toastBuilder: (_) {
          return Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(Color(0xff3E86FF)),
                      ),
                    ),
                    text == null
                        ? Container(
                            width: 5,
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 4),
                            child: MText(text,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13)))
                  ]));
        });
  }

  static void toastWidget(Widget widget, {clickClose = true}) {
    dissMiss();
    BotToast.showCustomLoading(
        clickClose: clickClose,
        allowClick: false,
        crossPage: true,
        ignoreContentClick: false,
        animationDuration: Duration(milliseconds: 150),
        animationReverseDuration: Duration(milliseconds: 150),
        backgroundColor: Colors.transparent,
        align: Alignment.center,
        toastBuilder: (_) {
          return widget;
        });
  }

  static showGlobCustomWidget({text, confirm, cancel}) {
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        crossPage: true,
        ignoreContentClick: false,
        animationDuration: Duration(milliseconds: 150),
        animationReverseDuration: Duration(milliseconds: 150),
        backgroundColor: Colors.transparent,
        align: Alignment.center,
        toastBuilder: (_) {
          return ConfirmDialog(
            content: text ?? '',
            closePop: true,
            confirmColor: Mcolors.C3E86FF,
            cancelColor: Mcolors.C999999,
            onConfirm: () {
              confirm?.call();
              dissMiss();
            },
            onCancel: () {
              cancel?.call();
              dissMiss();
            },
          );
        });
  }

  static void dissMiss() {
    BotToast.closeAllLoading();
    BotToast.cleanAll();
  }
}
