import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RedBadge extends StatelessWidget {
  final int number;
  final Widget? child;
  final badges.BadgePosition? position;

  const RedBadge({
    super.key,
    required this.number,
    this.child,
    this.position,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Center(
        child: Text(
          number > 99 ? '99+' : number.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
          ),
        ),
      ),
      child: child,
      showBadge: number > 0,
      badgeAnimation: badges.BadgeAnimation.slide(toAnimate: false),
      position: position ?? badges.BadgePosition.topEnd(top: 0, end: 0),
      badgeStyle: badges.BadgeStyle(
        shape: number > 9 ? badges.BadgeShape.square : badges.BadgeShape.circle,
        badgeColor: Colors.red,
        borderRadius: number > 9 ? BorderRadius.circular(10.w) : BorderRadius.all(Radius.zero),
        padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 5.w),
      ),
    );
  }
}

class CustomBadgeTab extends StatelessWidget {
  const CustomBadgeTab({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: number > 0
            ? RedBadge(
                number: number,
                child: Text(text),
                position: badges.BadgePosition.topEnd(top: -10.w, end: -10.w),
              )
            : Text(text));
  }
}
