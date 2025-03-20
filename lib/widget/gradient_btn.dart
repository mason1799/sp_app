///
/// ProjectName: konesp
/// Author: GT
/// CreateDate: 2023/3/2
/// Copyright: 通力电梯
/// Description:
import 'package:flutter/material.dart';

class GradientBtn extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget child;
  final bool select;

  GradientBtn({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient,
    this.select = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    final linearGradient = gradient ??
        LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: <Color>[
          Color(0xff3284FC),
          Color(0xff93CAFF),
        ]);
    return Container(
      width: width,
      height: height,
      decoration: select
          ? BoxDecoration(
        gradient: linearGradient,
        borderRadius: borderRadius,
      )
          : BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
