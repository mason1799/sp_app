import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

/// 检查项详情 图标
class CheckIcon extends StatelessWidget {
  const CheckIcon({
    Key? key,
    required this.selectImageAsset,
    required this.unselectImageAsset,
    required this.selected,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String selectImageAsset;
  final String unselectImageAsset;
  final bool selected;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(top: 15.w, bottom: 15.w),
          child: Column(
            children: [
              LoadSvgImage(
                selected ? selectImageAsset : unselectImageAsset,
                width: 36.w,
              ),
              SizedBox(height: 6.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colours.text_333,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
