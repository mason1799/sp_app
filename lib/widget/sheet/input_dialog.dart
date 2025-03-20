import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/toast_util.dart';
import 'package:konesp/widget/custom_textfield.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({
    Key? key,
    required this.title,
    this.necessary = false,
    this.initialValue,
    this.onSave,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

  final String title;
  final bool necessary;
  final String? initialValue;
  final Function(String)? onSave;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _textController.text = widget.initialValue ?? '';
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
                          '修改${widget.title}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: _textController,
                      keyboardType: widget.keyboardType,
                      inputFormatters: widget.inputFormatters,
                      hintText: '请输入${widget.title}',
                      backgroundColor: Colors.transparent,
                      hintColor: Colours.text_ccc,
                      autofocus: true,
                      suffixIcon: LoadSvgImage(
                        'clear_input',
                        width: 15.w,
                        color: Color(0xFFABABAB),
                      ),
                      onEditingComplete: onPressed,
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
                        onPressed: onPressed,
                        size: Size(double.infinity, 44.w),
                        text: '保存',
                        radius: 7.w,
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

  void onPressed() {
    String _input = _textController.text;
    if (widget.necessary && ObjectUtil.isEmpty(_input)) {
      Toast.show('请输入${widget.title}');
      return;
    }
    Get.back();
    widget.onSave?.call(_input);
  }
}
