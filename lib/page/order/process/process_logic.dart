import 'package:konesp/config/api.dart';
import 'package:konesp/entity/fix_order_process_entity.dart';
import 'package:konesp/entity/regular_order_process_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:sprintf/sprintf.dart';

import 'process_state.dart';

class ProcessLogic extends BaseController {
  final ProcessState state = ProcessState();

  pull() async {
    if (state.type == 0) {
      await queryRegularProcesses();
    } else {
      await queryFixProcesses();
    }
  }

  Future<void> queryFixProcesses() async {
    final result = await get<List<FixOrderProcessEntity>>(
      sprintf(Api.fixOrderProcesses, [state.id]),
    );
    if (result.success) {
      state.pageStatus = PageStatus.success;
      state.fixRecords = result.data?.reversed.toList() ?? [];
      state.pageStatus = state.fixRecords!.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  Future<void> queryRegularProcesses() async {
    final result = await get<List<RegularOrderProcessEntity>>(
      sprintf(Api.regularOrderProcesses, [state.id]),
    );
    if (result.success) {
      state.regularRecords = result.data?.reversed.toList() ?? [];
      state.pageStatus = state.regularRecords!.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  String getPhone(String? phone) {
    if (ObjectUtil.isNotEmpty(phone)) {
      return '($phone)';
    } else {
      return '';
    }
  }

  String getStateStr(RegularOrderProcessEntity data) {
    //步骤类型 1签到,2填写检查项,3签退,4提交工单,5签字,6安全员签字,9客户签字
    if (data.type == 1) {
      return '签到';
    } else if (data.type == 2) {
      return '填写检查项';
    } else if (data.type == 3) {
      return '签退';
    } else if (data.type == 4) {
      return '提交工单';
    } else if (data.type == 5) {
      return '签字';
    } else if (data.type == 6) {
      return '安全员签字';
    } else if (data.type == 9) {
      return '客户签字';
    } else {
      return '已完成';
    }
  }
}
