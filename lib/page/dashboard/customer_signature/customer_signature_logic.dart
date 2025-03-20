import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/customer_sign_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/res/colors.dart';

import 'customer_signature_state.dart';
import 'fix/fix_list_logic.dart';
import 'regular/regular_list_logic.dart';

class CustomerSignatureLogic extends BaseController {
  final CustomerSignatureState state = CustomerSignatureState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await post<CustomerSignNumber>(
      Api.customerUnsignCount,
      params: {
        'startDate': state.selectDateRange.first.millisecondsSinceEpoch,
        'endDate': state.selectDateRange.last.millisecondsSinceEpoch,
      },
    );
    if (result.success) {
      updateNumber(fixNumber: result.data?.repairNumber ?? 0, regularNumber: result.data?.orderNumber ?? 0);
    }
  }

  updateNumber({int fixNumber = 0, int regularNumber = 0}) {
    if (state.fixNumber != fixNumber || state.regularNumber != regularNumber) {
      state.fixNumber = fixNumber;
      state.regularNumber = regularNumber;
      update(['tabbar']);
    }
  }

  void onSelectRange(BuildContext buildContext) async {
    var results = await showCalendarDatePicker2Dialog(
      context: buildContext,
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
      update(['range']);
      await query();
      if (Get.isRegistered<FixListLogic>()) {
        await Get.find<FixListLogic>().query();
      }
      if (Get.isRegistered<RegularListLogic>()) {
        await Get.find<RegularListLogic>().query();
      }
    }
  }
}
