import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    this.focusNode,
    required this.onSearch,
    this.hintText,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function() onSearch;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.w),
      ),
      padding: EdgeInsets.only(left: 24.w, right: 12.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode ?? FocusNode(),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colours.text_333,
              ),
              onEditingComplete: onSearch,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hintText ?? '搜索',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_666,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onSearch,
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              alignment: Alignment.center,
              child: LoadAssetImage(
                'search',
                width: 16.w,
              ),
            ),
          )
        ],
      ),
    );
  }
}
