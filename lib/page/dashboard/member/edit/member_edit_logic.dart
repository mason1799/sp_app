import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/entity/department_info_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/entity/validate_save_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/file_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/oss_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:konesp/widget/sheet/input_dialog.dart';
import 'package:konesp/widget/sheet/single_dialog.dart';
import 'package:konesp/widget/sheet/ymd_time_dialog.dart';
import 'package:sprintf/sprintf.dart';

import '../detail/member_detail_logic.dart';
import '../list/member_list_logic.dart';
import 'member_edit_state.dart';

class MemberEditLogic extends BaseController {
  final MemberEditState state = MemberEditState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await get<CustomFieldListEntity>(sprintf(Api.memberDetail, [state.id]));
    if (result.success) {
      state.customFieldListEntity = result.data!;
      state.pageStatus = PageStatus.success;
      final deptResult = await get<List<DepartmentInfoEntity>>(Api.branchDepartment);
      if (deptResult.success) {
        state.departmentNodes = deptResult.data?.map((e) => DepartmentNode.fromEntity(e)).toList() ?? [];
      }
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  toSubmit() async {
    if (state.customFieldListEntity == null) {
      return;
    }
    List<CustomField>? list =
        state.customFieldListEntity!.list?.where((entity) => entity.necessary == 'Y' && ObjectUtil.isEmpty(entity.value)).toList();
    if (ObjectUtil.isNotEmpty(list)) {
      showToast('请输入${list!.first.fieldName!}');
      return;
    }
    String? contractStartDate = state.customFieldListEntity!.list?.where((entity) => entity.reflect == 'contractStartDate').toList().first.value;
    String? contractEndDate = state.customFieldListEntity!.list?.where((entity) => entity.reflect == 'contractEndDate').toList().first.value;
    if (ObjectUtil.isNotEmpty(contractStartDate) && ObjectUtil.isNotEmpty(contractEndDate)) {
      if (DateUtil.getDateMsByTimeStr(contractStartDate!)! > DateUtil.getDateMsByTimeStr(contractEndDate!)!) {
        showToast('劳动合同开始日期不能晚于劳动合同结束日期');
        return;
      }
    }
    showProgress();
    String? _onTheJob = state.customFieldListEntity!.list?.where((entity) => entity.reflect == 'onTheJob').toList().first.value;
    String? _organId = state.customFieldListEntity!.list?.where((entity) => entity.reflect == 'organId').toList().first.value;
    final validateResult = await post<ValidateSaveEntity>(
      Api.validateMember,
      params: {
        'id': state.customFieldListEntity!.id,
        'onTheJob': _onTheJob,
        'organId': _organId,
      },
    );
    closeProgress();
    if (validateResult.success) {
      ValidateSaveEntity entity = validateResult.data!;
      if (entity.deptChangeWarning == false && entity.inRespWarning == false && entity.leaveWarning == false) {
        submitMemberData();
      } else {
        if (entity.deptChangeWarning == true) {
          showWarning(entity.deptChangeWarningMsg);
        } else if (entity.inRespWarning == true) {
          showWarning(entity.inRespWarningMsg);
        } else if (entity.leaveWarning == true) {
          showWarning(entity.leaveWarningMsg);
        } else {
          showToast('未知错误');
        }
      }
    } else {
      showToast(validateResult.msg);
    }
  }

  void showWarning(String? msg) {
    if (ObjectUtil.isEmpty(msg)) {
      return;
    }
    Get.dialog(
      ConfirmDialog(
        content: msg!,
        onCancel: () {},
        onConfirm: () {
          submitMemberData();
        },
      ),
    );
  }

  void submitMemberData() async {
    Map<String, dynamic> _map = {};
    for (var item in state.customFieldListEntity!.list!) {
      _map[item.reflect!] = item.value;
    }
    _map['id'] = state.customFieldListEntity!.id;
    showProgress();
    final result = await post(Api.editMember, params: _map);
    closeProgress();
    if (result.success) {
      if (Get.isRegistered<MemberDetailLogic>()) {
        Get.find<MemberDetailLogic>().query();
      }
      if (Get.isRegistered<MemberListLogic>()) {
        Get.find<MemberListLogic>().query();
      }
      Get.back();
    } else {
      showToast(result.msg);
    }
  }

  toEdit(CustomField field) async {
    if (field.reflect == 'organId') {
      DepartmentNode? departmentNode;
      String? fromId = field.value;
      for (var element in state.departmentNodes) {
        departmentNode = element.getDepartmentFromID(fromId);
      }
      var nodes = await Get.toNamed(Routes.department, arguments: {'selectedDepartment': departmentNode});
      if (nodes is List<DepartmentNode> && nodes.isNotEmpty) {
        field.value = nodes.first.id;
        update();
      }
    } else if (field.component == 'Select') {
      if (ObjectUtil.isNotEmpty(field.content)) {
        List<String> data = field.content!.split('/');
        int _index = ObjectUtil.isEmpty(field.value) ? -1 : data.indexOf(field.value!);
        Get.bottomSheet(
          SingleDialog(
            title: field.fieldName!,
            initialIndex: _index > -1 ? _index : 0,
            data: data,
            resultData: (index, value) {
              field.value = value;
              update();
            },
          ),
        );
      } else {
        showToast('value数据源字段为空，请检查');
      }
    } else if (field.component == 'DatePicker') {
      Get.bottomSheet(
        YmdTimeDialog(
          title: field.fieldName!,
          initialDateTime: DateUtil.getDateTime(field.value),
          onResult: (value) {
            field.value = DateUtil.formatDate(value, format: DateFormats.ymd);
            update();
          },
        ),
      );
    } else if (field.component == 'Input') {
      Get.dialog(
        InputDialog(
          title: field.fieldName!,
          necessary: field.necessary == 'Y',
          initialValue: field.value,
          keyboardType: ['phone'].contains(field.reflect) ? TextInputType.number : TextInputType.text,
          inputFormatters: ['phone'].contains(field.reflect) ? [LengthLimitingTextInputFormatter(18), FilteringTextInputFormatter.digitsOnly] : null,
          onSave: (value) {
            field.value = value;
            update();
          },
        ),
      );
    } else if (field.component == 'Upload') {
      final _photo = await FileUtil.takeOnePhoto();
      if (_photo == null) {
        return;
      }
      showProgress();
      final _result = await OssUtil.instance.upload(
        _photo,
        dict: field.reflect!,
      );
      closeProgress();
      if (_result.success) {
        field.value = _result.data!.ossKey;
        update();
      } else {
        showToast(_result.msg);
      }
    }
  }
}
