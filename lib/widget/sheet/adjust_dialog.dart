import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';

class AdjustDialog extends StatelessWidget {
  final Function? shortTerm;
  final Function? longTerm;

  AdjustDialog({
    this.shortTerm,
    this.longTerm,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8.w),
      ),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 44.w,
                alignment: Alignment.center,
                child: Text(
                  '该工单不是当日工单，请选择调整方式',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colours.text_333,
                  ),
                ),
              ),
              divider,
              InkWell(
                onTap: () {
                  Get.back();
                  shortTerm?.call();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.w,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '短期调整',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colours.text_333,
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Text(
                        '仅调整这一次',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colours.text_ccc,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              divider,
              InkWell(
                onTap: () {
                  Get.back();
                  longTerm?.call();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.w,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '长期调整',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colours.text_333,
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Text(
                        '长期调整仅调整这一次',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colours.text_ccc,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              divider,
              InkWell(
                onTap: Get.back,
                child: Container(
                  width: double.infinity,
                  height: 50.w,
                  alignment: Alignment.center,
                  child: Text(
                    '取消',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colours.text_333,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
