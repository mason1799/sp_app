import 'package:flutter/material.dart';
import 'package:konesp/widget/error_page.dart';

class CheckCodeState {
  final accountController = TextEditingController();
  final codeController = TextEditingController();
  late bool emailMode;
  late int countdownTime;
  late PageStatus codeStatus;

  CheckCodeState() {
    emailMode = false;
    countdownTime = 60;
    codeStatus = PageStatus.empty;
  }
}
