import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/contract_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';

import 'contract_list_state.dart';

class ContractListLogic extends BaseController {
  final ContractListState state = ContractListState();

  Future<void> pull() async {
    state.currentPage = 1;
    await query();
  }

  Future<void> loadMore() async {
    state.currentPage++;
    await query();
  }

  Future<void> query() async {
    String _search = state.searchController.text;
    final result = await post<List<ContractEntity>>(
      Api.contractList,
      params: {
        'searchCondition': ObjectUtil.isNotEmpty(_search) ? _search : null,
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

  toDetail(int id) {
    Get.toNamed(Routes.contractDetail, arguments: {'id': id});
  }

  deleteContract(int id) async {
    state.items.removeWhere((element) => element.id == id);
    state.pageStatus = state.items.isNotEmpty ? PageStatus.success : PageStatus.empty;
    update();
  }

  search() {
    Get.focusScope?.unfocus();
    state.pageStatus = PageStatus.loading;
    update();
    onReady();
  }
}
