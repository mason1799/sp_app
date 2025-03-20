import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/task/my_task/my_task_view.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/keep_alive_page.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'group/list/group_list_view.dart';
import 'task_logic.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  final logic = Get.put(TaskLogic());
  final state = Get.find<TaskLogic>().state;

  @override
  void dispose() {
    Get.delete<TaskLogic>();
    super.dispose();
  }

  @override
  void initState() {
    state.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Colours.bg,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 0.7.sw,
                          child: TabBar(
                            controller: state.tabController,
                            labelColor: Colours.text_333,
                            labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                            unselectedLabelColor: Colours.text_333,
                            isScrollable: false,
                            unselectedLabelStyle: TextStyle(fontSize: 16.sp),
                            indicatorSize: TabBarIndicatorSize.label,
                            dividerHeight: 0.5.w,
                            dividerColor: Colours.bg,
                            indicator: MaterialIndicator(
                              topLeftRadius: 1.5.w,
                              topRightRadius: 1.5.w,
                              bottomLeftRadius: 1.5.w,
                              bottomRightRadius: 1.5.w,
                              color: Colours.primary,
                              height: 3.w,
                            ),
                            tabs: [Tab(text: '我的任务'), Tab(text: '维保组')],
                          ),
                        ),
                      ),
                      // Positioned(
                      //   right: 0,
                      //   top: 0,
                      //   bottom: 0,
                      //   child: InkWell(
                      //     onTap: () => Get.toNamed(Routes.search, arguments: {'type': 1}),
                      //     child: Container(
                      //       height: double.infinity,
                      //       padding: EdgeInsets.symmetric(horizontal: 15.w),
                      //       alignment: Alignment.center,
                      //       child: LoadAssetImage(
                      //         'search',
                      //         width: 16.w,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: state.tabController,
                    children: [
                      keepAlivePage(MyTaskPage()),
                      keepAlivePage(GroupListPage()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
