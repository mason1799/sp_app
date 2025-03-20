import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/customer_sign_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/dashboard/customer_signature/customer_signature_logic.dart';
import 'package:konesp/page/dashboard/customer_signature/widget/item_widget.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import 'regular_list_state.dart';

class RegularListLogic extends BaseController {
  final RegularListState state = RegularListState();

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
      Api.regularOrderUnsignList,
      params: {'startDate': start, 'endDate': end},
    );
    if (result.success) {
      state.items = result.data
              ?.map((e) => ProjectSection(
                  items: e.orders
                          ?.map((element) => ProjectSectionListModel(
                                title: '${e.projectName ?? ''}${element.buildingCode ?? ''}${element.elevatorCode ?? ''}',
                                body: '${element.arrangeName ?? ''}  ${element.moduleList?.map((e) => e.name).toList().join('、') ?? ''}',
                                id: element.id,
                              ))
                          .toList() ??
                      [],
                  projectName: e.projectName,
                  projectLocation: e.projectLocation,
                  unSignNumber: e.unSignNumber))
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
    List<int> ids = [];
    state.items!.map((e) {
      e.items.map((element) {
        if (element.select && element.id != null) {
          ids.add(element.id!);
        }
      }).toList();
    }).toList();
    Get.toNamed(Routes.comment, arguments: {'type': 1, 'ids': ids});
  }
}
