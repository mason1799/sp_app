import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/order/widget/row_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/toast_util.dart';
import 'package:konesp/widget/outlined_btn.dart';
import 'package:konesp/widget/sheet/full_time_dialog.dart';
import 'package:konesp/widget/sheet/single_dialog.dart';
import 'package:konesp/widget/text_btn.dart';

class PauseDialog extends StatefulWidget {
  const PauseDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  final Function(String time, String pauseDeviceStatus) onConfirm;

  @override
  State<PauseDialog> createState() => PauseDialogState();
}

class PauseDialogState extends State<PauseDialog> {
  String? selectDate;
  String? deviceStatus;

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
                height: 52.w,
                child: Center(
                  child: Text(
                    '暂停工单',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colours.text_333,
                    ),
                  ),
                ),
              ),
              divider,
              RowItem(
                title: '暂停时间：',
                necessary: true,
                content: selectDate,
                onTap: () {
                  Get.focusScope?.unfocus();
                  Get.bottomSheet(
                    FullTimeDialog(
                      title: '暂停时间',
                      initialDateTime: DateUtil.getDateTime(selectDate) ?? DateTime.now(),
                      onResult: (dateTime) {
                        setState(() {
                          selectDate = DateUtil.formatDate(dateTime);
                        });
                      },
                    ),
                  );
                },
              ),
              RowItem(
                title: '暂停时梯况：',
                necessary: true,
                content: deviceStatus,
                onTap: () async {
                  Get.focusScope?.unfocus();
                  const leaveDeviceState = ['正常运行', '可运行，未完全修复', '停止运行'];
                  int _index = deviceStatus == null ? -1 : leaveDeviceState.indexOf(deviceStatus!);
                  Get.bottomSheet(
                    SingleDialog(
                      title: '暂停时梯况',
                      initialIndex: _index > -1 ? _index : 0,
                      resultData: (index, value) async {
                        setState(() {
                          deviceStatus = value;
                        });
                      },
                      data: leaveDeviceState,
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.w),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedBtn(
                        backgroundColor: Colors.transparent,
                        borderWidth: 0.5.w,
                        borderColor: Colours.primary,
                        size: Size(double.infinity, 44.w),
                        text: '取消',
                        style: TextStyle(
                          color: Colours.primary,
                          fontSize: 17.sp,
                        ),
                        radius: 7.w,
                        onPressed: Get.back,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: TextBtn(
                        backgroundColor: Colours.primary,
                        size: Size(double.infinity, 44.w),
                        text: '确认暂停',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                        radius: 7.w,
                        onPressed: () {
                          if (selectDate != null && deviceStatus != null) {
                            widget.onConfirm(selectDate!, deviceStatus!);
                            Get.back();
                          } else {
                            Toast.show('请选择暂停时间和暂停时梯况');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
