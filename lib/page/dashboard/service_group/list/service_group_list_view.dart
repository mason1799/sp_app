import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'service_group_list_logic.dart';

class ServiceGroupListPage extends StatelessWidget {
  final logic = Get.find<ServiceGroupListLogic>();
  final state = Get.find<ServiceGroupListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '维保组列表'),
      body: GetBuilder<ServiceGroupListLogic>(
        builder: (_) {
          return AdvanceRefreshListView(
            onRefresh: () => logic.pull(),
            pageStatus: state.pageStatus,
            itemBuilder: (context, index) {
              final entity = state.items![index];
              String? memberInfo;
              if (entity.members?.isNotEmpty == true) {
                if (entity.members!.length > 3) {
                  memberInfo = entity.members!.sublist(0, 3).map((e) => e.username).join('、');
                } else {
                  memberInfo = entity.members!.map((e) => e.username).join('、');
                }
              }
              String title = '';
              title += entity.groupName ?? '';
              if (entity.groupCode != null) {
                title += ' | ';
                title += entity.groupCode!;
              }
              return InkWell(
                onTap: () => logic.toItem(entity),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10.w,
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colours.text_333,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10.w,
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Text(
                                '小组负责人：${entity.employee ?? ''}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colours.text_333,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10.w,
                                left: 20.w,
                                right: 20.w,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '小组成员：',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colours.text_333,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      memberInfo ?? '',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colours.text_333,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (ObjectUtil.isNotEmpty(entity.members) && entity.members!.length >= 3)
                                    Text(
                                      '等${entity.members!.length}人',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colours.text_333,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.w, left: 20.w, right: 20.w, bottom: 10.w),
                              child: Text(
                                '所属部门：${entity.departmentName ?? ''}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colours.text_333,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LoadSvgImage(
                        'arrow_right',
                        width: 14.w,
                      ),
                      SizedBox(width: 15.w),
                    ],
                  ),
                ),
              );
            },
            itemCount: state.items?.length ?? 0,
          );
        },
      ),
    );
  }
}
