import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/entity/login_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/auth/widget/captcha.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/version_update_util.dart';
import 'package:konesp/util/encrypt_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/regex_util.dart';

import 'login_state.dart';

class LoginLogic extends BaseController {
  final LoginState state = LoginState();

  @override
  void onInit() {
    super.onInit();
    state.phoneController.text = GetStorage().read<String>(Constant.keyPhone) ?? '';
    final psw = GetStorage().read<String>(Constant.keyPsw);
    if (ObjectUtil.isNotEmpty(psw)) {
      state.passwordController.text = EncryptUtil.decryptedData(psw!);
      state.rememberPwd = true;
    }
  }

  @override
  void onReady() {
    VersionUpdateUtil.check(this, inForceUpdateContext: true);
  }

  void login() async {
    String _phone = state.phoneController.text;
    String _password = state.passwordController.text;
    if (ObjectUtil.isEmpty(_phone)) {
      showToast('请输入手机号');
      return;
    }
    if (ObjectUtil.isEmpty(_password)) {
      showToast('请输入密码');
      return;
    }
    if (!RegexUtil.isMobile(_phone)) {
      showToast('仅支持11位手机号');
      return;
    }
    if (!state.checked) {
      showToast('需同意用户协议');
      return;
    }
    Get.dialog(
      Captcha(
        onSuccess: (captchaResult) async {
          showProgress();
          final result = await post<LoginEntity>(
            Api.login,
            params: {
              'phone': _phone,
              'password': EncryptUtil.encryptedData(_password),
              'captchaVerification': captchaResult,
            },
          );
          if (result.success) {
            GetStorage().write(Constant.keyToken, result.data!.sessionId!);
            await StoreLogic.to.queryUserInfo();
            await StoreLogic.to.queryPermissions();
            GetStorage().write(Constant.keyPhone, _phone);
            if (state.rememberPwd) {
              GetStorage().write(Constant.keyPsw, EncryptUtil.encryptedData(_password));
            } else {
              GetStorage().remove(Constant.keyPsw);
            }
            closeProgress();
            if (StoreLogic.to.getUser()!.isFirstLogin == true) {
              Get.toNamed(Routes.initPassword, arguments: {
                'type': 1,
                'isEmailMode': false,
                'value': _phone,
              });
            } else {
              Get.offAllNamed(Routes.main);
            }
          } else {
            showToast(result.msg);
          }
        },
        onFail: (msg) {
          showToast(msg);
        },
      ),
    );
  }

  void protocolCheck(bool? value) {
    state.checked = value ?? false;
    update(['protocol_check']);
  }

  void passwordRemember(bool? value) {
    state.rememberPwd = value ?? false;
    update(['remember_password']);
  }

  void toUserProtocol() {
    Get.toNamed(Routes.web, arguments: {'url': 'assets/resource/user_protocol.html'});
  }

  void toRuleProtocol() {
    Get.toNamed(Routes.web, arguments: {'url': 'assets/resource/rule_protocol.html'});
  }
}
