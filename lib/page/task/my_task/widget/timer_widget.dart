import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';

class TimerWidget extends StatelessWidget {
  final int startTime;
  final TimerController controller;

  TimerWidget({Key? key, required this.startTime})
      : controller = Get.put(TimerController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.startPeriodicUpdate();
    return Obx(() {
      return Text(
        DateUtil.getTimeRemaining(controller.currentTime.value, startTime),
        style: TextStyle(
          color: Colours.darkOrange,
          fontSize: 12.sp,
        ),
        maxLines: 1,
        overflow: TextOverflow.clip,
      );
    });
  }
}

class TimerController extends GetxController {
  late StreamSubscription _subscription;
  RxInt currentTime = DateTime.now().millisecondsSinceEpoch.obs;

  void startPeriodicUpdate() {
    _subscription = Stream.periodic(Duration(seconds: 1), (count) {
      currentTime.value = DateTime.now().millisecondsSinceEpoch;
    }).listen((event) {});
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
