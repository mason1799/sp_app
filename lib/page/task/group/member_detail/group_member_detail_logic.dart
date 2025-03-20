import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/ymd_time_dialog.dart';

import 'group_member_detail_state.dart';

class GroupMemberDetailLogic extends BaseController {
  final GroupMemberDetailState state = GroupMemberDetailState();

  query() async {
    final result = await post<GroupListRootEntity>(
      Api.queryMemberAllOrders,
      params: {
        'mainResponseUserId': state.memberModel.id,
        'taskDate': DateUtil.getYmdTimestamp(state.selectDate),
      },
    );
    if (result.success) {
      state.groupListRootEntity = result.data;
      state.pageStatus = ObjectUtil.isNotEmpty(state.groupListRootEntity?.orders) ? PageStatus.success : PageStatus.empty;
      update();
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
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
