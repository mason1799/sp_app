import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/customer_sign_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/widget/error_page.dart';

import '../customer_signature/widget/item_widget.dart';
import 'safeguard_signature_state.dart';

class SafeguardSignatureLogic extends BaseController {
  final SafeguardSignatureState state = SafeguardSignatureState();

  @override
  void onReady() {
    query();
  }

  void query() async {
    if (state.selectDateRange.length != 2) {
      return;
    }
    final result = await post<List<CustomerSignProject>>(
      Api.safeguardUnsignList,
      params: {
        'startDate': DateUtil.formatDate(state.selectDateRange.first, format: DateFormats.ymd),
        'endDate': DateUtil.formatDate(state.selectDateRange.last, format: DateFormats.ymd),
      },
    );
    if (result.success) {
      var _list = result.data?.map((e) {
        return ProjectSection(
            unSignNumber: e.unSignNumber,
            items: e.orders?.map((element) {
                  return ProjectSectionListModel(
                    title: '${e.projectName ?? ''}${element.buildingCode ?? ''}${element.elevatorCode ?? ''}',
                    body: '${element.arrangeName ?? ''}  ${element.moduleList?.map((e) => e.name).toList().join('、') ?? ''}',
                    id: element.id,
                  );
                }).toList() ??
                [],
            projectName: e.projectName,
            projectLocation: e.projectLocation);
      }).toList();
      state.items = _list ?? [];
      state.pageStatus = state.items.isEmpty ? PageStatus.empty : PageStatus.success;
    } else {
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void toSignatureApprove() {
    List<ProjectSection> signList = [];
    for (var value in state.items) {
      for (var value1 in value.items) {
        if (value1.select) {
          if (!signList.contains(value)) {
            signList.add(value);
          }
        }
      }
    }
    if (signList.isEmpty) {
      showToast('请选择项目');
      return;
    }
    if (signList.length >= 2) {
      showToast('只能选择一个项目');
      return;
    }
    List<int> ids = [];
    state.items.map((e) {
      e.items.map((element) {
        if (element.select && element.id != null) {
          ids.add(element.id!);
        }
      }).toList();
    }).toList();
    Get.toNamed(Routes.comment, arguments: {'type': 0, 'ids': ids});
  }

  void selectDateRange() async {
    var results = await showCalendarDatePicker2Dialog(
      context: Get.context!,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        selectedRangeHighlightColor: Colours.primary.withOpacity(0.2),
        selectedDayHighlightColor: Colours.primary,
        cancelButtonTextStyle: TextStyle(
          color: Colours.text_999,
          fontSize: 14.sp,
        ),
        okButtonTextStyle: TextStyle(
          color: Colours.primary,
          fontSize: 14.sp,
        ),
      ),
      dialogSize: const Size(325, 400),
      value: state.selectDateRange,
      borderRadius: BorderRadius.circular(15),
    );
    if (results != null && results.length == 2) {
      state.selectDateRange.assignAll((results.map((e) => e!).toList()));
      query();
    }
  }
}
