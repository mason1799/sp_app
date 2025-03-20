import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';

class LocationItem extends StatelessWidget {
  final String title;
  final String? content;
  final Function? refreshClick;
  final bool locationLoading;
  final bool bottomLine;

  LocationItem({
    required this.title,
    this.content,
    this.refreshClick,
    this.locationLoading = false,
    this.bottomLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: bottomLine ? BorderSide(width: 0.5.w, color: Colours.bg) : BorderSide.none,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.w, left: 15.w),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colours.text_666,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
              child: Text(
                content ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_333,
                ),
              ),
            ),
          ),
          if (refreshClick != null)
            InkWell(
              onTap: locationLoading ? null : () => refreshClick!.call(),
              child: Container(
                width: 90.w,
                padding: EdgeInsets.symmetric(vertical: 14.w),
                alignment: Alignment.center,
                child: locationLoading
                    ? CupertinoActivityIndicator()
                    : Text(
                        '刷新定位',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.primary,
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
