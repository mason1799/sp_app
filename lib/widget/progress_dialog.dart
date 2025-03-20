import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 加载中的弹框
class ProgressDialog extends Dialog {
  const ProgressDialog();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Color(0xDD000000),
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 15.w,
                height: 15.w,
                child: CircularProgressIndicator(
                  strokeWidth: 1.w,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '加载中...',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
