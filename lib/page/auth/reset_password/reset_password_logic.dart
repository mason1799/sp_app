import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/encrypt_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/regex_util.dart';

import 'reset_password_state.dart';

class ResetPasswordLogic extends BaseController {
  final ResetPasswordState state = ResetPasswordState();

  void confirm() async {
    String _originPassword = state.originPasswordController.text;
    String _newPassword = state.newPasswordController.text;
    String _confirmPassword = state.confirmPasswordController.text;
    if (ObjectUtil.isEmpty(_originPassword)) {
      showToast('原密码不能为空');
      return;
    }
    if (_originPassword == _newPassword) {
      showToast('新密码和原密码一致，请重新输入');
      return;
    }
    if (!RegexUtil.isPassword(_newPassword)) {
      showToast('仅支持字母、数字、特殊字符，长度8-16位');
      return;
    }
    if (_newPassword != _confirmPassword) {
      showToast('请确认两次密码输入一致');
      return;
    }
    showProgress();
    final result = await post(
      Api.resetPassword,
      params: {
        'phone': StoreLogic.to.getUser()?.phone ?? '',
        'confirmPassword': EncryptUtil.encryptedData(_newPassword),
        'newPassword': EncryptUtil.encryptedData(_newPassword),
        'oldPassword': EncryptUtil.encryptedData(_originPassword),
      },
    );
    closeProgress();
    if (result.success) {
      showToast('修改成功');
      Get.offAllNamed(Routes.login);
    } else {
      showToast(result.msg);
    }
  }
}
