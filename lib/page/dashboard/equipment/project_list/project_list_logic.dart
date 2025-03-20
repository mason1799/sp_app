import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import 'project_list_state.dart';

class ProjectListLogic extends BaseController {
  final ProjectListState state = ProjectListState();

  Future<void> pull() async {
    state.currentPage = 1;
    await query();
  }

  Future<void> loadMore() async {
    state.currentPage++;
    await query();
  }

  Future<void> query() async {
    final result = await post<List<ProjectEntity>>(
      Api.searchProjectList,
      params: {
        'pageSize': 10,
        'page': state.currentPage,
      },
    );
    if (result.success) {
      if (state.currentPage == 1) {
        state.items.clear();
      }
      state.items.addAll(result.data ?? []);
      state.hasMore = result.hasMore;
      state.pageStatus = state.items.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update();
  }

  toItem(ProjectEntity entity) {
    Get.toNamed(Routes.projectDetail, arguments: {'id': entity.id});
  }

  toSearch() {
    Get.toNamed(Routes.search, arguments: {'type': 0});
  }
}
