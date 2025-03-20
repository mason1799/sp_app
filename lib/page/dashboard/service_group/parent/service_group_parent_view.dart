import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/dashboard/department/department_view.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'service_group_parent_logic.dart';
import 'service_group_parent_state.dart';

class ServiceGroupParentPage extends StatelessWidget {
  final ServiceGroupParentLogic logic = Get.find<ServiceGroupParentLogic>();
  final ServiceGroupParentState state = Get.find<ServiceGroupParentLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '选择部门'),
      body: GetBuilder<ServiceGroupParentLogic>(builder: (_) {
        return AdvanceRefreshListView(
          onRefresh: () => logic.pull(),
          pageStatus: state.pageStatus,
          itemBuilder: (context, index) {
            final entity = state.items![index];
            return InkWell(
              onTap: () => logic.toItem(entity.id!),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    CircleText(name: entity.name?.substring(0, 1)),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        entity.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    LoadSvgImage(
                      'arrow_right',
                      width: 14.w,
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: state.items?.length ?? 0,
        );
      }),
    );
  }
}
