import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/page/task/my_task/widget/task_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/custom_expand_icon.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';

import '../list/group_list_logic.dart';
import 'group_widget.dart';

class GroupPage extends StatelessWidget {
  GroupPage({required this.logic});

  final GroupListLogic logic;

  @override
  Widget build(BuildContext context) {
    if (logic.state.pageStatus == PageStatus.error) {
      return ErrorPage();
    } else {
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
                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.w),
                      child: Row(
                        children: [
                          LoadSvgImage(
                            'group_team',
                            width: 17.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '团队工单 ${logic.state.dataList.length}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colours.text_333,
                            ),
                          ),
                          const Spacer(),
                          CustomExpandableIcon(),
                        ],
                      )),
                  collapsed: Container(),
                  expanded: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ObjectUtil.isNotEmpty(logic.state.dataList)
                          ? List.generate(
                              logic.state.dataList.length,
                              (index) => TaskItem(
                                    entity: logic.state.dataList[index],
                                    isMaintananceGroup: true,
                                    controller: logic,
                                    onResult: logic.query,
                                  ))
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
                  ),
                  builder: (_, collapsed, expanded) => Padding(
                    padding: EdgeInsets.zero,
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                    ),
                  ),
                ),
              ),
            ),
            FixGroupMemberHeaderWidget(dataList: logic.state.groupModel?.employees ?? []),
            FixGroupProjectHeaderWidget(
              dataList: logic.state.groupModel?.projects ?? [],
              groupCode: logic.state.groupModel?.groupCode ?? '',
            ),
          ],
        ),
      );
    }
  }
}
