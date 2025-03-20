import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/customer_sign_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/dashboard/customer_signature/widget/item_widget.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import '../customer_signature_logic.dart';
import 'fix_list_state.dart';

class FixListLogic extends BaseController {
  final FixListState state = FixListState();

  @override
  void onReady() {
    query();
  }

  query() async {
    int start = 0;
    int end = 0;
    if (Get.isRegistered<CustomerSignatureLogic>()) {
      start = Get.find<CustomerSignatureLogic>().state.selectDateRange[0].millisecondsSinceEpoch;
      end = Get.find<CustomerSignatureLogic>().state.selectDateRange[1].millisecondsSinceEpoch;
    }
    if (start == 0 || end == 0) {
      return;
    }
    final result = await post<List<CustomerSignProject>>(
      Api.fixOrdersUnsignList,
      params: {'startDate': start, 'endDate': end},
    );
    if (result.success) {
      state.items = result.data
              ?.map((e) => ProjectSection(
                    items: e.repairs
                            ?.map((element) => ProjectSectionListModel(
                                  title: '${e.projectName ?? ''}${element.buildingCode ?? ''}${element.elevatorCode ?? ''}',
                                  id: element.id,
                                ))
                            .toList() ??
                        [],
                    projectName: e.projectName,
                    projectLocation: e.projectLocation,
                    unSignNumber: e.unSignNumber,
                  ))
              .toList() ??
          [];
      state.pageStatus = state.items!.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void toItem() {
    if (state.items == null) {
      return;
    }
    List<ProjectSection> signList = [];
    for (var value in state.items!) {
      for (var value1 in value.items) {
        if (value1.select) {
          if (!signList.contains(value)) {
            signList.add(value);
          }
        }
      }
    }
    if (signList.isEmpty) {
      showToast('请选择项目');
      return;
    }
    if (signList.length >= 2) {
      showToast('只能选择一个项目');
      return;
    }
    Get.toNamed(Routes.signatureBoard, arguments: {'type': 3});
  }

  void uploadSign(String signatureKey) async {
    if (state.items == null) {
      return;
    }
    List<int> ids = [];
    state.items!.map((e) {
      e.items.map((element) {
        if (element.select && element.id != null) {
          ids.add(element.id!);
        }
      }).toList();
    }).toList();
    showProgress();
    final result = await post(
      Api.submitFixOrderMultipleSign,
      params: {
        'ids': ids,
        'url': signatureKey,
      },
    );
    closeProgress();
    if (result.success) {
      showToast('签字成功');
      await query();
      if (Get.isRegistered<CustomerSignatureLogic>()) {
        Get.find<CustomerSignatureLogic>().query();
      }
    } else {
      showToast(result.msg);
    }
  }
}
