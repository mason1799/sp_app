import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/encrypt_util.dart';
import 'package:konesp/util/regex_util.dart';

import 'init_password_state.dart';

class InitPasswordLogic extends BaseController {
  final InitPasswordState state = InitPasswordState();

  void confirm() async {
    String _newPassword = state.newPasswordController.text;
    String _confirmPassword = state.confirmPasswordController.text;
    if (!RegexUtil.isPassword(_newPassword)) {
      showToast('仅支持字母、数字、特殊字符，长度8-16位');
      return;
    }
    if (_newPassword != _confirmPassword) {
      showToast('请确认两次密码输入一致');
      return;
    }
    showProgress();
    Map _map = {
      'newPassword': EncryptUtil.encryptedData(_newPassword),
      'confirmPassword': EncryptUtil.encryptedData(_newPassword),
    };
    if (state.isEmailMode) {
      _map['email'] = state.account;
    } else {
      _map['phone'] = state.account;
    }
    final result = await post(
      Api.forgetPassword,
      params: _map,
    );
    closeProgress();
    if (result.success) {
      if (state.type == 0) {
        showToast('设置成功，请重新登录');
        Get.offNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.main);
      }
    } else {
      showToast(result.msg);
    }
  }
}
