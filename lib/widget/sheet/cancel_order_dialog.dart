import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/toast_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';

import '../custom_textfield.dart';

class CancelOrderDialog extends StatefulWidget {
  const CancelOrderDialog({
    Key? key,
    this.onConfirm,
  }) : super(key: key);

  final Function(String)? onConfirm;

  @override
  State<CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Container(
                width: 1.sw * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 52.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colours.bg, width: 0.5.w),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '工单取消后不可再被响应',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [LengthLimitingTextInputFormatter(16)],
                      hintText: '请输入取消原因',
                      backgroundColor: Colors.transparent,
                      hintColor: Colours.text_ccc,
                      autofocus: true,
                      suffixIcon: LoadSvgImage(
                        'clear_input',
                        width: 15.w,
                        color: Color(0xFFABABAB),
                      ),
                      onEditingComplete: complete,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      color: Colours.bg,
                      width: double.infinity,
                      height: 0.5.w,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: TextBtn(
                        onPressed: complete,
                        size: Size(double.infinity, 44.w),
                        text: '确定',
                        radius: 4.w,
                        backgroundColor: Colours.primary,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  Get.focusScope?.unfocus();
                  Get.back();
                },
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colours.text_ccc,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close_rounded,
                    size: 15.w,
                    color: Colours.text_666,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  complete() {
    String _input = _textController.text;
    if (ObjectUtil.isEmpty(_input)) {
      Toast.show('请输入取消原因');
      return;
    }
    Get.back();
    widget.onConfirm?.call(_input);
  }
}
