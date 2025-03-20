import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/order/widget/bottom_btn.dart';
import 'package:konesp/page/order/widget/row_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/common_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/drag/draggable_float_widget.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/photo_preview.dart';
import 'package:konesp/widget/sheet/share_dialog.dart';
import 'package:konesp/widget/title_bar.dart';

import '../widget/check_item.dart';
import '../widget/location_item.dart';
import '../widget/tip_item.dart';
import 'regular_detail_logic.dart';

///保养
class RegularDetailPage extends StatelessWidget {
  final logic = Get.find<RegularDetailLogic>();
  final state = Get.find<RegularDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title: '保养工单',
        actionWidget: GetBuilder<RegularDetailLogic>(builder: (_) => _ActionWidget()),
      ),
      body: GetBuilder<RegularDetailLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return Stack(
            children: [
              Column(
                children: [
                  if (ObjectUtil.isNotEmpty(logic.getTips()))
                    TipItem(
                      logic.getTips(),
                      icon: logic.getTipsIcon(),
                      bgColor: logic.getTipsColor(),
                      txtColor: logic.getTxtColor(),
                    ),
                  Expanded(
                    child: NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollStartNotification) {
                          state.eventStreamController.add(OperateEvent.OPERATE_HIDE);
                        } else if (notification is ScrollEndNotification) {
                          state.eventStreamController.add(OperateEvent.OPERATE_SHOW);
                        }
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (logic.isResponding() || logic.isFinish()) ...[
                              CheckItem(entity: state.orderDetail!, onTap: logic.toCheckStuffs),
                              RowItem(title: '备注', onTap: logic.toRemark, margin: EdgeInsets.only(top: 10.w)),
                              RowItem(title: '工作进度', onTap: logic.toProcess, margin: EdgeInsets.only(top: 10.w)),
                            ],
                            RowItem(title: '主响应人：', content: state.orderDetail!.mainResponseUserName, margin: EdgeInsets.only(top: 10.w)),
                            RowItem(
                              title: '辅助人员：',
                              content: logic.replaceSymbol(state.orderDetail!.assistEmployee),
                              rightText: (logic.isResponding() || logic.isUnResponse()) &&
                                      !logic.isAssist() &&
                                      !logic.isAheadReply() &&
                                      !logic.showPostCommit() &&
                                      state.orderDetail!.state != null
                                  ? '编辑'
                                  : null,
                              rightTextClick: logic.toAssist,
                            ),
                            if ((logic.isResponding() && logic.showPostCommit()) || logic.isFinish()) ...[
                              RowItem(
                                title: '已签字：',
                                content: state.orderDetail!.signatureImage != null ? logic.convertSignData(true) : null,
                                bottomLine: logic.signedImages().isEmpty,
                              ),
                              if (logic.signedImages().isNotEmpty)
                                Container(
                                  padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(bottom: BorderSide(color: Colours.bg, width: 0.5.w)),
                                  ),
                                  child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 6,
                                      crossAxisSpacing: 8.w,
                                      mainAxisSpacing: 8.w,
                                      childAspectRatio: 1,
                                    ),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () => Get.to(() => PhotoPreview(ossKey: logic.signedImages()[index], title: '签字')),
                                      child: LoadImage(
                                        logic.signedImages()[index],
                                        width: double.infinity,
                                        height: double.infinity,
                                        border: Border.all(
                                          width: 0.5.w,
                                          color: Color(0xffF3F3F3),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.w),
                                        ),
                                      ),
                                    ),
                                    itemCount: logic.signedImages().length,
                                  ),
                                ),
                            ],
                            if (ObjectUtil.isNotEmpty(state.orderDetail!.groupName) && ObjectUtil.isNotEmpty(state.orderDetail!.groupCode))
                              RowItem(title: '${state.orderDetail!.groupName!} ${state.orderDetail!.groupCode!}', titleColor: Colours.text_333),
                            RowItem(title: '工单编号：', content: state.orderDetail!.orderNumber, margin: EdgeInsets.only(top: 10.w)),
                            RowItem(
                              title: '项目详情：',
                              content:
                                  '${state.orderDetail!.projectName ?? ''} ${state.orderDetail?.buildingCode ?? ''}${state.orderDetail!.elevatorCode ?? ''}',
                            ),
                            RowItem(title: '项目地址：', content: state.orderDetail!.projectLocation),
                            RowItem(
                                title: '设备详情：', content: '${state.orderDetail!.equipmentTypeName ?? ''} ${state.orderDetail!.equipmentCode ?? ''}'),
                            RowItem(title: '注册代码：', content: state.orderDetail!.registerCode),
                            RowItem(title: '96333编号：', content: state.orderDetail!.code96333),
                            GetBuilder<RegularDetailLogic>(
                              id: 'location',
                              builder: (_) {
                                //待签到
                                if (logic.showUnderCheckIn()) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10.w),
                                      LocationItem(
                                        title: '签到地址：',
                                        content: state.startLocation,
                                        locationLoading: state.loading,
                                        refreshClick: logic.getLocation,
                                      ),
                                      RowItem(
                                        title: '距离偏差：',
                                        content: state.startDistance != null ? CommonUtil.formatDistance(state.startDistance!) : null,
                                        rightColor: Colors.red,
                                        rightText: (state.startDistance == null ||
                                                state.checkInDeviation == null ||
                                                state.startDistance! < state.checkInDeviation!)
                                            ? null
                                            : '不在签到范围内',
                                        bottomLine: false,
                                      ),
                                    ],
                                  );
                                } else if (logic.showUnderCheckOut()) {
                                  //待签退
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10.w),
                                      LocationItem(
                                        title: '签退地址：',
                                        content: state.endLocation,
                                        locationLoading: state.loading,
                                        refreshClick: logic.getLocation,
                                      ),
                                      RowItem(
                                        title: '距离偏差：',
                                        content: state.endDistance != null ? CommonUtil.formatDistance(state.endDistance!) : null,
                                        rightColor: Colors.red,
                                        rightText: (state.endDistance == null ||
                                                state.checkOutDeviation == null ||
                                                state.endDistance! < state.checkOutDeviation!)
                                            ? null
                                            : '不在签退范围内',
                                        bottomLine: false,
                                      ),
                                    ],
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                            RowItem(title: '编排方案：', content: state.orderDetail!.arrangeName, margin: EdgeInsets.only(top: 10.w)),
                            RowItem(title: '工单模块：', content: state.orderDetail!.orderModul, bottomLine: false),
                            SizedBox(height: 10.w),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (logic.isShowButtonFin() && (!logic.isReadOnlyDetail() || logic.isAssist()))
                    BottomBtn(
                      onPressed: logic.getBtnText() == null ? null : () => logic.bottomPressed(),
                      btnName: logic.getBtnText() ?? '未知',
                    ),
                ],
              ),
              if (state.orderDetail!.isKceEquipment == true &&
                  (logic.showUnderCheckIn() || logic.showUnderContinueCheck() || logic.showUnderCheckOut() || logic.showUnderCommit()))
                DraggableFloatWidget(
                  width: 60.w,
                  height: 60.w,
                  child: LoadAssetImage(
                    'kfps_entrance',
                    width: 60.w,
                  ),
                  eventStreamController: state.eventStreamController,
                  config: DraggableFloatWidgetBaseConfig(
                    isFullScreen: false,
                    initPositionXInLeft: false,
                    initPositionYInTop: false,
                    initPositionYMarginBorder: 120.w,
                    borderRight: 10.w,
                    borderLeft: 10.w,
                    exposedPartWidthWhenHidden: 15.w,
                  ),
                  onTap: logic.toKfps,
                ),
            ],
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
    final logic = Get.find<RegularDetailLogic>();
    final state = logic.state;
    //页面不是成功状态或辅助工单或提前回复
    if (state.pageStatus != PageStatus.success || logic.isAssist() || logic.isAheadReply()) {
      return SizedBox.shrink();
    } else if (logic.isResponding() && (logic.isCheckIn() || logic.isCheckOut() || (logic.showPostCommit() && logic.isExistAssistNotSigned()))) {
      //工单响应中，需要签到; 或签退; 或提前工单后存在辅助人员未签字情况;
      return InkWell(
        onTap: logic.moreBtn,
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
    } else if (logic.showUnderCheckIn()) {
      //工单未响应，步骤字段已清空
      return InkWell(
        onTap: logic.transferOrCancelSheet,
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
    } else if (state.orderDetail!.state == 3 && state.orderDetail!.isShowClientSign == true) {
      //工单已完成，需要客户签字
      return InkWell(
        onTap: () => Get.dialog(ShareDialog(isRegularOrder: true, orderId: state.orderDetail!.id!)),
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
    } else {
      return SizedBox.shrink();
    }
  }
}
