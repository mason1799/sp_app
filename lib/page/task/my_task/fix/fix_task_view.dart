import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:konesp/page/task/my_task/my_task_logic.dart';
import 'package:konesp/widget/debounce_detector.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widget/over_scroll_behavior.dart';
import '../widget/task_item.dart';
import 'fix_task_logic.dart';

class FixTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put<FixTaskLogic>(FixTaskLogic());
    final state = Get.find<FixTaskLogic>().state;
    return DebounceDetector(
      visibleQuery: logic.query,
      keyValue: 'FixTaskPage',
      child: GetBuilder<FixTaskLogic>(
        builder: (_) {
          if (state.pageStatus == PageStatus.success) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  double currentPosition = notification.metrics.pixels;
                  if (notification.metrics.axis == Axis.vertical) {
                    if (currentPosition > state.previousScrollPosition) {
                      if (Get.isRegistered<MyTaskLogic>()) {
                        Get.find<MyTaskLogic>().changeFormat(CalendarFormat.week);
                      }
                    }
                  }
                  state.previousScrollPosition = currentPosition;
                }
                return true;
              },
              child: ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: SlidableAutoCloseBehavior(
                  child: ListView.separated(
                    padding: EdgeInsets.all(10.w),
                    itemBuilder: (context, index) => TaskItem(
                      entity: state.items![index],
                      controller: logic,
                      onResult: logic.query,
                    ),
                    itemCount: state.items?.length ?? 0,
                    separatorBuilder: (context, index) => SizedBox(height: 10.w),
                  ),
                ),
              ),
            );
          } else if (state.pageStatus == PageStatus.empty) {
            return EmptyPage(
              msg: '当前无任务，休息一下吧！',
              icon: LoadSvgImage(
                'no_task',
                width: 100.w,
                height: 100.w,
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
