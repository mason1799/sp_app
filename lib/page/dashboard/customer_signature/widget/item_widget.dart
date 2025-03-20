import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

class ProjectWidget extends StatefulWidget {
  const ProjectWidget({
    super.key,
    required this.section,
    required this.selectAll,
  });

  final ProjectSection section;
  final VoidCallback selectAll;

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, top: 12.w, bottom: 12.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.section.projectName ?? '',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colours.text_333,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5.w),
                    Row(
                      children: [
                        LoadSvgImage(
                          'ticket_location2',
                          width: 14.w,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            widget.section.projectLocation ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colours.text_333,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.w),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '待签字${widget.section.unSignNumber ?? 0}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colours.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.section.isSectionExpanded())
                InkWell(
                  onTap: widget.selectAll,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                    child: Text(
                      '全选',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colours.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// type 保养0 故障1
class Cell extends StatefulWidget {
  const Cell({super.key, required this.lastIndex, required this.data, required this.type});

  final ProjectSectionListModel data;
  final bool lastIndex;
  final int type;

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.data.id == null) {
          return;
        }
        Get.toNamed(widget.type == 0 ? Routes.regularDetail : Routes.fixDetail, arguments: {'id': widget.data.id});
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: widget.lastIndex ? BorderRadius.only(bottomLeft: Radius.circular(6.w), bottomRight: Radius.circular(6.w)) : null,
          border: Border(
            top: BorderSide(width: 0.5.w, color: Colours.bg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              height: 24.w,
              decoration: BoxDecoration(
                color: Colours.primary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.w),
                  bottomRight: Radius.circular(12.w),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadSvgImage(
                    widget.type == 0 ? 'work_order_keep_title' : 'kone_ticket_report',
                    width: 16.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.type == 0 ? '例行保养' : '故障报修',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.w),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.data.select == true) {
                        widget.data.select = false;
                      } else {
                        widget.data.select = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Checkbox(
                      value: widget.data.select,
                      onChanged: (value) {
                        setState(() {
                          widget.data.select = value ?? false;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: double.infinity),
                        child: Text(
                          widget.data.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                      if (ObjectUtil.isNotEmpty(widget.data.body))
                        Padding(
                          padding: EdgeInsets.only(top: 5.w),
                          child: Text(
                            widget.data.body!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colours.text_333,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  '详情',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colours.primary,
                  ),
                ),
                SizedBox(width: 15.w),
              ],
            ),
            SizedBox(height: 10.w),
          ],
        ),
      ),
    );
  }
}

class ProjectSection implements ExpandableListSection<ProjectSectionListModel> {
  String? projectName;
  String? projectLocation;
  int? unSignNumber;
  bool expanded;

  List<ProjectSectionListModel> items;

  ProjectSection({
    this.projectName,
    this.projectLocation,
    this.unSignNumber,
    this.expanded = false,
    required this.items,
  });

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    if (expanded == false) {
      for (var element in items) {
        element.select = false;
      }
    }
    this.expanded = expanded;
  }

  @override
  List<ProjectSectionListModel>? getItems() {
    return items;
  }
}

class ProjectSectionListModel {
  bool select;
  String? title;
  String? body;
  int? id;

  ProjectSectionListModel({this.select = false, this.title, this.body, this.id});
}

class AnimateRotateIcon extends StatelessWidget {
  const AnimateRotateIcon({
    Key? key,
    @Deprecated('use quarterTurns') bool? isSelected,
    required this.icon,
    int quarterTurns = 0,
  })  : quarterTurns = isSelected != null ? (isSelected == true ? 2 : 0) : quarterTurns,
        super(key: key);

  final Widget icon;

  /// 顺时针旋转角度：0, 1， 2， 3
  final int quarterTurns;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: quarterTurns / 4,
      duration: const Duration(milliseconds: 300),
      child: icon,
    );
  }
}
