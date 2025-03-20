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

import 'group_member_detail_logic.dart';

class GroupMemberDetailPage extends StatelessWidget {
  final logic = Get.find<GroupMemberDetailLogic>();
  final state = Get.find<GroupMemberDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: state.memberModel.username ?? '',
        subTitle: state.groupName,
      ),
      body: VisibilityDetector(
        onVisibilityChanged: (info) {
          if (info.visibleFraction >= 1) {
            logic.query();
          }
        },
        key: const Key('GroupMemberDetailPage'),
        child: GetBuilder<GroupMemberDetailLogic>(builder: (_) {
          return Column(
            children: [
              Container(
                height: 40.w,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const Spacer(),
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
