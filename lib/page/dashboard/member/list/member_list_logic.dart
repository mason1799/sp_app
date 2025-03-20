import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/department_info_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/entity/member_data_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/widget/error_page.dart';

import 'member_list_state.dart';

class MemberListLogic extends BaseController {
  final MemberListState state = MemberListState();

  Future<void> pull() async {
    await getDefaultDepartment();
  }

  Future<void> loadMore() async {
    state.currentPage++;
    await query();
  }

  Future<void> getDefaultDepartment() async {
    final result = await get<List<DepartmentInfoEntity>>(Api.branchDepartment);
    if (result.success) {
      var rootDepartment = result.data?.isNotEmpty == true ? result.data?.first : null;
      if (rootDepartment != null) {
        state.rootDepartmentNode = DepartmentNode.fromEntity(rootDepartment);
      }
      if (state.rootDepartmentNode?.children?.isNotEmpty == true) {
        var defaultDepartment = state.rootDepartmentNode!.children!.first;
        while (defaultDepartment.children?.isNotEmpty == true) {
          defaultDepartment = defaultDepartment.children!.first;
        }
        updateDepartmentLabel(defaultDepartment);
      } else if (state.rootDepartmentNode != null) {
        updateDepartmentLabel(state.rootDepartmentNode);
      }
      query();
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
  }

  Future<void> query() async {
    List<String>? departmentIds;
    if (state.selectDepartment != null) {
      departmentIds ??= [];
      departmentIds.add(state.selectDepartment?.id ?? '');
    }
    final result = await post<List<MemberDataEntity>>(
      Api.memberList,
      params: {
        'tenantId': StoreLogic.to.getUser()?.tenantId,
        'organIdList': departmentIds,
        'keyWord': state.searchController.text,
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

  updateDepartmentLabel(DepartmentNode? node) {
    state.selectDepartment = node;
    if (state.selectDepartment != null) {
      List<String> label = [];
      DepartmentNode tempNode = state.selectDepartment!;
      while (tempNode.parent != null) {
        label.add(tempNode.name ?? '');
        tempNode = tempNode.parent!;
      }
      label.add(tempNode.name ?? '');
      label = label.reversed.toList();
      state.selectDepartmentLabel = label.join(' / ');
    }
  }

  void toSelectDepartment() async {
    var nodes = await Get.toNamed(Routes.department, arguments: {'selectedDepartment': state.selectDepartment});
    if (nodes is List<DepartmentNode> && nodes.isNotEmpty) {
      updateDepartmentLabel(nodes.first);
      state.pageStatus = PageStatus.loading;
      update();
      state.currentPage = 1;
      await query();
    }
  }

  void search() async{
    Get.focusScope?.unfocus();
    state.currentPage = 1;
    await query();
  }
}
