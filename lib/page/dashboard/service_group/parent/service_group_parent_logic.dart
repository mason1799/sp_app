import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/user_department_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import 'service_group_parent_state.dart';

class ServiceGroupParentLogic extends BaseController {
  final ServiceGroupParentState state = ServiceGroupParentState();

  Future<void> pull() async {
    await query();
  }

  query() async {
    final result = await get<List<UserDepartmentEntity>>(Api.teamMemberDepartments);
    if (result.success) {
      state.items = result.data ?? [];
      state.pageStatus = state.items!.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  toItem(String id) {
    Get.toNamed(Routes.serviceGroupList, arguments: {'id': id});
  }
}
