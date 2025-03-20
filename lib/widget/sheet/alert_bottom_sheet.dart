import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';

void showAlertBottomSheet<T>(
  List<String> items,
  Function(String item, int index)? onTap,
) {
  Get.bottomSheet(
    ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8.w),
      ),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colours.bg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                items.length + 1,
                (index) {
                  late String title;
                  if (index == items.length) {
                    title = '取消';
                  } else {
                    title = items[index];
                  }
                  return InkWell(
                    onTap: () {
                      Get.back();
                      if (index < items.length) {
                        onTap?.call(items[index], index);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.w,
                      margin: index == items.length ? EdgeInsets.only(top: 10.w) : EdgeInsets.zero,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: index > 0 ? Border(top: BorderSide(color: Colours.bg, width: 0.5.w)) : null,
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colours.text_333,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
