import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.keyboardType,
    required this.controller,
    this.hintText,
    this.inputFormatters,
    this.obscureText = false,
    this.backgroundColor,
    this.hintColor,
    this.textColor,
    this.textFontSize,
    this.padding,
    this.autofocus = false,
    this.onEditingComplete,
    this.borderRadius,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.constraints,
  }) : super(key: key);
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Color? backgroundColor;
  final Color? hintColor;
  final Color? textColor;
  final double? textFontSize;
  final EdgeInsets? padding;
  final bool autofocus;
  final VoidCallback? onEditingComplete;
  final BorderRadius? borderRadius;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? constraints;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<String?> text = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    text.value = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: widget.constraints ?? BoxConstraints(),
      child: TextField(
        controller: widget.controller,
        onChanged: (value) => text.value = value,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText,
        autofocus: widget.autofocus,
        onEditingComplete: widget.onEditingComplete,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(7.w),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: widget.backgroundColor ?? Color(0xFFECF6FF),
          contentPadding: widget.padding ?? EdgeInsets.symmetric(horizontal: 15.w),
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: BoxConstraints.tight(Size(30.w, 30.w)),
          suffixIcon: ValueListenableBuilder<String?>(
            valueListenable: text,
            child: InkWell(
              onTap: () {
                text.value = null;
                widget.controller.clear();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: widget.suffixIcon ??
                    LoadSvgImage(
                      'ticket_detail_unselect_unqualified',
                      width: 15.w,
                    ),
              ),
            ),
            builder: (context, value, child) => (value?.isEmpty ?? true) ? const SizedBox() : child!,
          ),
          hintStyle: TextStyle(
            color: widget.hintColor ?? Color(0xFF63B3FF),
            fontSize: widget.textFontSize ?? 14.sp,
          ),
          hintText: widget.hintText,
        ),
        style: TextStyle(
          color: widget.textColor ?? Colours.text_333,
          fontSize: widget.textFontSize ?? 14.sp,
        ),
      ),
    );
  }
}
