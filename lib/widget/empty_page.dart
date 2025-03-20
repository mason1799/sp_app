import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/widget/load_image.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    Key? key,
    this.msg,
    this.paddingTop,
    this.icon,
  }) : super(key: key);

  final String? msg;
  final double? paddingTop;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingTop ?? 70.w),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ??
              LoadSvgImage(
                'empty',
                width: 200.w,
                height: 200.w,
              ),
          Text(
            msg ?? '暂无相关数据',
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFFABB1B4),
            ),
          ),
        ],
      ),
    );
  }
}
