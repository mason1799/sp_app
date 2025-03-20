import 'dart:async';

import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';

import 'group_list_state.dart';

class GroupListLogic extends BaseController {
  final GroupListState state = GroupListState();

  query() async {
    if (StoreLogic.to.getUser()!.leader != true && StoreLogic.to.getUser()!.group == true) {
      final result = await _loadGroup();
      if (result) {
        state.pageStatus = PageStatus.success;
      } else {
        state.pageStatus = PageStatus.empty;
      }
    } else if (StoreLogic.to.getUser()!.leader == true && StoreLogic.to.getUser()!.group != true) {
      final result = await _loadLeader();
      if (result) {
        state.pageStatus = PageStatus.success;
      } else {
        state.pageStatus = PageStatus.empty;
      }
    } else if (StoreLogic.to.getUser()!.leader == true && StoreLogic.to.getUser()!.group == true) {
      final result1 = await _loadGroup();
      final result2 = await _loadLeader();
      if (result1 && result2) {
        state.pageStatus = PageStatus.success;
      } else {
        state.pageStatus = PageStatus.empty;
      }
    } else {
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  Future<bool> _loadGroup() async {
    final result = await get<TaskGroup>(Api.belongGroupOrders);
    if (result.success) {
      if (result.data == null) {
        return false;
      }
      state.groupModel = result.data!;
      state.belongGroupName = result.data!.groupName ?? '';
      state.dataList.assignAll(result.data!.orders ?? []);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _loadLeader() async {
    final result = await get<List<GroupDetailEntity>>(Api.queryAllGroups);
    if (result.success) {
      state.items.assignAll(result.data ?? []);
      return true;
    } else {
      return false;
    }
  }

  selectFixStatus({required WordOrderFixButtonStatus status}) {
    if (state.selectFixStatus != status) {
      state.selectFixStatus = status;
      update();
    }
  }
}
