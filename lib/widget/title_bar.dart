import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';

/// 标题栏（自定义appbar）
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({
    super.key,
    required this.title, //标题内容
    this.subTitle, //副标题内容
    this.actionName, //右边（仅限单个文字）按钮名称
    this.backImg, //返回按钮图片
    this.onBack, //返回按钮点击事件
    this.onActionPressed, //右边（仅限单个文字）的点击事件
    this.titleColor = Colors.black, //标题颜色
    this.titleFontSize, //标题字号
    this.subTitleFontSize, //副标题字号
    this.backColor = Colors.white, //返回按钮颜色
    this.actionWidget, //右边
    this.bottomWidget, //底部
    this.bottomLine = true, //显示底部分割线
    this.backgroundColor = Colors.white, //主题颜色
    this.actionColor,
    this.isBack = true,
  });

  final String title;
  final String? subTitle;
  final Widget? backImg;
  final String? actionName;
  final Function()? onBack;
  final Function()? onActionPressed;
  final Color titleColor;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final Color? backColor;
  final Widget? actionWidget;
  final Widget? bottomWidget;
  final Color backgroundColor;
  final bool bottomLine;
  final Color? actionColor;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1.sw / 2),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: titleFontSize ?? 17.sp,
                          fontWeight: Platform.isIOS ? FontWeight.w600 : FontWeight.w500,
                          color: titleColor,
                        ),
                      ),
                      if (ObjectUtil.isNotEmpty(subTitle))
                        Text(
                          subTitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: subTitleFontSize ?? 12.sp,
                            color: titleColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              isBack
                  ? InkWell(
                      onTap: onBack ?? Get.back,
                      child: Container(
                        key: const Key('back'),
                        height: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: backImg ??
                            LoadSvgImage(
                              'arrow_left',
                              width: 20.w,
                              color: Colors.black,
                            ),
                      ),
                    )
                  : SizedBox.shrink(),
              if (actionWidget != null)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: double.infinity,
                    child: actionWidget,
                  ),
                )
              else if (ObjectUtil.isNotEmpty(actionName))
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: onActionPressed,
                    child: Container(
                      key: const Key('actionName'),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
                      alignment: Alignment.center,
                      child: Text(
                        actionName!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: actionColor ?? Colours.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              if (bottomWidget != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: bottomWidget!,
                )
              else if (bottomLine)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 0.5.w,
                    color: Colours.bg,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(49.w);
}
