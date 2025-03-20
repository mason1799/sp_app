import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class SegmentControlButton extends StatefulWidget {
  const SegmentControlButton({Key? key, required this.isNormal, required this.onTap}) : super(key: key);
  final bool isNormal;
  final Function(bool select) onTap;

  @override
  State<SegmentControlButton> createState() => _SegmentControlButtonState();
}

class _SegmentControlButtonState extends State<SegmentControlButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<String>(
      children: {
        'emergency': Container(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
          child: Text(
            '困人',
            style: TextStyle(
              fontSize: 14.sp,
              color: !widget.isNormal ? Colors.white : Colours.text_333,
            ),
          ),
        ),
        'normal': Container(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
          child: Text(
            '普通',
            style: TextStyle(
              fontSize: 14.sp,
              color: widget.isNormal ? Colors.white : Colours.text_333,
            ),
          ),
        ),
      },
      unselectedColor: Colors.white,
      selectedColor: Colours.primary,
      borderColor: Colours.bg,
      groupValue: widget.isNormal ? 'normal' : 'emergency',
      onValueChanged: (value) {
        widget.onTap(value == 'normal');
      },
    );
  }
}

class SegmentButton extends StatefulWidget {
  const SegmentButton({Key? key, required this.isNormal, required this.onTap}) : super(key: key);
  final bool isNormal;
  final Function(bool select) onTap;

  @override
  State<SegmentButton> createState() => _SegmentButtonState();
}

class _SegmentButtonState extends State<SegmentButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<String>(
      children: {
        'emergency': Container(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
          child: Text(
            '困人',
            style: TextStyle(
              fontSize: 14.sp,
              color: !widget.isNormal ? Colors.white : Colours.text_333,
            ),
          ),
        ),
        'normal': Container(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
          child: Text(
            '普通',
            style: TextStyle(
              fontSize: 14.sp,
              color: widget.isNormal ? Colors.white : Colours.text_333,
            ),
          ),
        ),
      },
      unselectedColor: Colors.white,
      selectedColor: Colours.primary,
      borderColor: Colours.bg,
      groupValue: getGroupValue(),
      onValueChanged: (value) {
        widget.onTap(value == 'normal');
      },
    );
  }

  getGroupValue() {
    if (widget.isNormal) {
      return 'normal';
    } else {
      return 'emergency';
    }
  }
}

class SegmentRow extends StatelessWidget {
  const SegmentRow({
    this.necessary = false,
    required this.title,
    required this.content,
    this.onTap,
  });

  final bool necessary;
  final String title;
  final Widget content;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        color: Colors.white,
        height: 50.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            if (necessary)
              Text(
                '*',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.red,
                ),
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colours.text_666,
              ),
            ),
            Expanded(child: content),
            if (onTap != null)
              LoadSvgImage(
                'arrow_right',
                width: 14.w,
              ),
          ],
        ),
      ),
    );
  }
}
