import 'package:flutter/material.dart';

class LoginState {
  late bool loading;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  late bool checked;
  late bool rememberPwd;

  LoginState() {
    loading = false;
    checked = false;
    rememberPwd = false;
  }
}
