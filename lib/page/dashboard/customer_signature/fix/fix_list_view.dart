import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import '../widget/item_widget.dart';
import 'fix_list_logic.dart';
import 'fix_list_state.dart';

class FixListPage extends StatelessWidget {
  FixListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put<FixListLogic>(FixListLogic());
    final state = Get.find<FixListLogic>().state;
    return GetBuilder<FixListLogic>(builder: (_) {
      if (state.pageStatus == PageStatus.success) {
        return Column(
          children: [
            Expanded(child: _Body(state: state)),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 12.w, bottom: 12.w + ScreenUtil().bottomBarHeight),
              child: Center(
                child: TextBtn(
                  onPressed: logic.toItem,
                  size: Size(double.infinity, 44.w),
                  text: '客户签字',
                  radius: 7.w,
                  backgroundColor: Colours.primary,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      } else if (state.pageStatus == PageStatus.loading) {
        return CenterLoading();
      } else if (state.pageStatus == PageStatus.empty) {
        return EmptyPage();
      } else {
        return ErrorPage();
      }
    });
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.state,
  });

  final FixListState state;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return ExpandableListView(
      padding: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
      builder: SliverExpandableChildDelegate<ProjectSectionListModel, ProjectSection>(
        sectionList: widget.state.items!,
        headerBuilder: (context, sectionIndex, index) {
          ProjectSection section = widget.state.items![sectionIndex];
          return InkWell(
            onTap: () {
              setState(() {
                widget.state.items![sectionIndex].setSectionExpanded(!widget.state.items![sectionIndex].isSectionExpanded());
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: section.isSectionExpanded()
                    ? BorderRadius.only(topLeft: Radius.circular(6.w), topRight: Radius.circular(6.w))
                    : BorderRadius.circular(6.w),
              ),
              child: ProjectWidget(
                section: section,
                selectAll: () {
                  setState(() {
                    bool hasUnSelect = false;
                    for (var value in widget.state.items![sectionIndex].items) {
                      if (value.select == false) {
                        hasUnSelect = true;
                        break;
                      }
                    }
                    for (var value in widget.state.items![sectionIndex].items) {
                      value.select = hasUnSelect;
                    }
                  });
                },
              ),
            ),
          );
        },
        sticky: false,
        separatorBuilder: (context, isSectionSeparator, index) => SizedBox(height: isSectionSeparator ? 10.w : 0),
        itemBuilder: (context, sectionIndex, itemIndex, index) => Cell(
          lastIndex: itemIndex == widget.state.items![sectionIndex].items.length - 1,
          data: widget.state.items![sectionIndex].items[itemIndex],
          type: 1,
        ),
      ),
    );
  }
}
