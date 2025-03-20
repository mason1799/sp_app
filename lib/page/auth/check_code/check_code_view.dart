import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/custom_textfield.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/outlined_btn.dart';
import 'package:konesp/widget/text_btn.dart';

import '../widget/auth_widget.dart';
import 'check_code_logic.dart';

class CheckCodePage extends StatelessWidget {
  final logic = Get.find<CheckCodeLogic>();
  final state = Get.find<CheckCodeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AuthWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 34.w),
          Text(
            '忘记密码',
            style: TextStyle(
              color: Colours.text_333,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 14.w),
          Row(
            children: [
              GetBuilder<CheckCodeLogic>(
                  id: 'switchMode',
                  builder: (_) {
                    return Expanded(
                      child: CustomTextField(
                        controller: state.accountController,
                        keyboardType: state.emailMode ? TextInputType.emailAddress : TextInputType.number,
                        hintText: state.emailMode ? '请输入邮箱' : '请输入手机号',
                        inputFormatters: state.emailMode
                            ? [LengthLimitingTextInputFormatter(30)]
                            : [LengthLimitingTextInputFormatter(11), FilteringTextInputFormatter.digitsOnly],
                      ),
                    );
                  }),
              SizedBox(width: 12.w),
              GetBuilder<CheckCodeLogic>(
                id: 'countdown',
                builder: (_) => TextBtn(
                  onPressed: state.codeStatus == PageStatus.success ? null : logic.sendCode,
                  size: Size(100.w, 44.w),
                  radius: 7.w,
                  backgroundColor: state.codeStatus == PageStatus.success ? Colours.text_ccc.withOpacity(0.5) : Colours.primary,
                  text: state.codeStatus == PageStatus.success ? '${state.countdownTime}S' : '发送验证码',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.w),
          CustomTextField(
            controller: state.codeController,
            keyboardType: TextInputType.number,
            hintText: '请输入验证码',
            inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox(height: 10.w),
          Row(
            children: [
              Spacer(),
              GetBuilder<CheckCodeLogic>(
                id: 'switchMode',
                builder: (_) => InkWell(
                  onTap: logic.switchMode,
                  child: Text(
                    state.emailMode ? '使用手机号验证' : '使用邮箱验证',
                    style: TextStyle(
                      color: Colours.primary,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.w),
          Row(
            children: [
              Expanded(
                child: OutlinedBtn(
                  text: '取消',
                  size: Size(double.infinity, 44.w),
                  borderColor: Colours.primary,
                  borderWidth: 1.w,
                  radius: 7.w,
                  style: TextStyle(
                    color: Colours.primary,
                    fontSize: 17.sp,
                  ),
                  onPressed: Get.back,
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
