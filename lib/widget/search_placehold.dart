import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class SearchPlacehold extends StatelessWidget {
  const SearchPlacehold({
    super.key,
    required this.onSearch,
    this.hintText,
    this.hintColor,
  });

  final Function() onSearch;
  final String? hintText;
  final Color? hintColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSearch,
      child: Container(
        height: 34.w,
        decoration: BoxDecoration(
          color: Colours.bg,
          borderRadius: BorderRadius.circular(17.w),
        ),
        child: Row(
          children: [
            Container(
              width: 30.w,
              height: 30.w,
              alignment: Alignment.center,
              child: LoadAssetImage(
                'search',
                width: 15.w,
                height: 15.w,
                color: Colours.text_999,
              ),
            ),
            // SizedBox(width: 5.w),
            Expanded(
              child: Text(
                hintText ?? '搜索',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: hintColor ?? Colours.text_666,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
