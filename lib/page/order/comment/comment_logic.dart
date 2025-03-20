import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/dashboard/customer_signature/customer_signature_logic.dart';
import 'package:konesp/page/dashboard/customer_signature/regular/regular_list_logic.dart';
import 'package:konesp/page/dashboard/safeguard_signature/safeguard_signature_logic.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';

import 'comment_state.dart';

class CommentLogic extends BaseController {
  final CommentState state = CommentState();

  void confirm() async {
    if (ObjectUtil.isEmpty(state.signatureKey)) {
      showToast('请添加签字');
      return;
    }
    if (state.type > 0) {
      if (ObjectUtil.isEmpty(state.approveOperatorController.text)) {
        showToast('请输入审核人');
        return;
      }
      if (state.selectedLevel == null) {
        showToast('请选择审核意见');
        return;
      }
    } else {
      if (ObjectUtil.isEmpty(state.approveAdviceController.text)) {
        showToast('请输入审核意见');
        return;
      }
    }
    showProgress();
    final result = await post(
      state.type == 0 ? Api.submitSafeguardSign : Api.submitRegularOrderMultipleSign,
      params: {
        'ids': state.ids,
        'url': state.signatureKey,
        'approvalBy': state.type == 0 ? null : state.approveOperatorController.text,
        'approvalReasonType': state.type == 0 ? null : state.selectedLevel,
        'approvalReason': state.type == 0 ? state.approveAdviceController.text : null,
      },
    );
    closeProgress();
    if (result.success) {
      showToast('提交成功');
      Get.back();
      if (state.type == 0) {
        if (Get.isRegistered<SafeguardSignatureLogic>()) {
          Get.find<SafeguardSignatureLogic>().query();
        }
      } else {
        if (Get.isRegistered<CustomerSignatureLogic>()) {
          Get.find<CustomerSignatureLogic>().query();
        }
        if (Get.isRegistered<RegularListLogic>()) {
          Get.find<RegularListLogic>().query();
        }
      }
    } else {
      showToast(result.msg);
    }
  }

  void checkRadio(int? value) {
    state.selectedLevel = value;
    update(['radio']);
  }

  void toSignatureBoard() {
    Get.toNamed(Routes.signatureBoard, arguments: {'type': 4});
  }

  void updateSignature(String ossKey) {
    state.signatureKey = ossKey;
    update(['signatureKey']);
  }
}
