import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitPasswordState {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late bool isEmailMode;
  late String account;
  late int type;

  InitPasswordState() {
    isEmailMode = Get.arguments['isEmailMode'];
    account = Get.arguments['value'];
    type = Get.arguments['type'];
  }
}
