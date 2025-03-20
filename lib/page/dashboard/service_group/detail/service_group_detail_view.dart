import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/title_bar.dart';

import 'service_group_detail_logic.dart';

class ServiceGroupDetailPage extends StatelessWidget {
  final logic = Get.find<ServiceGroupDetailLogic>();
  final state = Get.find<ServiceGroupDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '维保组详情',
      ),
      body: Column(
        children: [
          SizedBox(height: 10.w),
          Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                itemWidget('维保小组', '${state.entity.groupName}/${state.entity.groupCode}'),
                itemWidget('小组负责人', state.entity.employee),
                itemWidget('小组成员', state.entity.members?.map((e) => e.username).join('、') ?? ''),
                itemWidget('所属部门', state.entity.departmentName),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemWidget(String title, String? value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 44.w),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.text_666,
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
                    fontSize: 14.sp,
                    color: Colours.text_333,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.5.w,
          color: Colours.bg,
        ),
      ],
    );
  }
}
