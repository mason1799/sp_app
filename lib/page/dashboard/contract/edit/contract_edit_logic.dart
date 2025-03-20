import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/file_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/oss_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/number_text_input_formatter.dart';
import 'package:konesp/widget/sheet/input_dialog.dart';
import 'package:konesp/widget/sheet/single_dialog.dart';
import 'package:konesp/widget/sheet/ymd_time_dialog.dart';
import 'package:sprintf/sprintf.dart';

import '../detail/contract_detail_logic.dart';
import '../list/contract_list_logic.dart';
import 'contract_edit_state.dart';

class ContractEditLogic extends BaseController {
  final ContractEditState state = ContractEditState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await get<CustomFieldListEntity>(sprintf(Api.contractDetail, [state.id]));
    if (result.success) {
      state.customFieldListEntity = result.data!;
      state.pageStatus = PageStatus.success;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void toSubmit() async {
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
        showToast('服务开始时间不能晚于服务结束时间');
        return;
      }
    }
    Map<String, dynamic> _requestMap = {};
    Map<String, dynamic> _extraMap = {};
    List<CustomField> _list = [];
    for (var item in state.customFieldListEntity!.list!) {
      if (item.type == 2 && ObjectUtil.isNotEmpty(item.value) && ObjectUtil.isNotEmpty(item.reflect)) {
        _extraMap[item.reflect!] = item.value!;
      } else {
        _list.add(item);
      }
    }
    for (var item in _list) {
      if (item.reflect == 'type') {
        _requestMap[item.reflect!] = getContractTypeMapValue(item.value!);
      } else if (item.reflect == 'source') {
        _requestMap[item.reflect!] = getContractSourceMapValue(item.value!);
      } else {
        _requestMap[item.reflect!] = item.value;
      }
    }
    if (_extraMap.isNotEmpty) {
      _requestMap['custom'] = _extraMap;
    }
    _requestMap['id'] = state.customFieldListEntity!.id;
    showProgress();
    final result = await post(Api.submitContract, params: _requestMap);
    closeProgress();
    if (result.success) {
      if (Get.isRegistered<ContractDetailLogic>()) {
        Get.find<ContractDetailLogic>().query();
      }
      if (Get.isRegistered<ContractListLogic>()) {
        Get.find<ContractListLogic>().query();
      }
      Get.back();
    } else {
      showToast(result.msg);
    }
  }

  void toEdit(CustomField field) async {
    if (field.component == 'Select') {
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
          keyboardType: field.reflect == 'totalPrice' ? TextInputType.number : TextInputType.text,
          inputFormatters: field.reflect == 'totalPrice'
              ? [UsNumberTextInputFormatter()]
              : [LengthLimitingTextInputFormatter(field.length == 0 ? null : field.length)],
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

  String getContractTypeMapValue(String value) {
    switch (value) {
      case '免保':
        return 'W';
      case '清包':
        return 'C';
      case '半包':
        return 'H';
      case '大包':
        return 'B';
      case '全包':
        return 'A';
      case '其他':
        return 'R';
      default:
        return 'O';
    }
  }

  String getContractSourceMapValue(String value) {
    switch (value) {
      case '首次创建':
        return 'first';
      case '正常续签':
        return 'renew';
      case '重获赢回':
        return 'back';
      default:
        return 'free';
    }
  }
}
