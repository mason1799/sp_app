import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/toast_util.dart';
import 'package:konesp/widget/load_image.dart';

///年-月-日 时:分
class FullTimeDialog extends StatefulWidget {
  final String? title;
  final Function(DateTime dateTime)? onResult;
  final DateTime? initialDateTime;

  FullTimeDialog({
    this.title,
    this.onResult,
    this.initialDateTime,
  });

  @override
  State createState() {
    return _FullTimeDialogState();
  }
}

class _FullTimeDialogState extends State<FullTimeDialog> {
  late FixedExtentScrollController dateController;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  final int totalDaysOfPast = 365 * 2;

  int dateIndexTxt = 0;
  int hourIndexTxt = 0;
  int minuteIndexTxt = 0;
  List<String> dates = [];
  List<int> hours = List.generate(24, (index) => index);
  List<int> minutes = List.generate(60, (index) => index);

  @override
  void initState() {
    super.initState();
    dates = List.generate(
      365 * 2,
      (index) {
        DateTime pastDateTime = DateTime.now().subtract(Duration(days: 365 * 2 - index - 1));
        return DateUtil.formatDate(pastDateTime, format: DateFormats.ymd);
      },
    );
    if (ObjectUtil.isNotEmpty(widget.initialDateTime)) {
      int _calDateIndex = dates.indexOf(widget.initialDateTime!.year.toString());
      setState(() {
        dateIndexTxt = _calDateIndex > -1 ? _calDateIndex : (totalDaysOfPast - 1);
        hourIndexTxt = widget.initialDateTime!.hour;
        minuteIndexTxt = widget.initialDateTime!.minute;
      });
    } else {
      DateTime nowTime = DateTime.now();
      setState(() {
        dateIndexTxt = totalDaysOfPast - 1;
        hourIndexTxt = nowTime.hour;
        minuteIndexTxt = nowTime.minute;
      });
    }
    dateController = FixedExtentScrollController(initialItem: dateIndexTxt);
    hourController = FixedExtentScrollController(initialItem: hourIndexTxt);
    minuteController = FixedExtentScrollController(initialItem: minuteIndexTxt);
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
            children: [
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
                        String _selectedDate = '${dates[dateIndexTxt]} ${withZero(hourIndexTxt)}:${withZero(minuteIndexTxt)}';
                        int? currentMills = DateUtil.getDateMsByTimeStr(_selectedDate);
                        if (currentMills != null && DateUtil.getNowDateMs() < currentMills) {
                          Toast.show('不能选中晚于当前时间的日期');
                          return;
                        }
                        widget.onResult?.call(DateUtil.getDateTimeByMs(currentMills!));
                        Get.back();
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
                    flex: 3,
                    child: _MyDatePicker(
                      valueKey: ValueKey('date'),
                      controller: dateController,
                      children: dates.map((data) {
                        return Align(
                          child: Text(
                            getFormattedDateStr(data),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          alignment: Alignment.center,
                        );
                      }).toList(),
                      changed: (index) {
                        dateIndexTxt = index;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _MyDatePicker(
                      valueKey: ValueKey('hour'),
                      controller: hourController,
                      children: hours.map((data) {
                        return Align(
                          child: Text(
                            withZero(data),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          alignment: Alignment.center,
                        );
                      }).toList(),
                      changed: (index) {
                        hourIndexTxt = index;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _MyDatePicker(
                      valueKey: ValueKey('minute'),
                      controller: minuteController,
                      children: minutes.map((data) {
                        return Align(
                          child: Text(
                            withZero(data),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          alignment: Alignment.center,
                        );
                      }).toList(),
                      changed: (index) {
                        minuteIndexTxt = index;
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
  final List<Widget> children;
  final Key valueKey;
  final FixedExtentScrollController controller;
  final ValueChanged<int> changed;

  _MyDatePicker({
    required this.children,
    required this.controller,
    required this.valueKey,
    required this.changed,
  });

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
        key: widget.valueKey,
        itemExtent: 40.w,
        selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          background: CupertinoColors.tertiarySystemFill,
          capStartEdge: false,
          capEndEdge: false,
        ),
        onSelectedItemChanged: (index) {
          widget.changed(index);
        },
        children: widget.children.isNotEmpty ? widget.children : [],
      ),
    );
  }
}

String withZero(int value) {
  if (value < 10) {
    return '0$value';
  }
  return '$value';
}

String getFormattedDateStr(String pastDateTime) {
  if (DateUtil.isToday(DateUtil.getDateTime(pastDateTime)!.millisecondsSinceEpoch)) {
    return '今日';
  } else if (DateUtil.yearIsEqual(DateUtil.getDateTime(pastDateTime)!, DateTime.now())) {
    return '${DateUtil.formatDate(DateUtil.getDateTime(pastDateTime)!, format: DateFormats.zhMd)} ${DateUtil.getWeekday(DateUtil.getDateTime(pastDateTime)!, languageCode: 'zh')}';
  } else {
    return '${DateUtil.formatDate(DateUtil.getDateTime(pastDateTime)!, format: DateFormats.zhYmd)} ${DateUtil.getWeekday(DateUtil.getDateTime(pastDateTime)!, languageCode: 'zh')}';
  }
}
