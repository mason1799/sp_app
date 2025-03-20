import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_tab_indicator.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/keep_alive_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import '../customer_signature/widget/item_widget.dart';
import 'safeguard_signature_logic.dart';

class SafeguardSignaturePage extends StatelessWidget {
  final logic = Get.find<SafeguardSignatureLogic>();
  final state = Get.find<SafeguardSignatureLogic>().state;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: TitleBar(
          title: '安全员签字',
        ),
        body: GetBuilder<SafeguardSignatureLogic>(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                height: 40.w,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: logic.selectDateRange,
                      child: Text(
                        '${DateUtil.formatDate(state.selectDateRange[0], format: DateFormats.ymd)} - ${DateUtil.formatDate(state.selectDateRange[1], format: DateFormats.ymd)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_333,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: LoadSvgImage(
                          'arrow_right',
                          width: 10.w,
                          color: Colours.text_333,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 32.w,
                margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
                child: TabBar(
                  labelColor: Colours.text_333,
                  indicatorColor: Colours.primary,
                  indicatorSize: TabBarIndicatorSize.label,
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
                  unselectedLabelColor: Colours.text_666,
                  dividerHeight: 0,
                  tabs: [Tab(text: '例行保养')],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    keepAlivePage(ListWidget(logic: logic)),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class ListWidget extends StatefulWidget {
  const ListWidget({
    super.key,
    required this.logic,
  });

  final SafeguardSignatureLogic logic;

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    final state = widget.logic.state;
    if (state.pageStatus == PageStatus.success) {
      return Column(
        children: [
          Expanded(
            child: ExpandableListView(
              padding: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
              builder: SliverExpandableChildDelegate<ProjectSectionListModel, ProjectSection>(
                sectionList: state.items,
                headerBuilder: (context, sectionIndex, index) => InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: state.items[sectionIndex].isSectionExpanded()
                              ? BorderRadius.only(topLeft: Radius.circular(6.w), topRight: Radius.circular(6.w))
                              : BorderRadius.circular(6.w),
                        ),
                        child: ProjectWidget(
                          section: state.items[sectionIndex],
                          selectAll: () {
                            setState(() {
                              bool hasUnSelect = false;
                              for (var value in state.items[sectionIndex].items) {
                                if (value.select == false) {
                                  hasUnSelect = true;
                                  break;
                                }
                              }
                              for (var value in state.items[sectionIndex].items) {
                                value.select = hasUnSelect;
                              }
                            });
                          },
                        )),
                    onTap: () {
                      setState(() {
                        state.items[sectionIndex].setSectionExpanded(!state.items[sectionIndex].isSectionExpanded());
                      });
                    }),
                sticky: false,
                separatorBuilder: (context, isSectionSeparator, index) => SizedBox(height: isSectionSeparator ? 10.w : 0),
                itemBuilder: (context, sectionIndex, itemIndex, index) => Cell(
                  lastIndex: itemIndex == state.items[sectionIndex].items.length - 1,
                  data: state.items[sectionIndex].items[itemIndex],
                  type: 0,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 12.w, bottom: 12.w + ScreenUtil().bottomBarHeight),
            child: Center(
              child: TextBtn(
                onPressed: widget.logic.toSignatureApprove,
                size: Size(double.infinity, 44.w),
                text: '安全员签字',
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
    } else if (state.pageStatus == PageStatus.error) {
      return ErrorPage();
    } else if (state.pageStatus == PageStatus.loading) {
      return CenterLoading();
    } else {
      return EmptyPage();
    }
  }
}
