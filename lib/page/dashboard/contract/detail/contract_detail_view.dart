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

import 'contract_detail_logic.dart';

class ContractDetailPage extends StatelessWidget {
  final logic = Get.find<ContractDetailLogic>();
  final state = Get.find<ContractDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar(
        title: '合同详情',
        actionWidget: GetBuilder<ContractDetailLogic>(builder: (_) => _ActionWidget()),
      ),
      body: GetBuilder<ContractDetailLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return ListView.separated(
            itemBuilder: (context, index) {
              CustomField field = state.customFieldListEntity!.list![index];
              return CustomFieldItem(
                title: field.fieldName,
                value: field.value,
              );
            },
            separatorBuilder: (context, index) => divider,
            itemCount: state.customFieldListEntity?.list?.length ?? 0,
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
    final logic = Get.find<ContractDetailLogic>();
    if (StoreLogic.to.permissions.intersection({UserPermission.contractEdit, UserPermission.deleteContract}).isNotEmpty) {
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
