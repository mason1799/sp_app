import 'dart:async';

import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/auth/widget/captcha.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/regex_util.dart';
import 'package:konesp/widget/error_page.dart';

import 'check_code_state.dart';

class CheckCodeLogic extends BaseController {
  final CheckCodeState state = CheckCodeState();

  startTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      state.countdownTime = state.countdownTime - 1;
      if (state.countdownTime <= 0) {
        timer.cancel();
        state.countdownTime = 60;
        state.codeStatus = PageStatus.empty;
      } else {
        state.codeStatus = PageStatus.success;
      }
      update(['countdown']);
    });
  }

  sendCode() async {
    String _account = state.accountController.text;
    if (state.emailMode) {
      if (ObjectUtil.isEmpty(_account)) {
        showToast('请输入邮箱');
        return;
      }
      if (!RegexUtil.isEmail(_account)) {
        showToast('邮箱格式不正确');
        return;
      }
    } else {
      if (ObjectUtil.isEmpty(_account)) {
        showToast('请输入手机号');
        return;
      }
      if (!RegexUtil.isMobile(_account)) {
        showToast('手机号格式不正确');
        return;
      }
    }
    if (state.countdownTime != 60) {
      return;
    }
    startTime();
    final result = await post(
      Api.sendValidateCode,
      params: {
        'phone': state.emailMode ? null : _account,
        'email': state.emailMode ? _account : null,
        'sendType': state.emailMode ? 'email' : 'phone',
      },
    );
    if (result.success) {
      showToast('验证码发送成功');
    } else {
      showToast(result.msg);
    }
  }

  confirm() async {
    String _account = state.accountController.text;
    String _code = state.codeController.text;
    if (state.emailMode) {
      if (ObjectUtil.isEmpty(_account)) {
        showToast('请输入邮箱');
        return;
      }
      if (!RegexUtil.isEmail(_account)) {
        showToast('邮箱格式不正确');
        return;
      }
    } else {
      if (ObjectUtil.isEmpty(_account)) {
        showToast('请输入手机号');
        return;
      }
      if (!RegexUtil.isMobile(_account)) {
        showToast('手机号格式不正确');
        return;
      }
    }
    if (ObjectUtil.isEmpty(_code)) {
      showToast('请输入验证码');
      return;
    }
    Get.focusScope?.unfocus();
    Get.dialog(
      Captcha(
        onSuccess: (captchaResult) async{
          showProgress();
          final result = await post(Api.checkValidateCode, params: {
            'phone': state.emailMode ? null : _account,
            'email': state.emailMode ? _account : null,
            'validateCode': _code,
            'checkType': state.emailMode ? 'email' : 'phone',
            'captchaVerification': captchaResult,
          });
          closeProgress();
          if (result.success) {
            Get.offNamed(Routes.initPassword, arguments: {
              'isEmailMode': state.emailMode,
              'value': _account,
              'type': 0,
            });
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

  void switchMode() {
    state.emailMode = !state.emailMode;
    state.accountController.clear();
    update(['switchMode']);
  }
}
