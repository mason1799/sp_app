import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:konesp/page/task/my_task/widget/task_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'group_project_detail_logic.dart';

class GroupProjectDetailPage extends StatelessWidget {
  final logic = Get.find<GroupProjectDetailLogic>();
  final state = Get.find<GroupProjectDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: state.projectModel.projectName ?? '',
        subTitle: state.projectModel.projectLocation,
      ),
      body: VisibilityDetector(
        onVisibilityChanged: (info) {
          if (info.visibleFraction >= 1) {
            logic.query();
          }
        },
        key: const Key('GroupProjectDetailPage'),
        child: GetBuilder<GroupProjectDetailLogic>(builder: (_) {
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40.w,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: logic.toSelect,
                      child: Row(
                        children: [
                          Text(
                            DateUtil.formatDate(state.selectDate, format: DateFormats.ymd),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colours.text_333,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          RotatedBox(
                            quarterTurns: 1,
                            child: LoadSvgImage(
                              'arrow_right',
                              width: 14.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      '已完成${state.groupListRootEntity?.finish ?? 0}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colours.text_333,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '未响应${state.groupListRootEntity?.awaitFinish ?? 0}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colours.text_333,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '响应中${state.groupListRootEntity?.response ?? 0}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colours.text_333,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: buildBody(state.pageStatus)),
            ],
          );
        }),
      ),
    );
  }

  Widget buildBody(PageStatus pageStatus) {
    if (pageStatus == PageStatus.success) {
      return SlidableAutoCloseBehavior(
        child: ListView.separated(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
          itemBuilder: (context, index) => TaskItem(
            entity: state.groupListRootEntity!.orders![index],
            isMaintananceGroup: true,
            controller: logic,
            onResult: logic.query,
          ),
          separatorBuilder: (context, index) => SizedBox(height: 10.w),
          itemCount: state.groupListRootEntity?.orders?.length ?? 0,
        ),
      );
    } else if (pageStatus == PageStatus.error) {
      return ErrorPage();
    } else if (pageStatus == PageStatus.loading) {
      return CenterLoading();
    } else {
      return EmptyPage();
    }
  }
}
