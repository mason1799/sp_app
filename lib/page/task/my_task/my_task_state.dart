import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'widget/custom_calendar.dart';

class MyTaskState {
  late TabController tabController;
  late List<String> tabs;
  late int fixNumber;
  late int regularNumber;
  late CalendarFormat calendarFormat;
  late LinkedHashMap<DateTime, List<Event>> calenderEvents;
  late DateTime selectedDate;

  MyTaskState() {
    tabs = ['故障报修', '例行保养'];
    fixNumber = 0;
    regularNumber = 0;
    calendarFormat = CalendarFormat.week;
    calenderEvents = LinkedHashMap<DateTime, List<Event>>(equals: isSameDay, hashCode: getHashCode);
    selectedDate = DateTime.now();
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
