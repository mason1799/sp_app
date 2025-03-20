import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/entity/department_info_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/alert_bottom_sheet.dart';
import 'package:sprintf/sprintf.dart';

import 'member_detail_state.dart';

class MemberDetailLogic extends BaseController {
  final MemberDetailState state = MemberDetailState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await get<CustomFieldListEntity>(sprintf(Api.memberDetail, [state.id]));
    if (result.success) {
      state.customFieldListEntity = result.data!;
      state.pageStatus = PageStatus.success;
      final deptResult = await get<List<DepartmentInfoEntity>>(Api.branchDepartment);
      if (deptResult.success) {
        state.departments = deptResult.data?.map((e) => DepartmentNode.fromEntity(e)).toList() ?? [];
      }
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  moreAction() {
    showAlertBottomSheet(
      ['编辑'],
      (data, index) async {
        Get.offNamed(Routes.memberEdit, arguments: {'id': state.id});
      },
    );
  }
}
