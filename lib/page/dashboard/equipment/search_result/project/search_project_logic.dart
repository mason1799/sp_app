import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import 'search_project_state.dart';

class SearchProjectLogic extends BaseController {
  final SearchProjectState state = SearchProjectState();

  SearchProjectLogic({required String keyword}) {
    state.keyword = keyword;
  }

  @override
  void onReady() {
    pull();
  }

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
        'searchCondition': state.keyword,
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
      state.pageStatus = (state.items.isNotEmpty ? PageStatus.success : PageStatus.empty);
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update();
  }

  toItem(int id) {
    Get.offNamed(Routes.projectDetail, arguments: {'id': id});
  }
}
