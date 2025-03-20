import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';

import '../../widget/equipment_item.dart';
import '../../widget/project_item.dart';
import 'search_summary_logic.dart';

class SearchSummaryPage extends StatelessWidget {
  final String keyword;

  SearchSummaryPage({
    Key? key,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    final _init = SearchSummaryLogic(keyword: keyword);
    Get.create<SearchSummaryLogic>(() => _init, permanent: false);
    return Container(
      decoration: BoxDecoration(
        color: Colours.bg,
      ),
      child: GetBuilder<SearchSummaryLogic>(
        global: false,
        init: _init,
        builder: (logic) {
          final state = logic.state;
          if (state.pageStatus == PageStatus.success) {
            return RefreshIndicator(
              onRefresh: () => logic.pull(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (ObjectUtil.isNotEmpty(state.searchSummaryEntity!.project))
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Section(
                            title: '项目',
                            number: state.searchSummaryEntity!.projectNum ?? 0,
                            onView: () => logic.animateToTab(1),
                          ),
                          ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(top: index == 0 ? 0 : 10.w),
                              child: ProjectItem(
                                projectEntity: state.searchSummaryEntity!.project![index],
                                onItem: () => logic.toProjectItem(state.searchSummaryEntity!.project![index].id!),
                              ),
                            ),
                            itemCount: state.searchSummaryEntity!.project?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          SizedBox(height: 10.w),
                        ],
                      ),
                    if (ObjectUtil.isNotEmpty(state.searchSummaryEntity!.equipmentInfoVoList))
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Section(
                            title: '设备',
                            number: state.searchSummaryEntity!.equipmentInfoNum ?? 0,
                            onView: () => logic.animateToTab(2),
                          ),
                          ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(top: index == 0 ? 0 : 10.w),
                              child: EquipmentItem(
                                entity: state.searchSummaryEntity!.equipmentInfoVoList![index],
                                onTap: () => logic.toEquipmentItem(state.searchSummaryEntity!.equipmentInfoVoList![index].id!),
                              ),
                            ),
                            itemCount: state.searchSummaryEntity!.equipmentInfoVoList?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          SizedBox(height: 10.w),
                        ],
                      ),
                  ],
                ),
              ),
            );
          } else if (state.pageStatus == PageStatus.error) {
            return ErrorPage();
          } else if (state.pageStatus == PageStatus.loading) {
            return CenterLoading();
          } else {
            return EmptyPage(msg: '暂无搜索结果');
          }
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.number,
    required this.onView,
  });

  final String title;
  final int number;
  final Function() onView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colours.text_333,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onView,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '共',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_333,
                        ),
                      ),
                      TextSpan(
                        text: number.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.primary,
                        ),
                      ),
                      TextSpan(
                        text: '个',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.text_333,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                LoadSvgImage(
                  'arrow_right',
                  width: 15.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
