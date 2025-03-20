import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/text_btn.dart';

class BottomBtn extends StatelessWidget {
  const BottomBtn({
    super.key,
    this.onPressed,
    required this.btnName,
  });

  final Function()? onPressed;
  final String btnName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(
        left: 36.w,
        right: 36.w,
        top: 12.w,
        bottom: 12.w + ScreenUtil().bottomBarHeight,
      ),
      child: Center(
        child: TextBtn(
          onPressed: onPressed,
          size: Size(double.infinity, 44.w),
          text: btnName,
          radius: 7.w,
          backgroundColor: Colours.primary,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
          ),
        ),
      ),
    );
  }
}
