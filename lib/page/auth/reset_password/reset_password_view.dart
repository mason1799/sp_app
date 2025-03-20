import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/custom_textfield.dart';
import 'package:konesp/widget/outlined_btn.dart';
import 'package:konesp/widget/text_btn.dart';

import '../widget/auth_widget.dart';
import 'reset_password_logic.dart';

class ResetPasswordPage extends StatelessWidget {
  final logic = Get.find<ResetPasswordLogic>();
  final state = Get.find<ResetPasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AuthWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 34.w),
          Text(
            '重置密码',
            style: TextStyle(
              color: Colours.text_333,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 14.w),
          CustomTextField(
            controller: state.originPasswordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: '原密码',
            obscureText: true,
            inputFormatters: [LengthLimitingTextInputFormatter(16)],
          ),
          SizedBox(height: 14.w),
          CustomTextField(
            controller: state.newPasswordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: '新密码',
            obscureText: true,
            inputFormatters: [LengthLimitingTextInputFormatter(16)],
          ),
          SizedBox(height: 14.w),
          CustomTextField(
            controller: state.confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: '确认密码',
            obscureText: true,
            inputFormatters: [LengthLimitingTextInputFormatter(16)],
          ),
          SizedBox(height: 24.w),
          Row(
            children: [
              Expanded(
                child: OutlinedBtn(
                  borderColor: Colours.primary,
                  borderWidth: 1.w,
                  size: Size(double.infinity, 44.w),
                  radius: 7.w,
                  onPressed: Get.back,
                  text: '取消',
                  style: TextStyle(
                    color: Colours.primary,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(width: 28.w),
              Expanded(
                child: TextBtn(
                  text: '确认',
                  size: Size(double.infinity, 44.w),
                  backgroundColor: Colours.primary,
                  radius: 7.w,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                  onPressed: logic.confirm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
