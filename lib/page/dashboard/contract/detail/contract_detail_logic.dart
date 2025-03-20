import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/alert_bottom_sheet.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:sprintf/sprintf.dart';

import '../list/contract_list_logic.dart';
import 'contract_detail_state.dart';

class ContractDetailLogic extends BaseController {
  final ContractDetailState state = ContractDetailState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await get<CustomFieldListEntity>(sprintf(Api.contractDetail, [state.id!]));
    if (result.success) {
      state.customFieldListEntity = result.data!;
      state.pageStatus = PageStatus.success;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  moreAction() {
    List<String> items = [];
    if (StoreLogic.to.permissions.contains(UserPermission.contractEdit)) {
      items.add('编辑');
    }
    if (StoreLogic.to.permissions.contains(UserPermission.deleteContract)) {
      items.add('删除');
    }
    if (items.isNotEmpty) {
      showAlertBottomSheet(items, (data, index) async {
        if (data == '编辑') {
          Get.offNamed(Routes.contractEdit, arguments: {'id': state.id});
        } else if (data == '删除') {
          Get.dialog(
            ConfirmDialog(
              content: '你确定要删除该合同吗?',
              onConfirm: () async {
                showProgress();
                final result = await delete(sprintf(Api.deleteContract, [state.id]));
                closeProgress();
                if (result.success) {
                  if (Get.isRegistered<ContractListLogic>()) {
                    Get.find<ContractListLogic>().deleteContract(state.id);
                  }
                  showToast('合同删除成功');
                  Get.back();
                } else {
                  showToast(result.msg);
                }
              },
            ),
          );
        }
      });
    }
  }
}
