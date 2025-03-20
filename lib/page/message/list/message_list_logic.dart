import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/message_list_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import 'message_list_state.dart';

class MessageListLogic extends BaseController {
  final MessageListState state = MessageListState();

  Future<void> pull() async {
    state.currentPage = 1;
    await query();
  }

  Future<void> loadMore() async {
    state.currentPage++;
    await query();
  }

  Future<void> query() async {
    final result = await post<List<MessageListEntity>>(
      Api.messageListOfType,
      params: {
        'type': state.type,
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
      state.pageStatus = state.items.isEmpty ? PageStatus.empty : PageStatus.success;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void viewDetail(int bizId) async {
    if (![1, 2].contains(state.type)) {
      return;
    }
    Get.toNamed(state.type == 1 ? Routes.regularDetail : Routes.fixDetail, arguments: {'id': bizId});
  }

  void retry() {
    state.pageStatus = PageStatus.loading;
    update();
    pull();
  }
}
