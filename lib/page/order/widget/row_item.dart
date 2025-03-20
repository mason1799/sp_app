import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/extension.dart';
import 'package:konesp/widget/load_image.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    this.necessary = false,
    required this.title,
    this.content,
    this.onTap,
    this.bottomLine = true,
    this.rightText,
    this.rightTextClick,
    this.rightColor,
    this.margin,
    this.behindWidget,
    this.titleColor,
  });

  final bool necessary;
  final String title;
  final String? content;
  final Function()? onTap;
  final bool bottomLine;
  final String? rightText;
  final Function()? rightTextClick;
  final Color? rightColor;
  final EdgeInsets? margin;
  final Widget? behindWidget;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        margin: margin,
        constraints: BoxConstraints(minHeight: 50.w),
        padding: EdgeInsets.only(left: 15.w, top: 10.w, bottom: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: bottomLine ? BorderSide(width: 0.5.w, color: Colours.bg) : BorderSide.none,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                color: titleColor ?? Colours.text_666,
              ),
            ),
            if (behindWidget != null)
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: behindWidget,
              ),
            Expanded(
              child: Text(
                (content ?? '').fixAutoLines(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_333,
                ),
              ),
            ),
            if (ObjectUtil.isNotEmpty(rightText))
              InkWell(
                onTap: () => rightTextClick?.call(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  alignment: Alignment.center,
                  child: Text(
                    rightText!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: rightColor ?? Colours.primary,
                    ),
                  ),
                ),
              )
            else if (onTap != null)
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: LoadSvgImage(
                  'arrow_right',
                  width: 14.w,
                ),
              )
            else
              SizedBox(width: 15.w),
          ],
        ),
      ),
    );
  }
}

class TitleItem extends StatelessWidget {
  const TitleItem({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.bg,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colours.text_999,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
