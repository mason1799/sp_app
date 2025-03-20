import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class NumberEditor extends StatefulWidget {
  final num? number;
  final void Function(num?)? onNumberChanged;
  final bool enable;

  const NumberEditor({
    super.key,
    this.number,
    this.onNumberChanged,
    this.enable = true,
  });

  @override
  _NumberEditorState createState() => _NumberEditorState();
}

class _NumberEditorState extends State<NumberEditor> {
  num? _number = 0;

  @override
  void initState() {
    _number = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: 100.w,
        height: 28.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox.fromSize(
              size: Size(28.w, 28.w),
              child: Material(
                color: const Color(0xFFF0F0F0),
                child: IconButton(
                  icon: LoadSvgImage(
                    'kone_minus',
                    color: widget.enable ? null : const Color(0xFFCCCCCC),
                  ),
                  iconSize: 16.w,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (!widget.enable) {
                      return;
                    }
                    if (_number != null && _number! >= 1) {
                      _number = (_number ?? 0) - 1;
                      setState(() {});
                      widget.onNumberChanged?.call(_number);
                    }
                  },
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Container(
                height: 28.w,
                width: 40.w,
                color: const Color(0xFFF0F0F0),
                child: Center(
                  child: Text(
                    (_number ?? 0).toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: widget.enable ? null : Colours.text_ccc,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            SizedBox.fromSize(
              size: Size(28.w, 28.w),
              child: Material(
                color: const Color(0xFFF0F0F0),
                child: IconButton(
                  icon: LoadSvgImage(
                    'kone_add',
                    color: widget.enable ? null : const Color(0xFFCCCCCC),
                  ),
                  iconSize: 16.w,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (!widget.enable) {
                      return;
                    }
                    if (_number == null) {
                      _number = 1;
                    } else {
                      _number = _number! + 1;
                    }
                    setState(() {});
                    widget.onNumberChanged?.call(_number);
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
