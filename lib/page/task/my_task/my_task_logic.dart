import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:table_calendar/table_calendar.dart';

import 'fix/fix_task_logic.dart';
import 'my_task_state.dart';
import 'regular/regular_task_logic.dart';
import 'widget/custom_calendar.dart';

class MyTaskLogic extends BaseController {
  final MyTaskState state = MyTaskState();

  query() async {
    final result = await post<MyTaskEntity>(
      Api.calendarMarks,
      params: {'taskDate': null},
    );
    if (result.success) {
      final entity = result.data!;
      Map<DateTime, List<Event>> _map = {};
      for (var element in entity.unfinished ?? []) {
        _map[DateUtil.getDateTimeByMs(element)] = [Event(unfinished: true)];
      }
      for (var element in entity.pending ?? []) {
        DateTime _elementDateTime = DateUtil.getDateTimeByMs(element);
        if (ObjectUtil.isNotEmpty(_map[_elementDateTime])) {
          _map[_elementDateTime]!.add(Event(pending: true));
        } else {
          _map[_elementDateTime] = [Event(pending: true)];
        }
      }
      state.calenderEvents.assignAll(_map);
      update(['calendar']);
    }
  }

  changeFormat(CalendarFormat format) {
    if (state.calendarFormat != format) {
      state.calendarFormat = format;
      update(['calendar']);
    }
  }

  updateNumber({int fixNumber = 0, int regularNumber = 0}) {
    if (state.fixNumber != fixNumber || state.regularNumber != regularNumber) {
      state.fixNumber = fixNumber;
      state.regularNumber = regularNumber;
      update(['tabbar']);
    }
  }

  selectDay(DateTime dateTime) {
    if (!isSameDay(state.selectedDate, dateTime)) {
      state.selectedDate = dateTime;
      if (state.tabController.index == 0) {
        if (Get.isRegistered<FixTaskLogic>()) {
          Get.find<FixTaskLogic>().query();
        }
        if (Get.isRegistered<RegularTaskLogic>()) {
          Get.find<RegularTaskLogic>().clear();
        }
      } else {
        if (Get.isRegistered<RegularTaskLogic>()) {
          Get.find<RegularTaskLogic>().query();
        }
        if (Get.isRegistered<FixTaskLogic>()) {
          Get.find<FixTaskLogic>().clear();
        }
      }
    }
  }
}
