import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

///单选
class SingleDialog extends StatefulWidget {
  final List<String> data;
  final int initialIndex;
  final String title;
  final Function(int index, String value)? resultData;

  SingleDialog({
    required this.data,
    required this.title,
    this.initialIndex = 0,
    this.resultData,
  }) : assert(initialIndex >= 0);

  @override
  State createState() {
    return _SingleDialogState();
  }
}

class _SingleDialogState extends State<SingleDialog> {
  late FixedExtentScrollController fixedExtentScrollController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    fixedExtentScrollController = FixedExtentScrollController(initialItem: widget.initialIndex < widget.data.length ? widget.initialIndex : 0);
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
                          widget.title,
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
                        if (widget.resultData != null) {
                          widget.resultData!(index, widget.data[index]);
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
              _MyAreaPicker(
                valueKey: ValueKey(widget.title),
                controller: fixedExtentScrollController,
                children: widget.data.map((data) {
                  return Align(
                    child: Text(
                      data,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp, color: Colours.text_333),
                    ),
                    alignment: Alignment.center,
                  );
                }).toList(),
                changed: (i) {
                  setState(() {
                    index = i;
                  });
                },
              ),
              SizedBox(height: ScreenUtil().bottomBarHeight)
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
