import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

import 'two_dimensional_logic.dart';

class TwoDimensionalPage extends StatelessWidget {
  final String title;
  final List<Map<String, List<String>>> data;
  final String? selected;
  final Function(String firstValue, String secondValue)? resultData;

  TwoDimensionalPage({
    required this.title,
    required this.data,
    this.selected,
    this.resultData,
  });

  @override
  Widget build(BuildContext context) {
    final logic = TwoDimensionalLogic(title, data, selected, resultData);
    Get.create(() => logic, permanent: false);
    final state = logic.state;
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
                          state.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (state.firstData.isEmpty || state.secondData.isEmpty) {
                          return;
                        }
                        Get.back();
                        if (state.resultData != null) {
                          state.resultData!(
                            state.firstData[state.firstIndex],
                            state.secondData[state.secondIndex],
                          );
                        }
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
                    child: _MyAreaPicker(
                      valueKey: ValueKey('first'),
                      controller: state.firstController,
                      children: state.firstData.map((data) {
                        return Align(
                          child: Text(
                            data,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          alignment: Alignment.center,
                        );
                      }).toList(),
                      changed: (index) => logic.onChangeFirst(index),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<TwoDimensionalLogic>(
                      id: 'second',
                      builder: (_) {
                        return _MyAreaPicker(
                          valueKey: ValueKey('second'),
                          controller: state.secondController,
                          children: state.secondData.map((data) {
                            return Align(
                              child: Text(
                                data,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              alignment: Alignment.center,
                            );
                          }).toList(),
                          changed: (index) => logic.onChangeSecond(index),
                        );
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

class _MyAreaPicker extends StatefulWidget {
  final List<Widget> children;
  final Key valueKey;
  final FixedExtentScrollController controller;
  final ValueChanged<int> changed;

  _MyAreaPicker({
    required this.children,
    required this.valueKey,
    required this.controller,
    required this.changed,
  });

  @override
  State createState() {
    return _MyAreaPickerState();
  }
}

class _MyAreaPickerState extends State<_MyAreaPicker> {
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
        children: widget.children,
      ),
    );
  }
}
