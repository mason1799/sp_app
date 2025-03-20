import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_list_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/widget/error_page.dart';

import 'search_task_result_state.dart';

class SearchTaskResultLogic extends BaseController {
  final SearchTaskResultState state = SearchTaskResultState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await post<TaskListEntity>(
      Api.queryTaskList,
      params: {
        'taskDate': DateUtil.getYmdTimestamp(DateTime.now()),
        'orderType': 2,
      },
    );
    if (result.success) {
      state.items = result.data!.orders ?? [];
      state.pageStatus = state.items!.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update(['search_result']);
  }

  toSearch() {
    Get.offNamed(Routes.search, arguments: {'type': 1, 'keyword': state.keyword});
  }
}
