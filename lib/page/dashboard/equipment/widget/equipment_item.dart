import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:konesp/entity/equipment_detail_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/custom_slidable.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/equipment_icon.dart';

class EquipmentItem extends StatelessWidget {
  const EquipmentItem({
    super.key,
    required this.entity,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final EquipmentDetailEntity entity;
  final Function()? onTap;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: CustomSlidable(
          // 根据权限来判断
          enabled: onEdit != null &&
              onDelete != null &&
              StoreLogic.to.permissions.intersection({UserPermission.editEquipment, UserPermission.deleteEquipment}).isNotEmpty,
          endActionPane: ActionPane(
            extentRatio: StoreLogic.to.permissions.containsAll({UserPermission.editEquipment, UserPermission.deleteEquipment}) ? 0.35 : 0.18,
            motion: const BehindMotion(),
            dragDismissible: false,
            children: [
              // 如有编辑设备权限
              if (StoreLogic.to.permissions.contains(UserPermission.editEquipment))
                CustomSlidableAction(
                  onPressed: (context) => onEdit?.call(),
                  backgroundColor: const Color(0xFFF9CC46),
                  padding: EdgeInsets.zero,
                  child: Text(
                    '编辑',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              // 如有删除设备权限
              if (StoreLogic.to.permissions.contains(UserPermission.deleteEquipment))
                CustomSlidableAction(
                  onPressed: (context) => onDelete?.call(),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.zero,
                  child: Text(
                    '删除',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.only(left: 15.w, top: 15.w, bottom: 15.w, right: 25.w),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: Colours.bg,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    alignment: Alignment.center,
                    child: EquipmentIcon(type: int.tryParse(entity.equipmentType!)),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if ([1, 2].contains(entity.iotOnline))
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(right: 5.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: entity.iotOnline! == 2 ? Colors.green : Colours.text_ccc,
                                ),
                              ),
                            if (ObjectUtil.isNotEmpty(entity.buildingCode) || ObjectUtil.isNotEmpty(entity.elevatorCode))
                              Text(
                                '${entity.buildingCode ?? ''} ${entity.elevatorCode ?? ''} | ${entity.equipmentCode}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colours.text_333,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        Text(
                          entity.projectName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  // 开启侧滑则显示
                  if (onEdit != null &&
                      onDelete != null &&
                      StoreLogic.to.permissions.intersection({UserPermission.editEquipment, UserPermission.deleteEquipment}).isNotEmpty)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colours.text_ccc,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colours.text_ccc,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colours.text_ccc,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
