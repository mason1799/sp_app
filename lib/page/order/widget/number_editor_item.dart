import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/number_textfield.dart';

class NumberEditorItem extends StatelessWidget {
  const NumberEditorItem({
    Key? key,
    this.necessary = false,
    required this.title,
    this.number,
    this.enable = true,
    this.onChangeNumber,
    this.bottomBorderSide = true,
  }) : super(key: key);
  final bool necessary;
  final String title;
  final num? number;
  final bool enable;
  final Function(num? number)? onChangeNumber;
  final bool bottomBorderSide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: bottomBorderSide ? BorderSide(width: 0.5.w, color: Colours.bg) : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          if (necessary)
            Text(
              '*',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
              ),
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colours.text_666,
            ),
          ),
          const Spacer(),
          NumberEditor(
            number: number,
            enable: enable,
            onNumberChanged: (value) => onChangeNumber?.call(value),
          ),
        ],
      ),
    );
  }
}
