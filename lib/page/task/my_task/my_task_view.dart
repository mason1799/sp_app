import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/custom_tab_indicator.dart';
import 'package:konesp/widget/keep_alive_page.dart';
import 'package:konesp/widget/red_badge.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'fix/fix_task_view.dart';
import 'my_task_logic.dart';
import 'my_task_state.dart';
import 'regular/regular_task_view.dart';
import 'widget/custom_calendar.dart';

class MyTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MyTaskLogic());
    final state = Get.find<MyTaskLogic>().state;

    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 1) {
          logic.query();
        }
      },
      key: const Key('MyTaskPage'),
      child: Column(
        children: [
          GetBuilder<MyTaskLogic>(
            id: 'calendar',
            builder: (_) => CustomCalendar(
              logic: logic,
              onSelectedDay: (timeStamp) => logic.selectDay(timeStamp),
              selectedDate: state.selectedDate,
            ),
          ),
          _Body(state: state),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.state,
  });

  final MyTaskState state;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.state.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GetBuilder<MyTaskLogic>(
            id: 'tabbar',
            builder: (_) => Container(
              height: 50.w,
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
              child: TabBar(
                controller: widget.state.tabController,
                indicatorColor: Colours.primary,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3.w,
                indicator: CustomTabIndicator(
                  width: 20.w,
                  borderSide: BorderSide(
                    width: 3.w,
                    color: Colours.primary,
                  ),
                ),
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colours.text_333,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_333,
                ),
                dividerHeight: 0,
                tabs: widget.state.tabs.map((element) {
                  if (element == '故障报修') {
                    return CustomBadgeTab(
                      number: widget.state.fixNumber,
                      text: element,
                    );
                  } else {
                    return CustomBadgeTab(
                      number: widget.state.regularNumber,
                      text: element,
                    );
                  }
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: widget.state.tabController,
              children: [
                keepAlivePage(FixTaskPage()),
                keepAlivePage(RegularTaskPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
