import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/sheet/share_dialog.dart';
import 'package:konesp/widget/title_bar.dart';

import 'fix_detail_logic.dart';
import 'view/browsable_view.dart';
import 'view/editable_view.dart';

// 故障
class FixDetailPage extends StatelessWidget {
  final logic = Get.find<FixDetailLogic>();
  final state = Get.find<FixDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TitleBar(
          title: '故障报修工单',
          actionWidget: GetBuilder<FixDetailLogic>(builder: (_) => _ActionView()),
        ),
        body: GetBuilder<FixDetailLogic>(
          builder: (_) {
            if (state.pageStatus == PageStatus.success) {
              if ([FixOrderStatus.checkOut, FixOrderStatus.commit].contains(state.fixOrderStatus)) {
                /// [待签退、待提交]
                return EditableView();
              } else if ([FixOrderStatus.accept, FixOrderStatus.checkIn, FixOrderStatus.pause, FixOrderStatus.sign, FixOrderStatus.finish]
                  .contains(state.fixOrderStatus)) {
                /// [待接单、待签到、已暂停、待签字、已完成]
                return BrowsableView();
              } else {
                return ErrorPage(msg: '工单已取消或不存在');
              }
            } else if (state.pageStatus == PageStatus.error) {
              return ErrorPage();
            } else {
              return CenterLoading();
            }
          },
        ),
      ),
    );
  }
}

class _ActionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FixDetailLogic>();
    final state = logic.state;
    if (state.pageStatus == PageStatus.success) {
      if (state.fixOrderStatus == FixOrderStatus.accept &&
          (StoreLogic.to.permissions.intersection({
                UserPermission.detailAssignTicketPermission,
                UserPermission.detailCancelTicketPermission,
              }).isNotEmpty &&
              state.role == FixOrderRole.mainRespond)) {
        return _MoreIcon(onTap: logic.orderAction);
      } else if ([FixOrderStatus.checkIn, FixOrderStatus.checkOut, FixOrderStatus.commit].contains(state.fixOrderStatus) &&
          state.role == FixOrderRole.mainRespond) {
        return _MoreIcon(onTap: logic.sheetAction);
      } else if (state.fixOrderStatus == FixOrderStatus.sign && ObjectUtil.isNotEmpty(state.orderDetail!.signatureImage)) {
        return _MoreIcon(onTap: logic.assistNotSigns);
      } else if (state.fixOrderStatus == FixOrderStatus.finish) {
        return InkWell(
          onTap: () => Get.dialog(ShareDialog(isRegularOrder: false, orderId: state.orderDetail!.id!)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            alignment: Alignment.center,
            child: Text(
              '客户签字',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colours.primary,
              ),
            ),
          ),
        );
      }
    }
    return SizedBox.shrink();
  }
}

class _MoreIcon extends StatelessWidget {
  const _MoreIcon({this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
        child: LoadSvgImage(
          'new_more',
          width: 24.w,
          color: Colours.text_333,
        ),
      ),
    );
  }
}
