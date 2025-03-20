import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Size? size;
  final double? elevation;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final double? radius;
  final Widget? child;
  final AlignmentGeometry? alignment;

  TextBtn({
    super.key,
    this.text,
    this.backgroundColor,
    this.padding,
    this.size,
    this.elevation,
    this.style,
    this.onPressed,
    this.radius,
    this.child,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        backgroundColor: WidgetStateProperty.all(backgroundColor ?? Colors.transparent),
        minimumSize: WidgetStateProperty.all(size),
        padding: WidgetStateProperty.all(padding ?? EdgeInsets.zero),
        elevation: WidgetStateProperty.all(elevation ?? 0),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0))),
        alignment: alignment,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: child ??
          Text(
            text ?? '按钮',
            style: style,
          ),
    );
  }
}
