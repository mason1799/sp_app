import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/search_summary_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';

import '../search_result_logic.dart';
import 'search_summary_state.dart';

class SearchSummaryLogic extends BaseController {
  final SearchSummaryState state = SearchSummaryState();

  SearchSummaryLogic({required String keyword}) {
    state.keyword = keyword;
  }

  @override
  void onReady() {
    pull();
  }

  pull() async {
    await query();
  }

  Future<void> query() async {
    final result = await post<SearchSummaryEntity>(
      Api.searchProjectAndEquipment,
      params: {
        'searchCondition': state.keyword,
      },
    );
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data?.project) || ObjectUtil.isNotEmpty(result.data?.equipmentInfoVoList)) {
        state.pageStatus = PageStatus.success;
        state.searchSummaryEntity = result.data!;
      } else {
        state.pageStatus = PageStatus.empty;
      }
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update();
  }

  animateToTab(int index) {
    if (Get.isRegistered<SearchResultLogic>()) {
      Get.find<SearchResultLogic>().animateTo(index);
    }
  }

  toProjectItem(int id) {
    Get.offNamed(Routes.projectDetail, arguments: {'id': id});
  }

  toEquipmentItem(int id) {
    Get.offNamed(Routes.equipmentDetail, arguments: {'id': id});
  }

}
