import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/fix_detail_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/order/fix_select_member/fix_select_member_state.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:konesp/widget/sheet/full_time_dialog.dart';
import 'package:konesp/widget/sheet/input_dialog.dart';
import 'package:konesp/widget/sheet/single_dialog.dart';

import 'fix_create_state.dart';

class FixCreateLogic extends BaseController {
  final FixCreateState state = FixCreateState();

  void confirm() async {
    String _faultDesc = state.textFaultDescController.text;
    if (state.selectDevice == null) {
      showToast('请添加设备');
      return;
    }
    if (ObjectUtil.isEmpty(_faultDesc)) {
      showToast('请填写故障描述');
      return;
    }
    if (ObjectUtil.isEmpty(state.selectTime)) {
      showToast('请选择报修时间');
      return;
    }
    if (ObjectUtil.isEmpty(state.selectedGroupCode)) {
      showToast('请指派员工');
      return;
    }
    Get.focusScope?.unfocus();
    var map = {
      'equipmentId': state.selectDevice?.id,
      'faultRepairType': state.isNormal ? 2 : 1,
      'faultDesc': _faultDesc,
      'repairTime': state.selectTime,
      'repairman': state.reportor,
      'repairPhone': state.phone,
      'groupCode': state.selectedGroupCode,
      'mainResponseUserId': (ObjectUtil.isNotEmpty(state.selectedUserId) && state.selectedUserId! > -1) ? state.selectedUserId : null,
    };
    if (ObjectUtil.isNotEmpty(state.currentPeople)) {
      map['repairRole'] = _getReportRoleType(state.currentPeople!);
    }
    showProgress();
    final result = await post<FixDetailEntity>(Api.createFixOrder, params: map);
    closeProgress();
    if (result.success) {
      showToast('成功新增故障报修');
      if (state.selectedUserId == StoreLogic.to.getUser()?.id) {
        Get.offNamed(Routes.fixDetail, arguments: {'id': result.data!.id});
      } else {
        Get.back();
      }
    } else {
      showToast(result.msg);
    }
  }

  //获取报修人角色类型
  //OWNER(1, "业主"), PASSENGER(2, "乘客"), FIRST_PARTY_AND_PROPERTY_MANAGEMENT(3, "甲方或物业工作人员"),
  // MAINTAINER(4, "维保员工"), OTHER(5, "其他"),
  int _getReportRoleType(String str) {
    const reportRole = ['业主', '乘客', '甲方或物业工作人员', '维保员工', '其他'];
    List<String> list = reportRole;
    int type = 0;
    for (int i = 0; i < list.length; i++) {
      if (str == list[i]) {
        type = i + 1;
        break;
      }
    }
    return type;
  }

  Future<bool> showExitDialog() async {
    /// 如有一项内容
    if (ObjectUtil.isNotEmpty(state.selectDevice) ||
        ObjectUtil.isNotEmpty(state.phone) ||
        ObjectUtil.isNotEmpty(state.reportor) ||
        ObjectUtil.isNotEmpty(state.currentPeople) ||
        ObjectUtil.isNotEmpty(state.selectTime) ||
        ObjectUtil.isNotEmpty(state.textFaultDescController.text) ||
        ObjectUtil.isNotEmpty(state.selectedGroupCode) ||
        ObjectUtil.isNotEmpty(state.selectedUserId)) {
      var result = await Get.dialog(
        ConfirmDialog(
          content: '工单未提交，当前内容不会保存',
          confirm: '确认返回',
          cancel: '继续编辑',
          confirmResult: true,
          cancelResult: false,
          onConfirm: Get.back,
        ),
      );
      if (result != null) {
        return result;
      } else {
        return true;
      }
    } else {
      Get.back();
      return true;
    }
  }

  void selectFixDevice() async {
    Get.focusScope?.unfocus();
    var device = await Get.toNamed(Routes.deviceSelect,  arguments: state.selectDevice);
    if (device != null) {
      state.selectDevice = device;
      state.isNormal = true;
      //默认指派员工为设备主响应人
      if (device.maintainerGroupCode != null && device.maintainerGroupName != null) {
        state.selectedUserId = device.mainRepairerUserId;
        state.selectedUserName = device.mainRepairerUserName;
        state.selectedGroupCode = device.maintainerGroupCode;
        state.selectedGroupName = device.maintainerGroupName;
      }
      //更新三个地方
      update(['device']);
      update(['segment']);
      update(['employee']);
    }
  }

  void selectFixRole() async {
    const reportRole = ['业主', '乘客', '甲方或物业工作人员', '维保员工', '其他'];
    Get.focusScope?.unfocus();
    int _index = state.currentPeople == null ? -1 : reportRole.indexOf(state.currentPeople!);
    Get.bottomSheet(
      SingleDialog(
        title: '报修人角色',
        initialIndex: _index > -1 ? _index : 0,
        data: reportRole,
        resultData: (index, value) {
          state.currentPeople = value;
          update(['role']);
        },
      ),
    );
  }

  void selectFixEmployee() async {
    Get.focusScope?.unfocus();
    if (state.selectDevice == null && state.selectDevice?.projectName == null) {
      showToast('请先添加设备');
      return;
    }
    var memberSelectedEntity = await Get.toNamed(Routes.fixSelectMember, arguments: {
      'selectedUserId': state.selectedUserId,
      'selectedUserName': state.selectedUserName,
      'selectedGroupCode': state.selectedGroupCode,
      'selectedGroupName': state.selectedGroupName,
      'includeMyself': true,
    });
    if (memberSelectedEntity is FixMemberSelectedEntity) {
      state.selectedUserId = memberSelectedEntity.selectedUserId;
      state.selectedUserName = memberSelectedEntity.selectedUserName;
      state.selectedGroupCode = memberSelectedEntity.selectedGroupCode;
      state.selectedGroupName = memberSelectedEntity.selectedGroupName;
      update(['employee']);
    }
  }

  void selectFixDate() {
    Get.focusScope?.unfocus();
    Get.bottomSheet(
      FullTimeDialog(
        title: '报修时间',
        initialDateTime: DateUtil.getDateTime(state.selectTime) ?? DateTime.now(),
        onResult: (dateTime) {
          String formattedDate = DateUtil.formatDate(dateTime);
          state.selectTime = formattedDate;
          update(['dateTime']);
        },
      ),
    );
  }

  void selectType(bool select) {
    if (state.selectDevice != null && [2, 5].contains(state.selectDevice!.equipmentType)) {
      //5：杂物电梯 2：扶梯 不存在困人情况
      if (state.isNormal) {
        showToast('扶梯或者杂物货梯不存在困人情况');
        //恢复原状
        state.isNormal = true;
        update(['segment']);
        return;
      } else {
        state.isNormal = select;
        update(['segment']);
      }
    } else {
      state.isNormal = select;
      update(['segment']);
    }
  }

  appendFixDescription(String description) {
    var text = state.textFaultDescController.text;
    if (text.contains(description)) {
      return;
    } else if (text.isEmpty || text.endsWith('、')) {
      text += description;
    } else {
      text += '、$description';
    }
    state.textFaultDescController.text = text;
  }

  void inputReportor() async {
    Get.dialog(
      InputDialog(
        title: '报修人姓名',
        initialValue: state.reportor,
        keyboardType: TextInputType.text,
        inputFormatters: [LengthLimitingTextInputFormatter(20)],
        onSave: (value) {
          state.reportor = value;
          update(['reportor']);
        },
      ),
    );
  }

  void inputPhone() async {
    Get.dialog(
      InputDialog(
        title: '报修人电话',
        initialValue: state.phone,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(15), FilteringTextInputFormatter.digitsOnly],
        onSave: (value) {
          state.phone = value;
          update(['phone']);
        },
      ),
    );
  }
}
