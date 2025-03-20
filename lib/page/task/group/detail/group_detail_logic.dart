import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/widget/error_page.dart';

import 'group_detail_state.dart';

class GroupDetailLogic extends BaseController {
  final GroupDetailState state = GroupDetailState();

  @override
  void onReady() async {
    query();
  }

  query() async {
    final result = await get<TaskGroup>(
      Api.belongGroupOrders,
      params: state.entity.groupCode != null ? {'groupCode': state.entity.groupCode} : null,
    );
    if (result.success) {
      state.groupModel.value = result.data!;
      state.dataList.assignAll(result.data!.orders ?? []);
      state.pageStatus.value = PageStatus.success;
    } else {
      showToast(result.msg);
      state.pageStatus.value = PageStatus.error;
    }
  }

  void selectDateTime(DateTime time) {
    state.currentSelectTime = time;
    state.selectDate.value = DateFormat('yyyy-MM-dd').format(time);
    onReady();
  }
}
