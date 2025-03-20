import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignatureBoardState {
  late int type;
  late int userId;
  late String employeeCode;
  late bool hasSign;
  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();

  SignatureBoardState() {
    //1. 保养工单辅助签字 2. 故障工单辅助签字 3. 从签字管理页面跳转过来的 4. 签字+审核意见
    type = Get.arguments['type'] ?? -1;
    userId = Get.arguments['id'] ?? -1;
    employeeCode = Get.arguments['employeeCode'] ?? '';
    hasSign = false;
  }
}
