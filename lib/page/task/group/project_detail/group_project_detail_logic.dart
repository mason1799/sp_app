import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/ymd_time_dialog.dart';

import 'group_project_detail_state.dart';

class GroupProjectDetailLogic extends BaseController {
  final GroupProjectDetailState state = GroupProjectDetailState();

  query() async {
    final result = await post<GroupListRootEntity>(
      Api.queryMemberAllOrders,
      params: {
        'projectName': state.projectModel.projectName,
        'taskDate': DateUtil.getYmdTimestamp(state.selectDate),
        'groupCode': state.groupCode,
      },
    );
    if (result.success) {
      state.groupListRootEntity = result.data!;
      state.pageStatus = ObjectUtil.isNotEmpty(state.groupListRootEntity?.orders) ? PageStatus.success : PageStatus.empty;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void toSelect() {
    Get.bottomSheet(
      YmdTimeDialog(
        initialDateTime: state.selectDate,
        onResult: (value) {
          state.selectDate = value;
          query();
        },
      ),
    );
  }
}
