import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/my_refresh_list.dart';

import '../../widget/project_item.dart';
import 'search_project_logic.dart';

class SearchProjectPage extends StatelessWidget {
  final String keyword;

  SearchProjectPage({
    Key? key,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    final _init = SearchProjectLogic(keyword: keyword);
    Get.create<SearchProjectLogic>(() => _init, permanent: false);
    return Container(
      decoration: BoxDecoration(
        color: Colours.bg,
      ),
      child: GetBuilder<SearchProjectLogic>(
        global: false,
        init: _init,
        builder: (logic) {
          final state = logic.state;
          if (state.pageStatus == PageStatus.success) {
            return RefreshListView(
              padding: EdgeInsets.zero,
              itemCount: state.items.length,
              onRefresh: () => logic.pull(),
              onLoadMore: () => logic.loadMore(),
              hasMore: state.hasMore,
              itemBuilder: (context, index) {
                ProjectEntity projectEntity = state.items[index];
                return Padding(
                  padding: EdgeInsets.only(top: 10.w),
                  child: ProjectItem(
                    projectEntity: projectEntity,
                    onItem: () => logic.toItem(projectEntity.id!),
                  ),
                );
              },
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
