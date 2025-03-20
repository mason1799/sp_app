import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class CustomFieldItem extends StatelessWidget {
  const CustomFieldItem({
    this.title,
    this.value,
    this.onTap,
    this.isNecessary = false,
    this.bottomLine = true,
  });

  final String? title;
  final String? value;
  final Function()? onTap;
  final bool isNecessary;
  final bool bottomLine;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: 50.w,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: bottomLine ? BorderSide(width: 0.5.w, color: Colours.bg) : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  if (isNecessary)
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red,
                      ),
                    ),
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 14.w,
                      color: Colours.text_666,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                value ?? '',
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.w,
                  color: Colours.text_333,
                ),
              ),
            ),
            if (onTap != null)
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: LoadSvgImage(
                  'arrow_right',
                  width: 14.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BuildDepartmentValue extends StatelessWidget {
  const BuildDepartmentValue({
    required this.field,
    required this.items,
  });

  final CustomField field;
  final List<DepartmentNode> items;

  @override
  Widget build(BuildContext context) {
    DepartmentNode? departmentNode;
    String? fromId = field.value;
    for (var element in items) {
      departmentNode = element.getDepartmentFromID(fromId);
    }
    return Expanded(
      child: Text(
        departmentNode?.name ?? '',
        textAlign: TextAlign.end,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14.w,
          color: Colours.text_333,
        ),
      ),
    );
  }
}

class DataItem extends StatelessWidget {
  const DataItem({
    required this.title,
    required this.icon,
    this.value,
  });

  final String title;
  final String icon;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
      decoration: BoxDecoration(
        color: Colours.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.w),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.w,
              color: Colours.text_666,
            ),
          ),
          SizedBox(height: 10.w),
          LoadSvgImage(
            icon,
            width: 24.w,
          ),
          SizedBox(height: 10.w),
          Text(
            value ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.w,
              color: Colours.text_333,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class NumberItem extends StatelessWidget {
  const NumberItem({
    required this.title,
    required this.icon,
    this.value,
    this.unit,
  });

  final String title;
  final String icon;
  final num? value;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
      decoration: BoxDecoration(
        color: Colours.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.w),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.w,
              color: Colours.text_666,
            ),
          ),
          SizedBox(height: 10.w),
          LoadSvgImage(
            icon,
            width: 24.w,
          ),
          SizedBox(height: 10.w),
          AnimatedNumberText(
            value ?? 0,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 1500),
            style: TextStyle(
              fontSize: 13.w,
              color: Colours.text_333,
              fontWeight: FontWeight.w500,
            ),
            formatter: (value) => '${value.toStringAsFixed(2)}${unit ?? ''}',
          ),
        ],
      ),
    );
  }
}
