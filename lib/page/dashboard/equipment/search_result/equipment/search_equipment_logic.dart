import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/project_detail_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';

import 'search_equipment_state.dart';

class SearchEquipmentLogic extends BaseController {
  final SearchEquipmentState state = SearchEquipmentState();

  SearchEquipmentLogic({required String keyword}) {
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
    final result = await post<List<ProjectDetailEntity>>(
      Api.equipmentList,
      params: {
        'searchCondition': state.keyword,
        'pageSize': 10,
        'page': state.currentPage,
      },
    );
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data!)) {
        if (state.currentPage == 1) {
          state.items.clear();
        }
        for(final entity in result.data!){
          state.items.addAll(entity.equipmentInfoVoList ?? []);
        }
        state.hasMore = result.hasMore;
        state.pageStatus = PageStatus.success;
      } else {
        state.pageStatus = PageStatus.empty;
      }
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update();
  }

  toItem(int id) {
    Get.offNamed(Routes.equipmentDetail, arguments: {'id': id});
  }
}
