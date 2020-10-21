import 'package:flutter/widgets.dart';

class Constant {
  static const String MODEL = "model";
  static const String TOKEN = "token";
  static const String PHONE = "phone";
  static const String AGREE = "agree";
  static const String TENTANTID =
      "95b5ae1983e84eff92bb48f5922dc8a1"; //互联网医院id（会诊专用）---铜仁
  static const String BL = "bl";
  static const String DOWNLOAD = "download"; //下载
  static const String INFO = "info";
  static int MODEL_INT = 0;
  static BuildContext appContext;
  static OverlayEntry overlayEntry;
  static const String VIDEOID = "3d8dd1d1a77f4436943c0845da71b529";
  static String API_HOST() {
    switch (MODEL_INT) {
      case 0:
        return "https://cloud-hospital.trhlwyy.com"; //生产环境
      case 1:
        return "https://test-cloud-hospital-tr.rubikstack.com"; //开发环境
      case 2:
        return "https://cloud-hospital-tr.rubikstack.com"; //预发环境
      default:
        return "https://cloud-hospital.trhlwyy.com";
    }
  }

  ///eventBus key
  static const String BLCFZD = "blcfzd";
  static const String IMVIDEOCANCEL = "im-video-cancel";
  static const String IMVIDEOOFF = "im-video-off";
  static const String IMVIDEOSTAR = "im-video-start";
  static const String IMFARVIDEOSTAR = "im-far-video-start"; //协同门诊视频发起
  static const String VIDEOCALLDOWN = "video-call-down"; //被对方挂断
  static const String IMMessageReceive = "IMMessageReceive"; //接收到消息
  static const String IMMessageRemove = "IMMessageRemove"; //移除到消息
  static const String UPDATEUNREADCOUNT = "updateUnreadCount"; //更新消息未读数目
  static const String PATIENTCANCEL = "patient-cancel"; //患者端取消问诊
  static const String SENDCUSTOMTIP = "send-custom-tip"; //发送自定义消息提示
  static const String USERINFO = "userinfo";
  static const String VIDEOSTART = "videostart";
  static const String VIDEOEND = "videoend";
  static const String MENUCHANGE = "menuChange";
  static const String REFRESHLIST = "refreshList";
  static const String UPDATEPRICE = "updatePrice";
  static const String REFRESHCOUNT = "refreshconut";
  static const String SHAREOVER = "shareOver";
  static const String UPDATESELECTLIST = "updateSelectList";
  static const String REFCONSULATION = "refreshConsulation";
  static const String REFCONSULATIONCOUNT = "refreshConsulationUnreadCount";
  static const String REMOTEORDERCOUNT = "RemoteOrderCount";
  static const String UPDATESTATUS = "updateStatus";
  static const String PAY = "pay";
  static const String YSB = "youShouldBuy";
  static const String NB = "notBuy";
  static const String FZPYREFRESH = "fzpyrefresh";
  static const String MESSAGERELOAD = "messageReload";
  static const String JPMessageReceive = "JPMessageReceive";
  static const String RUSHDIAGNOISE = "rushdiagnoise";
  static const String AUTH_INFO = "authInfo";
}

// 订单状态
enum OrderStatus {
  waitForAdmission, //待接诊
  reception, // 已接诊
  unpayed,
  cancel, //已取消
  miss, //已退诊
  end, // 已结束
}
enum TYPE {
  AGREEMEMT,
  PRIVACY, //隐私协议
  NOR, //普通网页
}
