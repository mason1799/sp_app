import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/over_time_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';

import '../regular_detail/regular_detail_logic.dart';
import 'over_time_state.dart';

class OverTimeLogic extends BaseController {
  final OverTimeState state = OverTimeState();

  String getBeginDate() {
    if (ObjectUtil.isNotEmpty(state.entity.adjustOrderList)) {
      return state.entity.adjustOrderList![0].overdueDateBegin ?? '';
    }
    return '';
  }

  String getEndDate() {
    if (ObjectUtil.isNotEmpty(state.entity.adjustOrderList)) {
      return state.entity.adjustOrderList![0].overdueDateEnd ?? '';
    }
    return '';
  }

  void insertOrder() async {
    if (ObjectUtil.isEmpty(state.selectDate)) {
      showToast('请选择工单日期');
      return;
    }
    if (ObjectUtil.isEmpty(state.selected)) {
      showToast('请选择工单模块');
      return;
    }
    Map<String, dynamic> map = {};
    //调整类型 1短期调整 2长期调整
    map['adjustType'] = state.entity.adjustType ?? 1;
    //数据类型 1单条调整 2批量调整
    map['dataType'] = 1;
    List<Map> list = [];
    List<Map> moduleList = [];
    for (var element in state.selected) {
      Map module = {'id': element.moduleId, 'name': element.moduleName};
      moduleList.add(module);
    }
    Map child = {
      'id': state.orderId,
      'newTaskDate': state.selectDate,
      'moduleList': moduleList,
      'adjustTaskDate': DateUtil.formatDate(DateTime.now(), format: DateFormats.ymd),
      'overdue': true,
      'adjustMainResponseUserId': StoreLogic.to.getUser()?.id,
      'adjustMainResponseUserName': StoreLogic.to.getUser()?.username
    };
    list.add(child);
    map['adjustOrderList'] = list;
    showProgress();
    final result = await post(Api.insertRegularOrderAdjustment, params: map);
    closeProgress();
    if (result.success) {
      showToast('插入工单成功');
      Get.back();
      if (Get.isRegistered<RegularDetailLogic>()) {
        Get.find<RegularDetailLogic>().query();
      }
    } else {
      showToast(result.msg);
    }
  }

  void selectDate(BuildContext context) {
    var currentDate = DateFormat('yyyy-MM-dd').parse(state.entity.overdueStartDate ?? '');
    var maxDate = DateFormat('yyyy-MM-dd').parse(state.entity.overdueEndDate ?? '');
    DatePicker.showDatePicker(
      context,
      currentTime: currentDate,
      minTime: currentDate,
      maxTime: maxDate,
      showTitleActions: true,
      locale: LocaleType.zh,
      onConfirm: (date) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        state.selectDate = formattedDate;
        update(['date']);
      },
    );
  }

  void checkedItem(OverTimeModuleInfo item) {
    if (state.selected.contains(item)) {
      state.selected.remove(item);
    } else {
      state.selected.add(item);
    }
    update(['items']);
  }
}
