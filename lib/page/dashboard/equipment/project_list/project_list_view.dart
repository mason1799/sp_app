import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/search_placehold.dart';
import 'package:konesp/widget/title_bar.dart';

import '../widget/project_item.dart';
import 'project_list_logic.dart';

class ProjectListPage extends StatelessWidget {
  final logic = Get.put(ProjectListLogic());
  final state = Get.find<ProjectListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '我的设备',
      ),
      body: GetBuilder<ProjectListLogic>(
        builder: (_) => AdvanceRefreshListView(
          itemCount: state.items.length + 1,
          onRefresh: () => logic.pull(),
          onLoadMore: () => logic.loadMore(),
          hasMore: state.hasMore,
          pageStatus: state.pageStatus,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                child: SearchPlacehold(
                  onSearch: logic.toSearch,
                  hintText: '搜索项目/设备',
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(top: index < 1 ? 0 : 10.w),
              child: ProjectItem(
                projectEntity: state.items[index - 1],
                onItem: () => logic.toItem(state.items[index - 1]),
              ),
            );
          },
        ),
      ),
    );
  }
}
