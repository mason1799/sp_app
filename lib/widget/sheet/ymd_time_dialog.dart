import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';

typedef WidgetList = List<Widget> Function();

///年-月-日
class YmdTimeDialog extends StatefulWidget {
  final String? title;
  final Function(DateTime date)? onResult;
  final DateTime? initialDateTime;

  YmdTimeDialog({
    this.title,
    this.onResult,
    this.initialDateTime,
  });

  @override
  State createState() {
    return _YmdTimeDialogState();
  }
}

class _YmdTimeDialogState extends State<YmdTimeDialog> {
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  int yearIndexTxt = 1;
  int monthIndexTxt = 1;
  int dayIndexTxt = 1;
  List<int> years = generateYears();
  List<int> months = List.generate(12, (index) => 1 + index);
  List<int> days = [];

  @override
  void initState() {
    super.initState();
    if (!ObjectUtil.isEmpty(widget.initialDateTime)) {
      setState(() {
        yearIndexTxt = widget.initialDateTime!.year;
        monthIndexTxt = widget.initialDateTime!.month;
        dayIndexTxt = widget.initialDateTime!.day;
        days = getDaysByYearMonth(yearIndexTxt, monthIndexTxt);
      });
    } else {
      DateTime nowTime = DateTime.now();
      setState(() {
        yearIndexTxt = nowTime.year;
        monthIndexTxt = nowTime.month;
        dayIndexTxt = nowTime.day;
        days = getDaysByYearMonth(yearIndexTxt, monthIndexTxt);
      });
    }
    yearController = FixedExtentScrollController(initialItem: yearIndexTxt - (DateTime.now().year - 50));
    monthController = FixedExtentScrollController(initialItem: monthIndexTxt - 1);
    dayController = FixedExtentScrollController(initialItem: dayIndexTxt - 1);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8.w),
      ),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 52.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    InkWell(
                      onTap: Get.back,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: LoadSvgImage(
                          'close_sheet',
                          width: 16.w,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.title ?? '选择日期',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        widget.onResult?.call(DateUtil.getDateTime('$yearIndexTxt-${withZero(monthIndexTxt)}-${withZero(dayIndexTxt)}')!);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          '确定',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _MyDatePicker(
                      controller: yearController,
                      children: () {
                        return years.map((value) {
                          return Align(
                            child: Text(
                              '$value年',
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            alignment: Alignment.center,
                          );
                        }).toList();
                      },
                      changed: (index) {
                        setState(() {
                          yearIndexTxt = years[index];
                          days = getDaysByYearMonth(yearIndexTxt, monthIndexTxt);
                          if (!days.contains(dayIndexTxt)) {
                            dayController.animateToItem(days.length - 1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: _MyDatePicker(
                      controller: monthController,
                      children: () {
                        return months.map((value) {
                          return Align(
                            child: Text(
                              '$value月',
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            alignment: Alignment.center,
                          );
                        }).toList();
                      },
                      changed: (index) {
                        setState(() {
                          monthIndexTxt = months[index];
                          days = getDaysByYearMonth(yearIndexTxt, monthIndexTxt);
                          if (!days.contains(dayIndexTxt)) {
                            dayController.animateToItem(days.length - 1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: _MyDatePicker(
                      controller: dayController,
                      children: () {
                        return days.map((value) {
                          return Align(
                            child: Text(
                              '$value日',
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            alignment: Alignment.center,
                          );
                        }).toList();
                      },
                      changed: (index) {
                        setState(() {
                          dayIndexTxt = days[index];
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyDatePicker extends StatefulWidget {
  final WidgetList? children;
  final FixedExtentScrollController? controller;
  final ValueChanged<int>? changed;

  _MyDatePicker({this.children, this.controller, this.changed});

  @override
  State createState() {
    return _MyDatePickerState();
  }
}

class _MyDatePickerState extends State<_MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 250.w,
      child: CupertinoPicker(
        scrollController: widget.controller,
        key: widget.key,
        itemExtent: 40.w,
        onSelectedItemChanged: (index) {
          if (widget.changed != null) {
            widget.changed!(index);
          }
        },
        children: widget.children!().isNotEmpty ? widget.children!() : [Text('')],
      ),
    );
  }
}

List<int> generateYears() {
  final currentYear = DateTime.now().year;
  final years = <int>[];

  for (int i = -50; i <= 50; i++) {
    years.add(currentYear + i);
  }
  return years;
}

List<int> getDaysByYearMonth(int year, int month) {
  switch (month) {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
      return List.generate(31, (index) => 1 + index);
    case 2:
      return ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))
          ? List.generate(29, (index) => 1 + index)
          : List.generate(28, (index) => 1 + index);
    default:
      return List.generate(30, (index) => 1 + index);
  }
}

String withZero(int value) {
  if (value < 10) {
    return '0$value';
  }
  return '$value';
}
