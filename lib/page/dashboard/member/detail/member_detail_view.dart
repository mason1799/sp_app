import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_field_item.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'member_detail_logic.dart';

class MemberDetailPage extends StatelessWidget {
  final logic = Get.find<MemberDetailLogic>();
  final state = Get.find<MemberDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar(
        title: '人员详情',
        actionWidget: GetBuilder<MemberDetailLogic>(builder: (_) => _ActionWidget()),
      ),
      body: GetBuilder<MemberDetailLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return ListView.separated(
            itemBuilder: (context, index) {
              CustomField field = state.customFieldListEntity!.list![index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                height: 44.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      field.fieldName ?? '',
                      style: TextStyle(
                        fontSize: 14.w,
                        color: Colours.text_666,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    if (field.reflect == 'avatar')
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: LoadImage(
                            field.value,
                            holderImg: 'default_avatar',
                            width: 30.w,
                            height: 30.w,
                            border: Border.all(color: Colors.white, width: 0.5.w),
                            borderRadius: BorderRadius.circular(15.w),
                          ),
                        ),
                      )
                    else if (field.reflect == 'organId')
                      BuildDepartmentValue(
                        field: field,
                        items: state.departments,
                      )
                    else
                      Expanded(
                        child: Text(
                          field.value ?? '',
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.w,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => divider,
            itemCount: state.customFieldListEntity!.list?.length ?? 0,
          );
        } else if (state.pageStatus == PageStatus.error) {
          return ErrorPage();
        } else if (state.pageStatus == PageStatus.loading) {
          return CenterLoading();
        } else {
          return EmptyPage();
        }
      }),
    );
  }
}

class _ActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MemberDetailLogic>();
    if (StoreLogic.to.permissions.contains(UserPermission.memberManagerEdit)) {
      return InkWell(
        onTap: logic.moreAction,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: LoadAssetImage(
            'more_icon',
            width: 16.w,
            color: Colours.text_333,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
