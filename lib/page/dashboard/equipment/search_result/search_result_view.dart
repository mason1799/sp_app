import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/keep_alive_page.dart';
import 'package:konesp/widget/search_placehold.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'equipment/search_equipment_view.dart';
import 'project/search_project_view.dart';
import 'search_result_logic.dart';
import 'search_result_state.dart';
import 'summary/search_summary_view.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({Key? key}) : super(key: key);

  final logic = Get.find<SearchResultLogic>();
  final state = Get.find<SearchResultLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 10.w, bottom: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchPlacehold(
                          onSearch: logic.toSearch,
                          hintText: state.keyword,
                          hintColor: Colours.text_333,
                        ),
                      ),
                      InkWell(
                        onTap: Get.back,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 34.w,
                          alignment: Alignment.center,
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: _Tabview(state: state),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tabview extends StatefulWidget {
  const _Tabview({
    required this.state,
  });

  final SearchResultState state;

  @override
  State<_Tabview> createState() => _TabviewState();
}

class _TabviewState extends State<_Tabview> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.state.tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    widget.state.tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36.w,
          color: Colours.bg,
          child: TabBar(
            controller: widget.state.tabController,
            labelColor: Colours.text_333,
            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            unselectedLabelColor: Colours.text_999,
            isScrollable: false,
            unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            indicatorSize: TabBarIndicatorSize.label,
            dividerHeight: 0,
            indicator: MaterialIndicator(
              topLeftRadius: 1.5.w,
              topRightRadius: 1.5.w,
              bottomLeftRadius: 1.5.w,
              bottomRightRadius: 1.5.w,
              color: Colours.primary,
              height: 3.w,
            ),
            tabs: widget.state.tabs,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: widget.state.tabController,
            children: [
              keepAlivePage(SearchSummaryPage(keyword: widget.state.keyword)),
              keepAlivePage(SearchProjectPage(keyword: widget.state.keyword)),
              keepAlivePage(SearchEquipmentPage(keyword: widget.state.keyword)),
            ],
          ),
        ),
      ],
    );
  }
}
