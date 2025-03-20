import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/entity/regular_detail_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class CheckItem extends StatelessWidget {
  final RegularDetailEntity entity;
  final Function()? onTap;

  CheckItem({
    required this.entity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        height: 80.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '检查项目清单（${entity.checkTotalNum ?? '0'}/${entity.totalNum}）',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colours.text_666,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      LoadSvgImage(
                        'ticket_list_qualified',
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${entity.qualifiedNum ?? 0}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.primary,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      LoadSvgImage(
                        'ticket_list_unqualified',
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${entity.noQualifiedNum ?? 0}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.primary,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      LoadSvgImage(
                        'ticket_list_fix',
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${entity.repairNum ?? 0}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.primary,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      LoadSvgImage(
                        'ticket_list_not_apply',
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${entity.unsuitableNum ?? 0}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colours.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            LoadSvgImage(
              'arrow_right',
              width: 14.w,
            ),
          ],
        ),
      ),
    );
  }
}
