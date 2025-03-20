import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'contract_edit_logic.dart';

class ContractEditPage extends StatelessWidget {
  final logic = Get.put(ContractEditLogic());
  final state = Get.find<ContractEditLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title: '编辑合同',
        actionName: '保存',
        onActionPressed: logic.toSubmit,
      ),
      body: GetBuilder<ContractEditLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return ListView.separated(
            itemBuilder: (context, index) {
              CustomField field = state.customFieldListEntity!.list![index];
              return InkWell(
                onTap: !['source'].contains(field.reflect) ? () => logic.toEdit(field) : null,
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
                      if (!['source'].contains(field.reflect))
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
