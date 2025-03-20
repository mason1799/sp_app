import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/entity/fix_detail_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/equipment_icon.dart';
import 'package:konesp/widget/load_image.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    required this.entity,
    this.onTap,
  });

  final FixDetailEntity entity;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                color: Colours.bg,
                borderRadius: BorderRadius.circular(4.w),
              ),
              alignment: Alignment.center,
              child: EquipmentIcon(type: entity.equipmentType),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entity.projectName ?? ''} ${entity.buildingCode ?? ''} ${entity.elevatorCode ?? ''}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colours.text_333,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    '${entity.equipmentTypeName ?? ''} | ${entity.equipmentCode ?? ''}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colours.text_999,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onTap != null)
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
