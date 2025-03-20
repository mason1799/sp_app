import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/custom_expand_icon.dart';
import 'package:konesp/widget/load_image.dart';

import '../list/group_list_logic.dart';

/// 组员相关组件
class FixGroupMemberHeaderWidget extends StatefulWidget {
  const FixGroupMemberHeaderWidget({Key? key, required this.dataList}) : super(key: key);
  final List<TaskMember> dataList;

  @override
  State<FixGroupMemberHeaderWidget> createState() => _FixGroupMemberHeaderWidgetState();
}

class _FixGroupMemberHeaderWidgetState extends State<FixGroupMemberHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
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
                      'group_member',
                      width: 17.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '组员 ${widget.dataList.length}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colours.text_333,
                      ),
                    ),
                    const Spacer(),
                    CustomExpandableIcon(),
                  ],
                )),
            collapsed: SizedBox(),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ObjectUtil.isNotEmpty(widget.dataList)
                  ? widget.dataList.map((e) => GroupMemberWidget(data: e)).toList()
                  : [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 6.w),
                        child: Text(
                          '- 暂无组员 -',
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
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                ),
              );
            },
          ),
        ));
  }
}

class GroupMemberWidget extends StatefulWidget {
  const GroupMemberWidget({Key? key, required this.data}) : super(key: key);
  final TaskMember data;

  @override
  State<GroupMemberWidget> createState() => _GroupMemberWidgetState();
}

class _GroupMemberWidgetState extends State<GroupMemberWidget> {
  final state = Get.find<GroupListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.groupMemberDetail, arguments: [widget.data, state.belongGroupName]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w, top: 12.w, bottom: 12.w),
              child: LoadImage(
                widget.data.avatar ?? '',
                width: 40.w,
                height: 40.w,
                borderRadius: BorderRadius.circular(20.w),
                holderImg: 'default_avatar',
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.data.username ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colours.text_333,
                          ),
                        ),
                        if (widget.data.leader == true)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.w),
                              color: Colours.orange,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              '组长',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (widget.data.id == StoreLogic.to.getUser()?.id.toString())
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.w),
                              color: Colours.primary,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              '自己',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.w),
                          child: Text(
                            '今日',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colours.primary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.w, left: 10.w),
                          child: Text(
                            '未响应${widget.data.awaitFinish ?? 0} | 响应中${widget.data.response ?? 0} | 已完成${widget.data.finish ?? 0}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colours.text_999,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: LoadSvgImage(
                'arrow_right',
                width: 14.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FixGroupProjectHeaderWidget extends StatefulWidget {
  const FixGroupProjectHeaderWidget({Key? key, required this.dataList, required this.groupCode}) : super(key: key);
  final List<TaskProject> dataList;
  final String groupCode;

  @override
  State<FixGroupProjectHeaderWidget> createState() => _FixGroupProjectHeaderWidgetState();
}

class _FixGroupProjectHeaderWidgetState extends State<FixGroupProjectHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        initialExpanded: true,
        child: ScrollOnExpand(
          scrollOnExpand: true,
          scrollOnCollapse: false,
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center, alignment: Alignment.topCenter, tapBodyToCollapse: false, hasIcon: false),
            header: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 12.w),
                child: Row(
                  children: [
                    LoadSvgImage(
                      'group_project',
                      width: 17.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '项目 ${widget.dataList.length}',
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
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ObjectUtil.isNotEmpty(widget.dataList)
                  ? widget.dataList
                      .map((e) => GroupProjectWidget(
                            data: e,
                            groupCode: widget.groupCode,
                          ))
                      .toList()
                  : [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 6.w),
                        child: Text(
                          '- 暂无项目 -',
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
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                ),
              );
            },
          ),
        ));
  }
}

class GroupProjectWidget extends StatefulWidget {
  const GroupProjectWidget({Key? key, required this.data, required this.groupCode}) : super(key: key);
  final TaskProject data;
  final String groupCode;

  @override
  State<GroupProjectWidget> createState() => _GroupProjectWidgetState();
}

class _GroupProjectWidgetState extends State<GroupProjectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.groupProjectDetail, arguments: [widget.data, widget.groupCode]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
        padding: EdgeInsets.only(left: 18.w, right: 12.w, top: 12.w, bottom: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.data.projectName ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_333,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.w),
                    child: Row(
                      children: [
                        LoadSvgImage(
                          'ticket_location',
                          width: 10.w,
                        ),
                        Expanded(
                          child: Text(
                            widget.data.projectLocation ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colours.text_999,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.w),
                        child: Text(
                          '今日',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.primary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.w, left: 10.w),
                        child: Text(
                          '未响应${widget.data.awaitFinish ?? 0} | 响应中${widget.data.response ?? 0} | 已完成${widget.data.finish ?? 0}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.text_999,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: LoadSvgImage(
                'arrow_right',
                width: 14.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
