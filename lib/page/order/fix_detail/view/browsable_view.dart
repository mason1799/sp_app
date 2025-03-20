import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/order/fix_detail/fix_detail_logic.dart';
import 'package:konesp/page/order/fix_detail/widget/device_item.dart';
import 'package:konesp/page/order/widget/bottom_btn.dart';
import 'package:konesp/page/order/widget/location_item.dart';
import 'package:konesp/page/order/widget/row_item.dart';
import 'package:konesp/page/order/widget/tip_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/common_util.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/drag/draggable_float_widget.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/photo_preview.dart';

/// [待接单、待签到、已暂停、待签字、已完成]
class BrowsableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FixDetailLogic>();
    final state = logic.state;
    return Stack(
      children: [
        Column(
          children: [
            if (state.fixOrderStatus == FixOrderStatus.accept)
              TipItem(
                '未响应：接单后系统将反馈给创单人，请及时接单',
                icon: 'tip_icon',
                bgColor: Colours.secondary,
                txtColor: Colours.primary,
              )
            else if (state.fixOrderStatus == FixOrderStatus.checkIn)
              TipItem(
                '响应中',
                icon: 'loading_icon',
                bgColor: Color(0xFFFFF4E8),
                txtColor: Color(0xFFF98600),
              )
            else if (state.fixOrderStatus == FixOrderStatus.pause)
              TipItem(
                state.role == FixOrderRole.mainRespond
                    ? '响应中：工单暂停中，${state.orderDetail!.stopTime ?? ''}离开，离开时设备${state.orderDetail!.leaveEquipmentState ?? ''}'
                    : '响应中',
                icon: 'loading_icon',
                bgColor: Color(0xFFFFF4E8),
                txtColor: Color(0xFFF98600),
              )
            else if (state.fixOrderStatus == FixOrderStatus.sign)
              Builder(
                builder: (_) {
                  List<String> notSignList = [];
                  if (ObjectUtil.isEmpty(state.orderDetail!.signatureImage)) {
                    notSignList.add(state.orderDetail!.mainResponseUserName ?? '');
                  }
                  var notAssists = state.orderDetail!.assistEmployees?.where((element) => ObjectUtil.isEmpty(element)).toList();
                  if (ObjectUtil.isNotEmpty(notAssists)) {
                    notSignList.addAll(notAssists!.map((e) => e.username ?? '').toList());
                  }
                  return TipItem(
                    notSignList.isEmpty ? '响应中：主响应人、辅助人员未签字' : '你已成功提交工单，当${notSignList.join(',')}签字后工单状态将自动转变为完成',
                    icon: 'loading_icon',
                    bgColor: Color(0xFFFFF4E8),
                    txtColor: Color(0xFFF98600),
                  );
                },
              )
            else if (state.fixOrderStatus == FixOrderStatus.finish)
              TipItem(
                '已完成',
                icon: 'finish_icon',
                bgColor: const Color(0xffE5FFF9),
                txtColor: const Color(0xff00BA34),
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
                      DeviceItem(entity: state.orderDetail!),
                      RowItem(title: '故障报修类型：', content: state.orderDetail!.faultRepairType == 2 ? '普通' : '困人', margin: EdgeInsets.only(top: 10.w)),
                      RowItem(title: '故障描述：', content: state.orderDetail!.faultDesc),
                      RowItem(title: '报修时间：', content: DateUtil.formatDateStr(state.orderDetail!.repairTime, format: DateFormats.ymdhm)),
                      RowItem(title: '报修人姓名：', content: state.orderDetail!.repairman),
                      RowItem(title: '报修人角色：', content: state.orderDetail!.repairRoleName),
                      RowItem(title: '报修人电话：', content: state.orderDetail!.repairPhone, bottomLine: false),
                      if (state.fixOrderStatus == FixOrderStatus.checkIn)
                        GetBuilder<FixDetailLogic>(
                          id: 'location',
                          builder: (_) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10.w),
                                LocationItem(
                                  title: '签到地址：',
                                  content: state.orderDetail!.signInLocation,
                                  locationLoading: state.loading,
                                  refreshClick: logic.getLocation,
                                ),
                                RowItem(
                                  title: '距离偏差：',
                                  content: state.orderDetail!.signInDistance != null
                                      ? CommonUtil.formatDistance(state.orderDetail!.signInDistance!)
                                      : null,
                                  rightColor: Colors.red,
                                  rightText: (state.checkInDeviation == null ||
                                          state.orderDetail!.signInDistance == null ||
                                          state.orderDetail!.signInDistance! < state.checkInDeviation!)
                                      ? null
                                      : '不在签到范围内',
                                ),
                              ],
                            );
                          },
                        )
                      else if ([FixOrderStatus.pause, FixOrderStatus.sign, FixOrderStatus.finish].contains(state.fixOrderStatus)) ...[
                        TitleItem(title: '现场故障详情'),
                        RowItem(title: '到达现场设备状况：', content: state.orderDetail!.arriveEquipmentState),
                        RowItem(title: '离开现场设备状况：', content: state.orderDetail!.leaveEquipmentState),
                        RowItem(title: '故障原因：', content: state.orderDetail!.faultCause),
                        RowItem(title: '故障处理行动：', content: state.orderDetail!.faultDisposalAction, bottomLine: false),
                        TitleItem(title: '部件详情'),
                        RowItem(title: '故障部件：', content: state.orderDetail!.faultParts),
                        RowItem(title: '更换部件名称：', content: state.orderDetail!.updateParts),
                        RowItem(title: '更换部件数量：', content: state.orderDetail!.updatePartsCount?.toString(), bottomLine: false),
                        if (state.orderDetail!.faultRepairType == 1) ...[
                          TitleItem(title: '困人详情'),
                          RowItem(title: '被困人数：', content: state.orderDetail!.trappedCount?.toString()),
                          RowItem(title: '被困时间（分钟）：', content: state.orderDetail!.trappedMinutes?.toString()),
                          RowItem(title: '乘客脱困方式：', content: state.orderDetail!.escapeMode),
                          RowItem(title: '乘客受伤投诉情况：', content: state.orderDetail!.complaintDetails, bottomLine: false),
                        ],
                        RowItem(
                          title: '备注',
                          onTap: logic.toRemark,
                          margin: EdgeInsets.only(top: 10.w),
                          behindWidget: ObjectUtil.isNotEmpty(state.orderDetail!.remarkImages) || ObjectUtil.isNotEmpty(state.orderDetail!.remark)
                              ? LoadAssetImage(
                                  'attach_icon',
                                  width: 12.w,
                                )
                              : null,
                        ),
                        RowItem(title: '工作进度', onTap: logic.toProcess, margin: EdgeInsets.only(top: 10.w)),
                      ],
                      RowItem(title: '主响应人：', content: state.orderDetail!.mainResponseUserName, margin: EdgeInsets.only(top: 10.w)),
                      if (state.fixOrderStatus == FixOrderStatus.checkIn)
                        GetBuilder<FixDetailLogic>(
                          id: 'assist',
                          builder: (_) => RowItem(
                            title: '辅助人员：',
                            content: state.orderDetail!.assistEmployees?.map((e) => e.username).toList().join('、'),
                            rightText: state.role == FixOrderRole.mainRespond ? '编辑' : null,
                            rightTextClick: logic.toEditAssist,
                          ),
                        )
                      else if ([FixOrderStatus.sign, FixOrderStatus.finish].contains(state.fixOrderStatus))
                        Builder(
                          builder: (context) {
                            String? assists = state.orderDetail!.assistEmployees?.map((e) => e.username).toList().join('、');
                            List<String> signedNames = [];
                            List<String> signedImages = [];
                            if (ObjectUtil.isNotEmpty(state.orderDetail!.signatureImage) &&
                                ObjectUtil.isNotEmpty(state.orderDetail!.mainResponseUserName)) {
                              signedNames.add(state.orderDetail!.mainResponseUserName!);
                              signedImages.add(state.orderDetail!.signatureImage!);
                            }
                            state.orderDetail!.assistEmployees?.forEach((element) {
                              if (ObjectUtil.isNotEmpty(element.signatureImage) && ObjectUtil.isNotEmpty(element.username)) {
                                signedNames.add(element.username!);
                                signedImages.add(element.signatureImage!);
                              }
                            });
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RowItem(title: '辅助人员：', content: assists),
                                RowItem(title: '已签字：', content: signedNames.join('、'), bottomLine: signedImages.isEmpty),
                                if (signedImages.isNotEmpty)
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
                                        onTap: () => Get.to(() => PhotoPreview(ossKey: signedImages[index], title: '签字')),
                                        child: LoadImage(
                                          signedImages[index],
                                          width: double.infinity,
                                          height: double.infinity,
                                          border: Border.all(
                                            width: 0.5.w,
                                            color: Color(0xFFF3F3F3),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4.w),
                                          ),
                                        ),
                                      ),
                                      itemCount: signedImages.length,
                                    ),
                                  ),
                              ],
                            );
                          },
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
            if (state.fixOrderStatus == FixOrderStatus.accept)
              BottomBtn(
                onPressed: logic.accept,
                btnName: '接单',
              )
            else if (state.fixOrderStatus == FixOrderStatus.checkIn && state.role == FixOrderRole.mainRespond)
              BottomBtn(
                onPressed: logic.checkIn,
                btnName: '签到',
              )
            else if (state.fixOrderStatus == FixOrderStatus.pause && state.role == FixOrderRole.mainRespond)
              BottomBtn(
                onPressed: logic.resume,
                btnName: '恢复工单',
              )
            else if (state.fixOrderStatus == FixOrderStatus.sign)
              Builder(
                builder: (_) {
                  if (state.orderDetail!.mainResponseUserId == StoreLogic.to.getUser()!.id &&
                      ObjectUtil.isNotEmpty(state.orderDetail!.signatureImage)) {
                    return SizedBox.shrink();
                  }
                  var assists = state.orderDetail!.assistEmployees?.where((element) => element.userId == StoreLogic.to.getUser()!.id).toList();
                  if (ObjectUtil.isNotEmpty(assists) && ObjectUtil.isNotEmpty(assists!.first.signatureImage)) {
                    return SizedBox.shrink();
                  }
                  return BottomBtn(
                    onPressed: () => Get.toNamed(Routes.signatureBoard, arguments: {'type': 2}),
                    btnName: '签字',
                  );
                },
              ),
          ],
        ),
        if ([FixOrderStatus.checkIn, FixOrderStatus.pause].contains(state.fixOrderStatus) && state.orderDetail!.isKceEquipment == true)
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
