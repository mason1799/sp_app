import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_list_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/widget/error_page.dart';

import '../my_task_logic.dart';
import 'regular_task_state.dart';

class RegularTaskLogic extends BaseController {
  final RegularTaskState state = RegularTaskState();

  query() async {
    DateTime? _selected;
    if (Get.isRegistered<MyTaskLogic>()) {
      _selected = Get.find<MyTaskLogic>().state.selectedDate;
    }
    if (_selected == null) {
      return;
    }
    int _timeStamp = DateTime(_selected.year, _selected.month, _selected.day).millisecondsSinceEpoch;
    final result = await post<TaskListEntity>(
      Api.queryTaskList,
      params: {
        'taskDate': _timeStamp,
        'orderType': 1,
      },
    );
    if (result.success) {
      state.items = result.data!.orders ?? [];
      state.pageStatus = state.items!.isNotEmpty ? PageStatus.success : PageStatus.empty;
      if (Get.isRegistered<MyTaskLogic>()) {
        Get.find<MyTaskLogic>().updateNumber(fixNumber: result.data!.repairOrderNum ?? 0, regularNumber: result.data!.orderNum ?? 0);
      }
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update();
  }

  clear() {
    state.items = null;
    state.pageStatus = PageStatus.loading;
    update();
  }
}
