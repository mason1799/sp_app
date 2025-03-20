import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/order/fix_select_member/fix_select_member_state.dart';
import 'package:konesp/page/order/regular_select_member/regular_select_member_state.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/custom_slidable.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/equipment_icon.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/sheet/cancel_order_dialog.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';

import 'timer_widget.dart';

// 工单-列表适配器
class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.entity, //数据源
    required this.controller, //页面控制器
    this.isMaintananceGroup = false, //是否维保组相关页面
    this.onResult, //暴露外部刷新回调
  });

  final TaskEntity entity;
  final BaseController controller;
  final bool isMaintananceGroup;
  final Function()? onResult;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(entity.orderType == 1 ? Routes.regularDetail : Routes.fixDetail, arguments: {'id': entity.id!}),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              entity.orderType == 1 ? null : Border.all(color: entity.faultRepairType == 1 ? Colours.darkOrange : Colors.transparent, width: 0.5.w),
          borderRadius: BorderRadius.circular(8.w),
        ),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.w),
          child: CustomSlidable(
            enabled: onResult != null && entity.state == 1 && calculatePermission() > 0,
            endActionPane: ActionPane(
              extentRatio: entity.state == 1 && calculatePermission() > 0 ? calculatePermission() * 0.18 : 0.1, //0.1是随便设置的，这个属性必须有值没办法。
              motion: const BehindMotion(),
              dragDismissible: false,
              children: entity.orderType == 1
                  ? [
                      if (StoreLogic.to.permissions
                          .contains(isMaintananceGroup ? UserPermission.groupAssignTicketPermission : UserPermission.listAssignTicketPermission))
                        CustomSlidableAction(
                          onPressed: (context) async {
                            var memberSelectedEntity = await Get.toNamed(Routes.regularSelectMember, arguments: {
                              'model': RegularMemberSelectedEntity()
                                ..selectedUserId = entity.mainResponseUserId
                                ..selectedUserName = entity.mainResponseUserName
                                ..selectedGroupCode = entity.groupCode
                                ..selectedGroupName = entity.groupName,
                            });
                            if (memberSelectedEntity is RegularMemberSelectedEntity) {
                              //保养工单转派给别人，不需要考虑指定组（目前不支持，只有故障工单可以指定组）
                              Get.dialog(
                                ConfirmDialog(
                                  content:
                                      '${ObjectUtil.isNotEmpty(entity.mainResponseUserName) ? '该工单原主响应人为${entity.mainResponseUserName!}' : '该工单无主响应人'}，确认变更为${memberSelectedEntity.selectedUserName!}？',
                                  onConfirm: () async {
                                    Map _map = {
                                      'id': entity.id,
                                      'transferType': 2,
                                      'responseType': 3,
                                      'groupCode': memberSelectedEntity.selectedGroupCode,
                                      'groupName': memberSelectedEntity.selectedGroupName,
                                      'mainResponseUserId': memberSelectedEntity.selectedUserId!,
                                      'mainResponseUserName': memberSelectedEntity.selectedUserName!
                                    };

                                    _map['mainResponseUserName'] = memberSelectedEntity.selectedUserName!;
                                    controller.showProgress();
                                    final result = await controller.post(Api.transferRegularOrder, params: _map);
                                    if (result.success) {
                                      controller.showToast('转派成功');
                                      onResult?.call();
                                    } else {
                                      controller.showToast(result.msg);
                                    }
                                  },
                                ),
                              );
                            }
                          },
                          backgroundColor: const Color(0xFFF9CC46),
                          padding: EdgeInsets.zero,
                          child: Text(
                            '转派\n工单',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      if ((StoreLogic.to.permissions
                              .intersection(
                                  isMaintananceGroup ? {UserPermission.groupAssignToMePermission} : {UserPermission.listAssignToMePermission})
                              .isNotEmpty) &&
                          entity.mainResponseUserId != StoreLogic.to.getUser()!.id)
                        CustomSlidableAction(
                          onPressed: (context) {
                            if (ObjectUtil.isNotEmpty(entity.mainResponseUserName)) {
                              Get.dialog(
                                ConfirmDialog(
                                  content: '该工单原主响应人为${entity.mainResponseUserName}，你是否想成为该工单的主响应人？',
                                  onConfirm: () => transferRegularOrderToMe(controller, entity.id!, 3),
                                ),
                              );
                            } else {
                              Get.dialog(
                                ConfirmDialog(
                                  content: '该工单无主响应人，你是否想成为该工单的主响应人？',
                                  cancel: '仅响应一次',
                                  confirm: '成为主响应人',
                                  onCancel: () => transferRegularOrderToMe(controller, entity.id!, 1),
                                  onConfirm: () => transferRegularOrderToMe(controller, entity.id!, 2),
                                ),
                              );
                            }
                          },
                          backgroundColor: Colours.darkOrange,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '转派\n给我',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      if (StoreLogic.to.permissions
                          .contains(isMaintananceGroup ? UserPermission.groupCancelTicketPermission : UserPermission.listCancelTicketPermission))
                        CustomSlidableAction(
                          onPressed: (context) {
                            Get.dialog(
                              CancelOrderDialog(
                                onConfirm: (value) async {
                                  controller.showProgress();
                                  final result = await controller.post(
                                    Api.cancelRegularOrder,
                                    params: {'remark': value, 'id': entity.id},
                                  );
                                  if (result.success) {
                                    controller.showToast('取消成功');
                                    onResult?.call();
                                  } else {
                                    controller.showToast(result.msg);
                                  }
                                },
                              ),
                            );
                          },
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '取消\n工单',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                    ]
                  : [
                      if (StoreLogic.to.permissions
                          .contains(isMaintananceGroup ? UserPermission.groupAssignTicketPermission : UserPermission.listAssignTicketPermission))
                        CustomSlidableAction(
                          onPressed: (context) async {
                            var memberSelectedEntity = await Get.toNamed(Routes.fixSelectMember, arguments: {
                              'model': FixMemberSelectedEntity()
                                ..selectedGroupCode = entity.groupCode
                                ..selectedGroupName = entity.groupName
                                ..selectedUserId = entity.mainResponseUserId
                                ..selectedUserName = entity.mainResponseUserName,
                            });
                            if (memberSelectedEntity is FixMemberSelectedEntity) {
                              Get.dialog(
                                ConfirmDialog(
                                  content:
                                      '${ObjectUtil.isNotEmpty(entity.mainResponseUserName) ? '该工单原主响应人为${entity.mainResponseUserName!}' : ObjectUtil.isNotEmpty(entity.groupName) ? '该工单原主响应人为${entity.groupName!}' : '该工单无主响应人'}，确认变更为${memberSelectedEntity.selectedUserId == -1 ? memberSelectedEntity.selectedGroupName! : memberSelectedEntity.selectedUserName!}？',
                                  onConfirm: () async {
                                    Map _map = {
                                      'id': entity.id,
                                      'groupCode': memberSelectedEntity.selectedGroupCode,
                                      'transferToMe': false,
                                    };
                                    if (memberSelectedEntity.selectedUserId! > -1) {
                                      _map['mainResponseUserId'] = memberSelectedEntity.selectedUserId!;
                                    }
                                    controller.showProgress();
                                    final result = await controller.post(Api.transferFixOrder, params: _map);
                                    if (result.success) {
                                      controller.showToast('转派成功');
                                      onResult?.call();
                                    } else {
                                      controller.showToast(result.msg);
                                    }
                                  },
                                ),
                              );
                            }
                          },
                          backgroundColor: const Color(0xFFF9CC46),
                          padding: EdgeInsets.zero,
                          child: Text(
                            '转派\n工单',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      if ((StoreLogic.to.permissions
                              .intersection(
                                  isMaintananceGroup ? {UserPermission.groupAssignToMePermission} : {UserPermission.listAssignToMePermission})
                              .isNotEmpty) &&
                          entity.mainResponseUserId != StoreLogic.to.getUser()!.id)
                        CustomSlidableAction(
                          onPressed: (context) {
                            if (ObjectUtil.isNotEmpty(entity.mainResponseUserName)) {
                              Get.dialog(
                                ConfirmDialog(
                                  content: '该工单原主响应人为${entity.mainResponseUserName}，你是否想成为该工单的主响应人？',
                                  onConfirm: () => transferFixOrderToMe(controller, entity.id!, false),
                                ),
                              );
                            } else {
                              Get.dialog(
                                ConfirmDialog(
                                  content: '该工单无主响应人，你是否想成为该工单的主响应人？',
                                  cancel: '仅响应一次',
                                  confirm: '成为主响应人',
                                  onCancel: () => transferFixOrderToMe(controller, entity.id!, false),
                                  onConfirm: () => transferFixOrderToMe(controller, entity.id!, true),
                                ),
                              );
                            }
                          },
                          backgroundColor: Colours.darkOrange,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '转派\n给我',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      if (StoreLogic.to.permissions
                          .contains(isMaintananceGroup ? UserPermission.groupCancelTicketPermission : UserPermission.listCancelTicketPermission))
                        CustomSlidableAction(
                          onPressed: (context) {
                            Get.dialog(
                              CancelOrderDialog(
                                onConfirm: (value) async {
                                  controller.showProgress();
                                  final result = await controller.post(
                                    Api.cancelFixOrder,
                                    params: {
                                      'id': entity.id,
                                      'cancelReason': value,
                                    },
                                  );
                                  if (result.success) {
                                    controller.showToast('取消成功');
                                    onResult?.call();
                                  } else {
                                    controller.showToast(result.msg);
                                  }
                                },
                              ),
                            );
                          },
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '取消\n工单',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                    ],
            ),
            child: Row(
              children: [
                Container(
                  width: 45.w,
                  height: 45.w,
                  margin: EdgeInsets.only(top: 15.w, bottom: 15.w, left: 10.w),
                  decoration: BoxDecoration(
                    color: Colours.bg,
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  alignment: Alignment.center,
                  child: EquipmentIcon(type: entity.equipmentTypeCode!),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${entity.buildingCode ?? ''} ${entity.elevatorCode ?? ''} | ${entity.equipmentCode}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colours.text_333,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              entity.stateValue,
                              style: TextStyle(
                                color: entity.state == 1
                                    ? Colours.primary
                                    : entity.state == 2
                                        ? Colours.darkOrange
                                        : Colours.text_666,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5.w),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1.sw - 150.w),
                          child: Text(
                            entity.projectName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.w),
                        if (entity.orderType == 1)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${entity.arrangeName ?? ''}·${entity.orderModul ?? ''}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              if (entity.state == 1 && calculatePermission() > 0)
                                LoadSvgImage(
                                  'new_more',
                                  width: 20.w,
                                  color: Colours.text_666,
                                )
                              else if (entity.state == 2 && entity.startTime != null && entity.startTime! < DateUtil.getNowDateMs())
                                TimerWidget(startTime: entity.startTime!),
                            ],
                          )
                        else
                          Row(
                            children: [
                              if (ObjectUtil.isNotEmpty(entity.repairTimeStr))
                                Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: Text(
                                    '报修时间：${DateUtil.formatDateStr(entity.repairTimeStr!, format: DateFormats.ymdhm)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              if (entity.faultRepairType == 1)
                                Container(
                                  width: 30.w,
                                  height: 16.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colours.darkOrange,
                                    borderRadius: BorderRadius.circular(5.w),
                                  ),
                                  child: Text(
                                    '困人',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  width: 30.w,
                                  height: 16.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colours.text_ccc,
                                    borderRadius: BorderRadius.circular(5.w),
                                  ),
                                  child: Text(
                                    '普通',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (entity.state == 1 && calculatePermission() > 0)
                                        LoadSvgImage(
                                          'new_more',
                                          width: 20.w,
                                          color: Colours.text_666,
                                        )
                                      else if (entity.state == 2 && entity.startTime != null && entity.startTime! < DateUtil.getNowDateMs())
                                        TimerWidget(startTime: entity.startTime!),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 转派保养工单给我  响应类型 转派给我的情况下，1响应1次，2成为主保养人，3成为主响应人
  transferRegularOrderToMe(BaseController controller, int orderId, int responseType) async {
    controller.showProgress();
    final result = await controller.post(Api.transferRegularOrder, params: {
      'id': orderId,
      'transferType': 1,
      'responseType': responseType,
    });
    if (result.success) {
      if (responseType == 1) {
        controller.showToast('本次响应成功');
      } else if (responseType == 2) {
        controller.showToast('你已成为该设备主保养人');
      } else {
        controller.showToast('工单主响应人改变成功');
      }
      onResult?.call();
    } else {
      controller.showToast(result.msg);
    }
  }

  /// 转派故障工单给我
  transferFixOrderToMe(BaseController controller, int orderId, bool becomeMainRepairer) async {
    controller.showProgress();
    final result = await controller.post(Api.transferFixOrder, params: {
      'id': orderId,
      'mainResponseUserId': StoreLogic.to.getUser()!.id,
      'becomeMainRepairer': becomeMainRepairer,
      'transferToMe': true,
    });
    if (result.success) {
      if (becomeMainRepairer) {
        controller.showToast('你已成为该设备主维修人');
      } else {
        controller.showToast('工单主响应人改变成功');
      }
      onResult?.call();
    } else {
      controller.showToast(result.msg);
    }
  }

  int calculatePermission() {
    int sum = 0;
    if ((StoreLogic.to.permissions
            .intersection(isMaintananceGroup ? {UserPermission.groupAssignToMePermission} : {UserPermission.listAssignToMePermission})
            .isNotEmpty) &&
        entity.mainResponseUserId != StoreLogic.to.getUser()!.id) {
      sum = sum + 1;
    }
    if (StoreLogic.to.permissions
        .intersection(isMaintananceGroup ? {UserPermission.groupAssignTicketPermission} : {UserPermission.listAssignTicketPermission})
        .isNotEmpty) {
      sum = sum + 1;
    }
    if (StoreLogic.to.permissions
        .intersection(isMaintananceGroup ? {UserPermission.groupCancelTicketPermission} : {UserPermission.listCancelTicketPermission})
        .isNotEmpty) {
      sum = sum + 1;
    }
    return sum;
  }
}
