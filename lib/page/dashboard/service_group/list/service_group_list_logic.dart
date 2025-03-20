import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/service_group_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import 'service_group_list_state.dart';

class ServiceGroupListLogic extends BaseController {
  final ServiceGroupListState state = ServiceGroupListState();

  Future<void> pull() async {
    await query();
  }

  query() async {
    final result = await post<List<ServiceGroupEntity>>(
      Api.serviceGroups,
      params: {'departmentId': state.departmentId},
    );
    if (result.success) {
      state.items = result.data ?? [];
      state.pageStatus = state.items!.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  toItem(ServiceGroupEntity entity) {
    Get.toNamed(Routes.serviceGroupDetail, arguments: entity);
  }
}
