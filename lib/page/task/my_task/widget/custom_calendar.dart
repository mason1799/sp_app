import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:table_calendar/table_calendar.dart';

import '../my_task_logic.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    required this.logic,
    required this.onSelectedDay,
    required this.selectedDate,
  });

  final MyTaskLogic logic;
  final ValueChanged<DateTime> onSelectedDay;
  final DateTime selectedDate;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  bool _isReturningToToday = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDate;
  }

  @override
  void didUpdateWidget(covariant CustomCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果外部传入的日期发生了变化，更新选中日期
    if (widget.selectedDate != oldWidget.selectedDate) {
      setState(() {
        _selectedDay = widget.selectedDate;
        _focusedDay = widget.selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<Event>(
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: widget.logic.state.calendarFormat,
      availableCalendarFormats: {
        CalendarFormat.month: '月',
        CalendarFormat.week: '周',
      },
      onFormatChanged: (format) => widget.logic.changeFormat(format),
      firstDay: DateTime.now().subtract(Duration(days: 365 * 10)),
      lastDay: DateTime.now().add(Duration(days: 365 * 5)),
      focusedDay: _focusedDay,
      daysOfWeekHeight: 30.w,
      locale: 'zh_CN',
      eventLoader: (day) => widget.logic.state.calenderEvents[day] ?? [],
      headerStyle: HeaderStyle(
        headerPadding: EdgeInsets.zero,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5.w,
              color: Colours.bg,
            ),
          ),
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (ObjectUtil.isNotEmpty(events)) {
            bool _pending = events.indexWhere((element) => element.pending == true) > -1;
            bool _unfinished = events.indexWhere((element) => element.unfinished == true) > -1;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_pending)
                  Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      color: Colours.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                if (_unfinished)
                  Container(
                    margin: EdgeInsets.only(left: _pending ? 2.w : 0),
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            );
          }
          return null;
        },
        headerTitleBuilder: (context, day) => Container(
          height: 40.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(
                DateUtil.formatDate(day, format: DateFormats.zhYmd),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_333,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10.w),
              if (!isSameDay(_selectedDay, DateTime.now()))
                TextBtn(
                  text: '回到今天',
                  backgroundColor: Colours.primary.withOpacity(0.2),
                  size: Size(56.w, 22.w),
                  radius: 11.w,
                  onPressed: () {
                    setState(() {
                      _isReturningToToday = true;
                      _focusedDay = DateTime.now();
                      _selectedDay = DateTime.now();
                    });
                    widget.onSelectedDay(DateTime.now());
                    // 延迟操作，确保界面更新后重置标记
                    Future.delayed(Duration(milliseconds: 300), () {
                      setState(() {
                        _isReturningToToday = false; // 重置标志
                      });
                    });
                  },
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colours.primary,
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    if (widget.logic.state.calendarFormat == CalendarFormat.week) {
                      widget.logic.state.calendarFormat = CalendarFormat.month;
                    } else {
                      widget.logic.state.calendarFormat = CalendarFormat.week;
                    }
                  });
                },
                child: LoadSvgImage(
                  widget.logic.state.calendarFormat == CalendarFormat.month ? 'week_view' : 'month_view',
                  width: 20.w,
                ),
              ),
            ],
          ),
        ),
      ),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          widget.onSelectedDay(selectedDay);
          _focusedDay = selectedDay;
          setState(() {
            _selectedDay = selectedDay;
          });
        }
      },
      onPageChanged: (focusedDay) {
        if (_isReturningToToday) {
          return;
        }
        DateTime selectedDay;
        if (widget.logic.state.calendarFormat == CalendarFormat.week) {
          selectedDay = focusedDay.subtract(Duration(days: focusedDay.weekday - DateTime.monday));
        } else {
          selectedDay = focusedDay;
        }
        _focusedDay = selectedDay;
        widget.onSelectedDay(selectedDay);
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            _selectedDay = selectedDay;
          });
        });
      },
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colours.text_333,
          fontSize: 14.sp,
        ), // 平日样式
        weekendStyle: TextStyle(
          color: Colours.text_333,
          fontSize: 14.sp,
        ), // 周末样式
        dowTextFormatter: (day, locale) {
          const days = ['一', '二', '三', '四', '五', '六', '日'];
          return days[day.weekday - 1];
        },
        decoration: BoxDecoration(color: Colors.white),
      ),
      calendarStyle: CalendarStyle(
        cellMargin: EdgeInsets.all(8.w),
        todayDecoration: BoxDecoration(
          color: Colours.primary.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          fontSize: 14.sp,
          color: Colours.primary,
          fontWeight: FontWeight.w500,
        ),
        markersAlignment: Alignment.bottomCenter,
        outsideDaysVisible: false,// 月份向前切换，不在月内也会打上marks标记，插件自身问题，目前不支持。先做隐藏～
        selectedDecoration: BoxDecoration(
          color: Colours.primary,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        rowDecoration: BoxDecoration(color: Colors.white),
        defaultTextStyle: TextStyle(
          fontSize: 14.sp,
          color: Colours.text_333,
        ),
      ),
    );
  }
}

class Event {
  final bool unfinished;
  final bool pending;

  const Event({this.unfinished = false, this.pending = false});
}
