import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/red_badge.dart';

// 底部栏
class MyBottomBar extends StatefulWidget {
  final List<BottomBarItem> items;
  final int currentIndex;
  final Color textFocusColor;
  final Color textUnfocusColor;
  final Color background;
  final double textFontSize;
  final ValueChanged<int>? onTap;
  final double iconSize;
  final int specialIndex;
  final bool isShowBorder;

  const MyBottomBar({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.textFocusColor = Colors.red,
    this.textUnfocusColor = Colors.grey,
    this.background = Colors.white,
    this.textFontSize = 10.0,
    this.onTap,
    this.iconSize = 40.0,
    this.specialIndex = 2,
    this.isShowBorder = true,
  }) : super(key: key);

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: widget.background,
        border: widget.isShowBorder ? Border(top: BorderSide(color: Colours.bg, width: 0.5.w)) : null,
      ),
      child: SafeArea(
        child: Container(
          color: widget.background,
          child: SizedBox(
            height: 50.w,
            child: Row(
              children: List.generate(
                widget.items.length,
                (index) => _createItem(
                  index,
                  width / widget.items.length,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createItem(int index, double itemWidth) {
    BottomBarItem item = widget.items[index];
    bool selected = (index == widget.currentIndex);
    return InkWell(
      onTap: () => widget.onTap?.call(index),
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: itemWidth,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (index != widget.specialIndex)
                  Stack(
                    children: [
                      Offstage(
                        offstage: selected,
                        child: LoadAssetImage(
                          item.icon!,
                          width: widget.iconSize,
                          height: widget.iconSize,
                        ),
                      ),
                      Offstage(
                        offstage: !selected,
                        child: LoadAssetImage(
                          item.activeIcon!,
                          width: widget.iconSize,
                          height: widget.iconSize,
                        ),
                      ),
                    ],
                  )
                else
                  Container(
                    key: ValueKey('specialItem'),
                    width: 40.w,
                    height: 25.w,
                    decoration: BoxDecoration(
                      color: Colours.primary,
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    alignment: Alignment.center,
                    child: LoadSvgImage('bottom_add', width: 15.w, height: 15.w),
                  ),
                if (index != widget.specialIndex)
                  Padding(
                    padding: EdgeInsets.only(top: 3.w),
                    child: Text(
                      item.title!,
                      style: TextStyle(
                        fontSize: widget.textFontSize,
                        color: selected ? widget.textFocusColor : widget.textUnfocusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (item.number > 0)
            Positioned(
              top: 1.w,
              right: 15.w,
              child: RedBadge(number: item.number),
            ),
        ],
      ),
    );
  }
}

class BottomBarItem {
  final String? icon; //未选中状态图标
  final String? activeIcon; //选中状态图标
  final Widget? specialItem; //特殊控件 与icon activeIcon互斥
  final String? title; //文字
  final int number; //红点数字

  BottomBarItem({
    this.icon,
    this.activeIcon,
    this.specialItem,
    this.title,
    this.number = 0,
  });
}
