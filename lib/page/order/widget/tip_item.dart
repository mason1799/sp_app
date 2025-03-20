import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class TipItem extends StatelessWidget {
  final String? content;
  final Color bgColor;
  final Color txtColor;
  final String? icon;

  TipItem(
    this.content, {
    this.bgColor = Colours.secondary,
    this.txtColor = Colours.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.w, bottom: 12.w),
      color: bgColor,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: LoadAssetImage(
                '$icon',
                width: 17.w,
              ),
            ),
          Expanded(
            child: Text(
              content ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                color: txtColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
