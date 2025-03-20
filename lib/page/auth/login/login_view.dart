import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/custom_textfield.dart';
import 'package:konesp/widget/text_btn.dart';

import '../widget/auth_widget.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AuthWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 34.w),
          Text(
            '登录',
            style: TextStyle(
              color: Colours.text_333,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 14.w),
          CustomTextField(
            keyboardType: TextInputType.number,
            hintText: '手机号',
            controller: state.phoneController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: 14.w),
          CustomTextField(
            keyboardType: TextInputType.visiblePassword,
            hintText: '登录密码',
            obscureText: true,
            controller: state.passwordController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(16),
            ],
          ),
          SizedBox(height: 14.w),
          Row(
            children: [
              GetBuilder<LoginLogic>(
                  id: 'remember_password',
                  builder: (_) {
                    return SizedBox(
                      key: const Key('remember_password'),
                      width: 20.w,
                      height: 20.w,
                      child: Checkbox(
                        value: state.rememberPwd,
                        onChanged: (value) => logic.passwordRemember(value),
                      ),
                    );
                  }),
              SizedBox(width: 8.w),
              Text(
                '记住密码',
                style: TextStyle(
                  color: Colours.primary,
                  fontSize: 13.sp,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Get.toNamed(Routes.checkCode),
                child: Text(
                  '忘记密码',
                  style: TextStyle(
                    color: Colours.primary,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          Row(
            children: [
              GetBuilder<LoginLogic>(
                  id: 'protocol_check',
                  builder: (_) {
                    return SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: Checkbox(
                        value: state.checked,
                        onChanged: (value) => logic.protocolCheck(value),
                      ),
                    );
                  }),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '我已阅读并同意',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.text_333,
                          ),
                        ),
                        TextSpan(
                          text: '《用户服务协议》',
                          recognizer: TapGestureRecognizer()..onTap = logic.toUserProtocol,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.primary,
                          ),
                        ),
                        TextSpan(
                          text: '及',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.text_333,
                          ),
                        ),
                        TextSpan(
                          text: '《个人信息处理规则》',
                          recognizer: TapGestureRecognizer()..onTap = logic.toRuleProtocol,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          TextBtn(
            size: Size(double.infinity, 44.w),
            text: '登录',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
            ),
            onPressed: state.loading ? null : logic.login,
            radius: 7.w,
            backgroundColor: Colours.primary,
          ),
        ],
      ),
    );
  }
}
