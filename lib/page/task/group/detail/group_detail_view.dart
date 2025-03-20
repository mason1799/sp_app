import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/task/my_task/widget/task_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_expand_icon.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import '../widget/group_widget.dart';
import 'group_detail_logic.dart';

/// 维保组详情
class GroupDetailPage extends StatelessWidget {
  final logic = Get.find<GroupDetailLogic>();
  final state = Get.find<GroupDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupDetailLogic>(builder: (logic) {
      return Scaffold(
        appBar: TitleBar(
          title: state.entity.groupName ?? '',
          subTitle: state.entity.groupCode,
        ),
        body: Obx(() {
          if (state.pageStatus.value == PageStatus.success) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ExpandableNotifier(
                      initialExpanded: true,
                      child: ScrollOnExpand(
                        scrollOnExpand: true,
                        scrollOnCollapse: false,
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                              alignment: Alignment.topCenter,
                              tapBodyToCollapse: false,
                              iconPadding: EdgeInsets.only(right: 28.w),
                              hasIcon: false),
                          header: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 12.w),
                            child: Row(
                              children: [
                                LoadSvgImage(
                                  'group_team',
                                  width: 17.w,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  '团队工单 ${state.dataList.length}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colours.text_333,
                                  ),
                                ),
                                const Spacer(),
                                CustomExpandableIcon(),
                              ],
                            ),
                          ),
                          collapsed: Container(),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: state.dataList.isNotEmpty
                                ? state.dataList
                                    .map((element) => TaskItem(
                                          entity: element,
                                          isMaintananceGroup: true,
                                          controller: logic,
                                          onResult: logic.query,
                                        ))
                                    .toList()
                                : [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 6.w),
                                      child: Text(
                                        '- 暂无团队工单 -',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colours.text_333,
                                        ),
                                      ),
                                    )
                                  ],
                          ),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: EdgeInsets.zero,
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                              ),
                            );
                          },
                        ),
                      )),
                  FixGroupMemberHeaderWidget(
                    dataList: state.groupModel.value?.employees ?? [],
                  ),
                  FixGroupProjectHeaderWidget(
                    dataList: state.groupModel.value?.projects ?? [],
                    groupCode: state.groupModel.value?.groupCode ?? '',
                  ),
                  SizedBox(height: 10.w),
                ],
              ),
            );
          } else if (state.pageStatus.value == PageStatus.error) {
            return ErrorPage();
          } else if (state.pageStatus.value == PageStatus.loading) {
            return CenterLoading();
          } else {
            return EmptyPage();
          }
        }),
      );
    });
  }
}
