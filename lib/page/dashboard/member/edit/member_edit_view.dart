import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_field_item.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'member_edit_logic.dart';
import 'member_edit_state.dart';

class MemberEditPage extends StatelessWidget {
  final logic = Get.put(MemberEditLogic());
  final state = Get.find<MemberEditLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title: '编辑人员',
        actionName: '保存',
        onActionPressed: logic.toSubmit,
      ),
      body: GetBuilder<MemberEditLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return ListView.separated(
            itemBuilder: (context, index) {
              CustomField field = state.customFieldListEntity!.list![index];
              return InkWell(
                onTap: ['employeeCode'].contains(field.reflect) ? null : () => logic.toEdit(field),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  height: 44.w,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            if (field.necessary == 'Y')
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.red,
                                ),
                              ),
                            TextSpan(
                              text: field.fieldName ?? '',
                              style: TextStyle(
                                fontSize: 14.w,
                                color: Colours.text_666,
                              ),
                            ),
                          ],
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
                          items: state.departmentNodes,
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
                      if (!['employeeCode'].contains(field.reflect))
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
