import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    super.key,
    required this.projectEntity,
    this.onItem,
  });

  final ProjectEntity projectEntity;
  final Function()? onItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItem,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                LoadSvgImage(
                  'project_house',
                  width: 15.w,
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    projectEntity.projectName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.w),
            Row(
              children: [
                LoadSvgImage(
                  'project_location',
                  width: 15.w,
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    projectEntity.projectLocation ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.w),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '总设备数 ${projectEntity.equipmentNum ?? 0} 台',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'IoT设备 ${projectEntity.iotNum ?? 0} 台',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
