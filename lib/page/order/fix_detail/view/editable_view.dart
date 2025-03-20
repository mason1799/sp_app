import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/order/fix_detail/fix_detail_logic.dart';
import 'package:konesp/page/order/fix_detail/widget/device_item.dart';
import 'package:konesp/page/order/widget/bottom_btn.dart';
import 'package:konesp/page/order/widget/location_item.dart';
import 'package:konesp/page/order/widget/number_editor_item.dart';
import 'package:konesp/page/order/widget/row_item.dart';
import 'package:konesp/page/order/widget/segment_btn.dart';
import 'package:konesp/page/order/widget/tip_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/util/common_util.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/drag/draggable_float_widget.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/outlined_btn.dart';
import 'package:konesp/widget/text_btn.dart';

/// [待签退、待提交]
class EditableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FixDetailLogic>();
    final state = logic.state;
    return Stack(
      children: [
        Column(
          children: [
            TipItem(
              state.fixOrderStatus == FixOrderStatus.checkOut ? '响应中' : '响应中：工单待提交',
              icon: 'loading_icon',
              bgColor: Color(0xFFFFF4E8),
              txtColor: Color(0xFFF98600),
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
                      GetBuilder<FixDetailLogic>(
                        id: 'device',
                        builder: (logic) => DeviceItem(
                          entity: state.orderDetail!,
                          onTap: logic.selectDevice,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      GetBuilder<FixDetailLogic>(
                        id: 'faultRepairType',
                        builder: (logic) => SegmentRow(
                          title: '故障报修类型',
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SegmentControlButton(
                                isNormal: state.orderDetail!.faultRepairType == 2,
                                onTap: (bool select) => logic.selectFaultRepairType(select),
                              ),
                            ],
                          ),
                          necessary: true,
                        ),
                      ),
                      divider,
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.only(left: 15.w, top: 10.w),
                        child: Row(
                          children: [
                            Text(
                              '*',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              '故障描述：',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colours.text_666,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                        child: TextField(
                          controller: TextEditingController(text: state.orderDetail!.faultDesc),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_333,
                          ),
                          inputFormatters: [LengthLimitingTextInputFormatter(50)],
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: '输入当前设备情况',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: Colours.text_ccc,
                            ),
                          ),
                          onChanged: (text) => state.orderDetail!.faultDesc = text.trim(),
                        ),
                      ),
                      divider,
                      GetBuilder<FixDetailLogic>(
                        id: 'repairTime',
                        builder: (logic) => RowItem(
                          necessary: true,
                          title: '报修时间：',
                          onTap: logic.selectRepairTime,
                          content: DateUtil.formatDateStr(state.orderDetail!.repairTime!, format: DateFormats.ymdhm),
                        ),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'repairMan',
                        builder: (logic) => RowItem(
                          necessary: true,
                          title: '报修人姓名：',
                          onTap: logic.selectRepairMan,
                          content: state.orderDetail!.repairman,
                        ),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'repairRole',
                        builder: (logic) => RowItem(
                          necessary: true,
                          title: '报修人角色：',
                          onTap: logic.selectRepairRole,
                          content: state.orderDetail!.repairRoleName,
                        ),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'repairPhone',
                        builder: (logic) => RowItem(
                          necessary: true,
                          title: '报修人电话：',
                          onTap: logic.selectRepairPhone,
                          content: state.orderDetail!.repairPhone,
                          bottomLine: false,
                        ),
                      ),
                      TitleItem(title: '现场故障详情'),
                      GetBuilder<FixDetailLogic>(
                        id: 'arriveEquipmentState',
                        builder: (logic) => RowItem(
                          title: '到达现场设备状况：',
                          necessary: true,
                          onTap: logic.selectArriveEquipmentState,
                          content: state.orderDetail!.arriveEquipmentState,
                        ),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'leaveEquipmentState',
                        builder: (logic) => RowItem(
                          title: '离开现场设备状况：',
                          necessary: true,
                          onTap: logic.selectLeaveEquipmentState,
                          content: state.orderDetail!.leaveEquipmentState,
                        ),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'faultCause',
                        builder: (logic) => RowItem(
                          title: '故障原因：',
                          necessary: true,
                          onTap: logic.selectFaultCause,
                          content: state.orderDetail!.faultCause,
                        ),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'faultDisposalAction',
                        builder: (logic) => RowItem(
                          title: '故障处理行动：',
                          necessary: true,
                          onTap: logic.selectFaultDisposalAction,
                          content: state.orderDetail!.faultDisposalAction,
                          bottomLine: false,
                        ),
                      ),
                      TitleItem(title: '部件详情'),
                      GetBuilder<FixDetailLogic>(
                        id: 'faultParts',
                        builder: (logic) => RowItem(
                          necessary: true,
                          title: '故障部件：',
                          onTap: logic.selectFaultParts,
                          content: state.orderDetail!.faultParts,
                        ),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'updateParts',
                        builder: (logic) => RowItem(
                          title: '更换部件名称：',
                          onTap: logic.selectUpdateParts,
                          content: state.orderDetail!.updateParts,
                        ),
                      ),
                      NumberEditorItem(
                        title: '更换部件数量',
                        number: state.orderDetail!.updatePartsCount,
                        onChangeNumber: (number) => state.orderDetail!.updatePartsCount = number?.toInt(),
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'faultRepairType',
                        builder: (_) {
                          if (state.orderDetail!.faultRepairType == 1) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleItem(title: '困人详情'),
                                NumberEditorItem(
                                  title: '被困人数',
                                  necessary: true,
                                  number: state.orderDetail!.trappedCount,
                                  onChangeNumber: (number) => state.orderDetail!.trappedCount = number?.toInt(),
                                ),
                                NumberEditorItem(
                                  title: '被困时间（分钟）',
                                  necessary: true,
                                  number: state.orderDetail!.trappedMinutes,
                                  onChangeNumber: (number) => state.orderDetail!.trappedMinutes = number?.toInt(),
                                ),
                                GetBuilder<FixDetailLogic>(
                                  id: 'escapeMode',
                                  builder: (logic) => RowItem(
                                    title: '乘客脱困方式：',
                                    necessary: true,
                                    onTap: logic.selectEscapeMode,
                                    content: state.orderDetail!.escapeMode,
                                  ),
                                ),
                                GetBuilder<FixDetailLogic>(
                                  id: 'complaintDetails',
                                  builder: (logic) => RowItem(
                                    title: '乘客受伤投诉情况：',
                                    necessary: true,
                                    onTap: logic.selectCompaintDetails,
                                    content: state.orderDetail!.complaintDetails,
                                    bottomLine: false,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      GetBuilder<FixDetailLogic>(
                        id: 'remark',
                        builder: (_) => RowItem(
                          title: '备注',
                          onTap: () => logic.toRemark(isEnableEdit: true),
                          margin: EdgeInsets.only(top: 10.w),
                          behindWidget: ObjectUtil.isNotEmpty(state.orderDetail!.remarkImages) || ObjectUtil.isNotEmpty(state.orderDetail!.remark)
                              ? LoadAssetImage(
                                  'attach_icon',
                                  width: 12.w,
                                )
                              : null,
                        ),
                      ),
                      RowItem(title: '工作进度', onTap: logic.toProcess, margin: EdgeInsets.only(top: 10.w)),
                      if (state.fixOrderStatus == FixOrderStatus.checkOut)
                        GetBuilder<FixDetailLogic>(
                          id: 'location',
                          builder: (_) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.w),
                              LocationItem(
                                title: '签退地址：',
                                content: state.orderDetail!.signOutLocation,
                                locationLoading: state.loading,
                                refreshClick: logic.getLocation,
                              ),
                              RowItem(
                                title: '距离偏差：',
                                content: state.orderDetail!.signOutDistance != null
                                    ? CommonUtil.formatDistance(state.orderDetail!.signOutDistance!)
                                    : null,
                                rightColor: Colors.red,
                                rightText: (state.checkOutDeviation == null ||
                                        state.orderDetail!.signOutDistance == null ||
                                        state.orderDetail!.signOutDistance! < state.checkOutDeviation!)
                                    ? null
                                    : '不在签退范围内',
                                bottomLine: false,
                              ),
                            ],
                          ),
                        ),
                      RowItem(title: '主响应人：', content: state.orderDetail!.mainResponseUserName, margin: EdgeInsets.only(top: 10.w)),
                      GetBuilder<FixDetailLogic>(
                        id: 'assist',
                        builder: (_) => RowItem(
                          title: '辅助人员：',
                          content: state.orderDetail!.assistEmployees?.map((e) => e.username).toList().join('、'),
                          rightText: state.role == FixOrderRole.mainRespond ? '编辑' : null,
                          rightTextClick: logic.toEditAssist,
                        ),
                      ),
                      if (ObjectUtil.isNotEmpty(state.orderDetail!.groupName) && ObjectUtil.isNotEmpty(state.orderDetail!.groupCode))
                        RowItem(title: '${state.orderDetail!.groupName!} ${state.orderDetail!.groupCode!}', titleColor: Colours.text_333),
                      RowItem(title: '工单编号：', content: state.orderDetail!.orderNumber, bottomLine: false),
                      SizedBox(height: 10.w),
                    ],
                  ),
                ),
              ),
            ),
            if (state.fixOrderStatus == FixOrderStatus.checkOut)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.only(
                  left: 36.w,
                  right: 36.w,
                  top: 12.w,
                  bottom: 12.w + ScreenUtil().bottomBarHeight,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedBtn(
                          onPressed: logic.pause,
                          size: Size(double.infinity, 44.w),
                          borderColor: Colours.primary,
                          borderWidth: 0.5.w,
                          text: '暂停',
                          radius: 7.w,
                          style: TextStyle(
                            color: Colours.primary,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: TextBtn(
                          onPressed: logic.checkOut,
                          size: Size(double.infinity, 44.w),
                          text: '签退',
                          radius: 7.w,
                          backgroundColor: Colours.primary,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (state.fixOrderStatus == FixOrderStatus.commit)
              BottomBtn(
                onPressed: logic.commit,
                btnName: '提交工单',
              ),
          ],
        ),
        if (state.orderDetail!.isKceEquipment == true)
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
  }
}
