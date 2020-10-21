class Api {
//安卓更新
  static const String UPDATE =
      "ms-shulan-hospital/v1/app-version/listAppVersionByApplication";

  static const String downApk = 'versionCheck/apiv2/app/check';

  /// 获取图片
  static String getImageWithId = 'ms-hoc-material/v3/file/download/';

  /// 查询医生列表
  static String getDoctorsApi = 'ms-doctor/v2/doctors/hospitals/query';

  /// 医生头像接口
  static String doctorProfile =
      'ui-pocket-hospital/v1/image/download?fileName=';

  /// 验证手机号的验证码
  static String authPhoneCode = 'sljt-api/v1/register';

//  static String authPhoneCode(phone, code) {
//    return '/ms-pocket-hospital/v1/common/phone/validate/phone/$phone/number/$code';
//  }

  /// 推送网易云消息
  static String imPushApi = 'sljt-api/service/notification';

  //获取树兰oauth Token
  static String oauthToken =
      'woauth2/oauth/token?grant_type=client_credentials';

  //注册账号
  static String registerAccount = 'ms-pocket-hospital/v1/app_user/save';

  //注册校验
  static String check = 'ms-pocket-hospital/v1/app_user/check/save';

  //登录账号
  static String loaginAccount = 'sljt-api/v1/login';

  // 重设密码
  static String resetPassword = 'ms-pocket-hospital/v1/app_user/app/update_pwd';

  // 忘记密码
  static String resetpass = 'sljt-api/v1/auth/resetpass';

  // 个人用户信息查询
  static String userinfo = 'sljt-api/v1/me';

  /// 文件上传   公用
  static String uploadFile = 'sljt-api/file/upload';

  /// 文件上传  私密
  static String uploadFilePrivate = 'sljt-api/v1/private/upload';

  static String getVerifyCode = 'sljt-api/sms';

  ///获取科室列表
  static const String getDepartmentList =
      "ms-shulan-hospital/v1/department/treeDepartment";

  ///获取职称列表
  static const String getJobTitleList =
      "ms-shulan-hospital/v1/dictionary/listAll";

  ///获取管理人列表
  static const String getContacts = "sljt-api/v1/patients";

  /// 新增就诊人
  static const String addNewPatient = "sljt-api/v1/patients";

  /// 新增就诊卡
  static const String addNewCard = "sljt-api/v1/patients/card/";

  /// 更新就诊人
  static String updatePatient = 'ms-pocket-hospital/v1/contact/addorupdate';

  /// 删除就诊人
  static String deletePatient = 'sljt-api/v1/patients/';

  /// 联系人手机号验证
  static String auth = 'sljt-api/v1/patients/vertify/';

  /// 获取HIS就诊卡
  static const String getHisCard =
      "ms-pocket-hospital/v1/contact/his_cardInfo/";

  /// 获取HIS就诊卡
  static const String getHisCardShuLan = "sljt-api/v1/patients/card/";

  /// 获取就诊人所有就诊卡
  static const String getCardList = "ms-pocket-hospital/v1/contact/cardInfo";

  // ---------------------------------我的处方 我的健康档案
  /// 移动端丨查询患者详细信息
  static const String getPatientInfo = "ui-pocket-hospital/v1/patient/info";

  /// 移动端丨检验检查详情
  static const String getInspection =
      "ui-pocket-hospital/v1/patient/phone/inspection";

//  /// 移动端丨检验检查详情
//  static const String getAllInspection =
//      "ui-pocket-hospital/v1/patient/phone/all_inspection";

  static const String getAllInspection =
      "ms-pocket-hospital/v1/report/searchByCardNo/34";

  /// 移动端丨就诊记录
  static const String getMedicalRecords =
      "ui-pocket-hospital/v1/patient/phone/medical_records";

  /// 移动端丨检查详情
  static String getCheckDetail() {
    return 'ms-pocket-hospital/v1/report/hospital/34/getRegisterListForInspectionReport';
  }

  /// 移动端丨检验详情
  static String getTestDetail(reportId) {
    return 'ms-pocket-hospital/v1/report/hospital/34/biochemical/$reportId';
  }

  // ------------------------------- 我的挂号

  /// 选择医生列表搜索页
  static const String getSearchList =
      "ms-pocket-hospital/v1/schedules/source_search";

  /// 选择医生列表
  static const String getSelectRoomList =
      "ms-pocket-hospital/v1/dept/dept_with_his/hospital/34";

  /// 选择医生列表
  static const String getSelectDoctorList =
      "ms-pocket-hospital/v1/schedules/appointments_resume/query?hospital_id=34";

  /// 获取医生排班列表
  static const String getAppointments =
      "ms-pocket-hospital/v1/schedules/appointments/query?hospital_id=34";

  /// 获取医生排班列表简介详情
  static const String getAppointmentDoctorDetail =
      "ms-pocket-hospital/v1/doctors/";

  /// 获取医生排班列表简介详情
  static const String getAppointmentSourceDetail =
      "ms-pocket-hospital/v1/sources_detail/query?hospital_id=34";

  /// 确认支付第一步  registration
  static const String registration = "sljt-api/v1/registration";

  /// 确认支付第一步
  static const String preCheckin = "ms-pocket-hospital/v1/orders/pre_checkin";

  /// 确认支付第二步
  static const String sureOrder = "ms-pocket-hospital/v1/orders/";

  /// 确认支付第三步
  static const String finishOrder = "ms-pocket-hospital/v1/orders/";

  //我的挂号------------------------------------
  /// 我的挂号列表
  static const String getRegisterList = "ms-pocket-hospital/v1/orders/users/";

  /// 我的挂号列表   小程序端
  static const String registrations = "sljt-api/v1/me/registrations";

  /// 我的挂号列表详情
  static const String getRegisterListDetail = "ms-pocket-hospital/v1/orders/";

  /// 取消预约
  static const String cancelRegister = "sljt-api/v1/registration/cancel";

  // 排队叫号-------------------------------------

  /// 叫号情况
  static const String queueListV2 =
      "ms-pocket-hospital//v2/queue/queueListV2?hospitalId=34&userId=";

  /// banner列表
  static const String getBanners = "sljt-api/v1/banners";

  /// banner列表
  static const String getContent = "sljt-api/v1/articles";

  // 问诊 =======================================
  /// 科室列表
  static const String roomList =
      "ms-pocket-hospital/v1/dept/dept_with_his/hospital/34?module=TEXT";

  /// 医生列表
  static const String doctorList = "ms-doctor/v2/doctors/hospitals/query";

  /// 医生详情
  static const String doctorDetail = "sljt-api/v1/doctors/";

  /// 医生评价
  static const String doctorComments = "sljt-api/v1/doctor/comments/";

  /// 我的图文视频 咨询记录
  static const String consultationOrders = 'sljt-api/v1/me/orders';

  /// 我的处方
  static const String prescriptionOrders = 'sljt-api/v1/me/prescriptions';

  /// 我的处方 单个详情
  static const String prescriptionOrdersDetail = 'sljt-api/v1/prescription/';

  /// 我的处方 处方支付通知
  static const String prescriptionOrdersPayment =
      'sljt-api/v1/prescription/payment/';

  /// 我的意见反馈
  static const String feedback = 'sljt-api/v1/feedback';

  /// 我收藏的医生
  static const String myCollectDoctors = 'sljt-api/v1/me/doctors';

  /// 我收藏的文章
  static const String myArticles = 'sljt-api/v1/me/articles';

  /// 我收藏的视频
  static const String myVideos = 'ms-shulan-hospital/v1/myfavorites/list/iuid/';

  /// 预约服务
  static const String order = "sljt-api/v1/service/order";

  /// 职称字典
  static const String dictionary = "ms-doctor/v1/dictionary/all";

  /// 图文视频问诊服务，付款完成通知
  static const String payment = "sljt-api/v1/service/order/payment/";

  /// 患者发布评价
  static const String comments = "sljt-api/v1/doctor/comments";

  ///咨询服务详情
  static const String serviceDetail = 'sljt-api/v1/service/';

  ///单条订单详情
  static const String orderDetail = 'sljt-api/v1/service/order/';

  /// 最近服务状态
  static String editState = 'sljt-api/v1/im/checkService';

  /// 结束服务
  static String endServer = 'sljt-api/v1/im/end';

  /// 填写咨询建议
  static String inputAdviceApi = 'sljt-api/v1/service/advice';

  /// 会话列表
  static String conversationList = 'sljt-api/v1/im/query';

  ///获取历史消息
  static String getHistoryMsg =
      'https://api.netease.im/nimserver/history/querySessionMsg.action';

  /// 支付宝H5支付统一下单
  static String payOrders = 'ms-pocket-hospital/v1/aliPay/unified_order';

  /// 获取最近会话记录
  static String getSessions = 'sljt-api/v1/im/sessions';

  /// 获取我的处方单
  static String getMedListDetail =
      'ui-pocket-hospital/v1/patient/medicineHistory';

  ///获取评价状态
  static const String getCustomMsgState = 'sljt-api/v1/im/customMsgState';

  /// 模块下的视频
  static const String getVideoListOfModule =
      'ms-shulan-hospital/v1/expertseminar/list';

  /// 获取医生指定类型时间
  static const String getDoctorSchedule =
      'ms-doctor/v4/doctor_schedule/get_doctor_day/';

  /// 获取我的复诊配药记录
  static String getVisitRecords = 'sljt-api/v1/me/visitRecords';

  /// 获取我的复诊详情
  static String getVisitRecordsDetail = 'sljt-api/v1/visitRecords/';

//  /ms-hoc-online-prescription/v1/prescription/details/{prescriptionId}
  /// 取消复诊详情
  static String cancelRecords = 'sljt-api/v1/cancel/visitRecords/';

  /// 精辟课程order列表
  static String getClassOrderList =
      '/ms-shulan-hospital/v1/patient-order/orderList';

  /// 获取医生排班
  static String validate(doctorId, week, type) {
    return '/ms-pocket-hospital/v1/common/phone/validate/doctorId/$doctorId/week/$week/type/$type';
  }

  /// 复诊
  static String fuzhen = 'shulanweb/prescribe-clinc?platform=app&token=';

  /// 义诊
  static String yizhen = 'shulanweb/yizhen?platform=app';

  /// 名医团队
  static String group = 'shulanweb/mingyi-team?platform=app';

  /// 精品课程
  static String hotclass = 'patient/#/patientVideoList';

  /// 精品课程
  static String hotclassDetail(str) {
    return 'patient/#/patientVideoDetail/$str';
  }

  ///支付方法
  static const String h5pay = 'videoH5#/H5Pay/';

  ///查询消息
  static const String queryMyMsg = 'ms-shulan-hospital/v1/message/';

  ///查询未读消息数量   ?type=patientOrder
  static String queryMyMsgCount(String iuid) {
    return 'ms-shulan-hospital/v1/message/count/$iuid';
  }

  ///设置全部消息已读
  static const String readAccountMessage =
      'ms-shulan-hospital/v1/message/readAccountMessage/';

  ///设置单条消息已读
  static const String readAccountMessageSingle =
      'ms-shulan-hospital/v1/message/readMessage/';

  ///就诊人的就诊记录
  static const String getMedicalRecordDetail =
      'sljt-api/v1/patients/medicalRecord?orderId=';

  ///复诊开药订单状态
  static const String getPrescriptionState =
      'ms-hoc-online-prescription/v1/prescription/detail';

  //服务包 =======================================

  ///服务包列表
  static const String getPackageList = "sljt-api/v1/packages";

  ///购买服务包
  static const String buyPackage = "sljt-api/v1/packages/buy";

  ///购买的服务包
  static const String payedPackage = "sljt-api/v1/mine/packages";

//  ///获取优惠券（兑换券/折扣券）列表
//  static const String getCouponList =
//      '/ms-shulan-hospital/v1/coupon/couponList';

  ///获取服务包可用医生
  static String getPackageDocList(String packageId) {
    return 'sljt-api/v1/mine/packages/$packageId';
  }

  ///获取优惠券可用医生
  static String getCouponDocList(String couponId) {
    return 'ms-shulan-hospital/v1/coupon/doctor/$couponId';
  }

  ///支付页展示用户优惠券
  static const String getUserCoupon = "ms-shulan-hospital/v1/coupon/getUseCoupon";

  ///用户登录发放优惠券
  static const String loginGetCoupon ="ms-shulan-hospital/v1/coupon/loginGetCoupon";

  ///用户自主领取优惠券
  static const String userGetCoupon = "ms-shulan-hospital/v1/coupon/userGetCoupon";

  ///用户可见优惠券
  static const String getShowCoupon = "ms-shulan-hospital/v1/coupon/showCoupon";

  ///个人中心优惠券展示
  static const String getMyCouponList = "ms-shulan-hospital/v1/coupon/getMyCoupon";
  ///个人中心优惠券展示
    static const String getMyCouponCount = "ms-shulan-hospital/v1/coupon/getMyCouponCount";
  ///卡券支付订单
  static const String payCouponOrder = "ms-shulan-hospital/v1/couponOrder";
}
