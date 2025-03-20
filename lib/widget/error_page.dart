import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
    this.msg,
    this.retry,
    this.paddingTop,
  }) : super(key: key);

  final Function()? retry;
  final String? msg;
  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingTop ?? 70.w),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadSvgImage(
            'empty',
            width: 200.w,
            height: 200.w,
          ),
          Text(
            msg ?? '数据加载失败',
            style: TextStyle(
              color: Color(0xFFABB1B4),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 10.w),
          if (retry != null)
            TextBtn(
              size: Size(60.w, 24.w),
              onPressed: () => retry!.call(),
              radius: 12.w,
              backgroundColor: Colours.primary,
              text: '重试',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

enum PageStatus {
  loading,
  success,
  error,
  empty,
}
