import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';

///水平排列
class ConfirmDialog extends StatelessWidget {
  final String content;
  final Function()? onCancel;
  final Function()? onConfirm;
  final String cancel;
  final dynamic cancelResult;
  final dynamic confirmResult;
  final String confirm;
  final bool isSingleButton;

  const ConfirmDialog({
    Key? key,
    required this.content,
    this.onCancel,
    this.cancelResult,
    this.onConfirm,
    this.confirmResult,
    this.cancel = '取消',
    this.confirm = '确定',
    this.isSingleButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 270.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.w),
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    minHeight: 85.w,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
                  child: Center(
                    child: Text(
                      content,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colours.text_333,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 0.5.w,
                  color: Colours.bg,
                ),
                if (isSingleButton)
                  InkWell(
                    onTap: () {
                      Get.back(result: confirmResult);
                      onConfirm?.call();
                    },
                    child: Container(
                      height: 50.w,
                      child: Center(
                        child: Text(
                          confirm,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colours.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back(result: cancelResult);
                            onCancel?.call();
                          },
                          child: Container(
                            height: 50.w,
                            child: Center(
                              child: Text(
                                cancel,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colours.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.w,
                        width: 0.5.w,
                        color: Colours.bg,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            onConfirm?.call();
                          },
                          child: Container(
                            height: 50.w,
                            child: Center(
                              child: Text(
                                confirm,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colours.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
