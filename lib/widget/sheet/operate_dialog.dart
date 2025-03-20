import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';

class OperateDialog extends StatelessWidget {
  final Function()? recovery;
  final Function()? checkInDate;
  final Function()? checkOutDate;
  final Function()? assistNotSigns;

  OperateDialog({
    this.recovery,
    this.checkInDate,
    this.checkOutDate,
    this.assistNotSigns,
    Key? key,
  }) : super(key: key);

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
              Visibility(
                  visible: recovery != null,
                  child: GestureDetector(
                    onTap: () {
                      if (recovery != null) {
                        Get.back();
                        recovery!.call();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.w,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        '重置工单',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colours.text_333,
                        ),
                      ),
                    ),
                  )),
              Visibility(
                  visible: assistNotSigns != null,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      assistNotSigns?.call();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.w,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        '辅助人员签字',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colours.text_333,
                        ),
                      ),
                    ),
                  )),
              Visibility(
                visible: checkInDate != null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    divider,
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        checkInDate?.call();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.w,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          '调整签到时间',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: checkOutDate != null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    divider,
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        checkOutDate?.call();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.w,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          '调整签退时间',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 10.w,
                color: Colours.bg,
              ),
              GestureDetector(
                onTap: Get.back,
                child: Container(
                  width: double.infinity,
                  height: 50.w,
                  color: Colors.transparent,
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
