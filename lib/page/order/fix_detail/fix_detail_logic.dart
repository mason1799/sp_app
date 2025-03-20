import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/device_project_entity.dart';
import 'package:konesp/entity/fix_detail_entity.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/entity/order_rule_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/order/fix_select_member/fix_select_member_state.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/file_util.dart';
import 'package:konesp/util/kfps_util.dart';
import 'package:konesp/util/location_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/oss_util.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/json_data.dart';
import 'package:konesp/widget/sheet/alert_bottom_sheet.dart';
import 'package:konesp/widget/sheet/cancel_order_dialog.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:konesp/widget/sheet/full_time_dialog.dart';
import 'package:konesp/widget/sheet/input_dialog.dart';
import 'package:konesp/widget/sheet/pause_dialog.dart';
import 'package:konesp/widget/sheet/single_dialog.dart';
import 'package:konesp/widget/sheet/three_dimensional/three_dimensional_view.dart';
import 'package:konesp/widget/sheet/two_dimensional/two_dimensional_view.dart';
import 'package:sprintf/sprintf.dart';

import 'fix_detail_state.dart';

class FixDetailLogic extends BaseController {
  final FixDetailState state = FixDetailState();

  @override
  void onReady() {
    query();
    KfpsUtil.initPageLicense();
  }

  @override
  void onClose() {
    state.eventStreamController.close();
    super.onClose();
  }

  Future<void> query() async {
    final result = await get<FixDetailEntity>(
      sprintf(Api.fixOrderDetail, [state.id]),
    );
    if (result.success) {
      state.orderDetail = result.data!;
      initData();
      nextToDo();
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
      update();
    }
  }

  initData() {
    int? _hasMeIndex = state.orderDetail!.assistEmployees?.indexWhere((e) => e.userId == StoreLogic.to.getUser()!.id);
    if (StoreLogic.to.getUser()!.id == state.orderDetail!.mainResponseUserId) {
      state.role = FixOrderRole.mainRespond;
    } else if (_hasMeIndex != null && _hasMeIndex > -1) {
      state.role = FixOrderRole.assist;
    } else {
      state.role = FixOrderRole.other;
    }

    if (state.orderDetail!.orderState == 1) {
      // 未响应->待接单
      state.fixOrderStatus = FixOrderStatus.accept;
    } else if (state.orderDetail!.orderState == 2) {
      // 响应中
      if (state.orderDetail!.flow == 3) {
        // 待签到
        state.fixOrderStatus = FixOrderStatus.checkIn;
      } else if (state.orderDetail!.flow == 4) {
        if (state.role == FixOrderRole.mainRespond) {
          state.fixOrderStatus = FixOrderStatus.checkOut;
        } else {
          state.fixOrderStatus = FixOrderStatus.pause;
        }
      } else if (state.orderDetail!.flow == 5) {
        // 已暂停
        state.fixOrderStatus = FixOrderStatus.pause;
      } else if (state.orderDetail!.flow == 6) {
        // 待签退
        if (state.role == FixOrderRole.mainRespond) {
          state.fixOrderStatus = FixOrderStatus.checkOut;
        } else {
          state.fixOrderStatus = FixOrderStatus.pause;
        }
      } else if (state.orderDetail!.flow == 7) {
        // 待提交
        if (state.role == FixOrderRole.mainRespond) {
          state.fixOrderStatus = FixOrderStatus.commit;
        } else {
          state.fixOrderStatus = FixOrderStatus.pause;
        }
      } else if (state.orderDetail!.flow == 8 || state.orderDetail!.flow == 9) {
        // 待签字
        state.fixOrderStatus = FixOrderStatus.sign;
      }
    } else if (state.orderDetail!.orderState == 3) {
      // 已完成
      state.fixOrderStatus = FixOrderStatus.finish;
    } else {
      // 消息中心进入的比较常见，其他地方已过滤了已取消状态的订单
      state.fixOrderStatus = FixOrderStatus.cancelled;
    }
  }

  nextToDo() async {
    if ([FixOrderStatus.checkIn, FixOrderStatus.checkOut].contains(state.fixOrderStatus)) {
      final result = await post<List<OrderRuleEntity>>(
        Api.getOrderRules,
        params: {'orderType': 2},
      );
      if (result.success) {
        state.orderRules = result.data;
        if (ObjectUtil.isNotEmpty(state.orderRules)) {
          for (OrderRuleEntity element in state.orderRules!) {
            if (element.orderType == 2 && element.ruleKey == RuleKey.checkInDeviation.value && element.enabled == 1 && (element.ruleValue ?? 0) > 0) {
              state.checkInDeviation = element.ruleValue!;
            } else if (element.orderType == 2 &&
                element.ruleKey == RuleKey.checkOutDeviation.value &&
                element.enabled == 1 &&
                (element.ruleValue ?? 0) > 0) {
              state.checkOutDeviation = element.ruleValue!;
            }
          }
        }
      }
      LocationUtil().startLocation(
        onResult: (entity) async {
          double distance = Geolocator.distanceBetween(
            entity.latitude!,
            entity.longitude!,
            state.orderDetail!.latitude ?? 0,
            state.orderDetail!.longitude ?? 0,
          );
          if (state.fixOrderStatus == FixOrderStatus.checkIn) {
            state.orderDetail?.signInLocation = entity.address;
            state.orderDetail?.signInDistance = distance;
          } else {
            state.orderDetail?.signOutLocation = entity.address;
            state.orderDetail?.signOutDistance = distance;
          }
          state.pageStatus = PageStatus.success;
          closeProgress();
          update();
        },
        onError: (code, msg) {
          if (code == 0) {
            Get.dialog(
              ConfirmDialog(
                content: '定位权限未开启，请打开权限',
                confirm: '去设置',
                onConfirm: () async => await Geolocator.openLocationSettings(),
              ),
            );
          }
          state.pageStatus = PageStatus.success;
          closeProgress();
          update();
        },
      );
    } else {
      state.pageStatus = PageStatus.success;
      closeProgress();
      update();
    }
  }

  getLocation() async {
    state.loading = true;
    update(['location']);
    LocationUtil().startLocation(
      onResult: (entity) async {
        double distance = Geolocator.distanceBetween(
          entity.latitude!,
          entity.longitude!,
          state.orderDetail!.latitude ?? 0,
          state.orderDetail!.longitude ?? 0,
        );
        if (state.fixOrderStatus == FixOrderStatus.checkIn) {
          state.orderDetail!.signInLocation = entity.address;
          state.orderDetail!.signInDistance = distance;
        } else {
          state.orderDetail!.signOutLocation = entity.address;
          state.orderDetail!.signOutDistance = distance;
        }
        state.loading = false;
        update(['location']);
      },
      onError: (code, msg) {
        if (code == 0) {
          Get.dialog(
            ConfirmDialog(
              content: '定位权限未开启，请打开权限',
              confirm: '去设置',
              onConfirm: () async => await Geolocator.openLocationSettings(),
            ),
          );
        }
        state.loading = false;
        update(['location']);
      },
    );
  }

  checkIn() async {
    if (ObjectUtil.isEmpty(state.orderDetail!.signInDistance) || state.orderDetail!.signInDistance! <= 0) {
      showToast('签到地址不能为空');
      return;
    }
    if (!await _checkWorkRules()) {
      return;
    }
    String? _path = await FileUtil.takeCamera();
    if (_path == null) {
      return;
    }
    showProgress();
    final uploadResult = await OssUtil.instance.upload(
      _path,
      timeTag: TimeTagFormat.checkIn,
      dict: 'detail',
      isDecorateMark: true,
    );
    if (uploadResult.success) {
      final result = await post(Api.checkInFixOrder, params: {
        'id': state.orderDetail!.id!,
        'signInTime': DateUtil.getNowDateStr(),
        'signInImage': uploadResult.data!.ossKey!,
        'signInLocation': state.orderDetail!.signInLocation!,
        'signInDistance': state.orderDetail!.signInDistance!,
      });
      if (result.success) {
        await query();
        showToast('签到成功');
      } else {
        showToast(result.msg);
      }
    } else {
      showToast(uploadResult.msg);
    }
  }

  checkOut() async {
    if (!checkNecessaryItem()) {
      return;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.signOutDistance) || state.orderDetail!.signOutDistance! <= 0) {
      showToast('签退地址不能为空');
      return;
    }
    if (!await _checkWorkRules()) {
      return;
    }
    String? _path = await FileUtil.takeCamera();
    if (_path == null) {
      return;
    }
    showProgress();
    final uploadResult = await OssUtil.instance.upload(
      _path,
      dict: 'detail',
      timeTag: TimeTagFormat.checkOut,
      isDecorateMark: true,
    );
    if (uploadResult.success) {
      final result = await post(Api.checkOutFixOrder, params: {
        'id': state.orderDetail!.id,
        'signOutTime': DateUtil.getNowDateMs(),
        'signOutImage': uploadResult.data!.ossKey!,
        'signOutLocation': state.orderDetail!.signOutLocation!,
        'signOutDistance': state.orderDetail!.signOutDistance!,
        'equipmentId': state.orderDetail!.equipmentId,
        'faultRepairType': state.orderDetail!.faultRepairType,
        'faultDesc': state.orderDetail!.faultDesc,
        'repairman': state.orderDetail!.repairman,
        'repairRole': state.orderDetail!.repairRole,
        'repairTime': state.orderDetail!.repairTime,
        'repairPhone': state.orderDetail!.repairPhone,
        'arriveEquipmentState': state.orderDetail!.arriveEquipmentState,
        'leaveEquipmentState': state.orderDetail!.leaveEquipmentState,
        'faultCause': state.orderDetail!.faultCause,
        'faultDisposalAction': state.orderDetail!.faultDisposalAction,
        'faultParts': state.orderDetail!.faultParts,
        'signInTime': state.orderDetail!.signInTime!,
        'updateParts': state.orderDetail!.updateParts,
        'updatePartsCount': state.orderDetail!.updatePartsCount,
        'trappedCount': state.orderDetail!.trappedCount,
        'trappedMinutes': state.orderDetail!.trappedMinutes,
        'escapeMode': state.orderDetail!.escapeMode,
        'complaintDetails': state.orderDetail!.complaintDetails,
      });
      if (result.success) {
        await query();
        showToast('签退成功');
      } else {
        showToast(result.msg);
      }
    } else {
      showToast(uploadResult.msg);
    }
  }

  commit() async {
    if (!checkNecessaryItem()) {
      return;
    }
    if (!await _checkWorkRules()) {
      return;
    }
    showProgress();
    final result = await post(Api.submitFixOrder, params: {
      'id': state.orderDetail!.id,
      'equipmentId': state.orderDetail!.equipmentId,
      'faultRepairType': state.orderDetail!.faultRepairType,
      'faultDesc': state.orderDetail!.faultDesc,
      'repairman': state.orderDetail!.repairman,
      'repairRole': state.orderDetail!.repairRole,
      'repairTime': state.orderDetail!.repairTime,
      'repairPhone': state.orderDetail!.repairPhone,
      'arriveEquipmentState': state.orderDetail!.arriveEquipmentState,
      'leaveEquipmentState': state.orderDetail!.leaveEquipmentState,
      'faultCause': state.orderDetail!.faultCause,
      'faultDisposalAction': state.orderDetail!.faultDisposalAction,
      'faultParts': state.orderDetail!.faultParts,
      'updateParts': state.orderDetail!.updateParts,
      'updatePartsCount': state.orderDetail!.updatePartsCount,
      'trappedCount': state.orderDetail!.trappedCount,
      'trappedMinutes': state.orderDetail!.trappedMinutes,
      'escapeMode': state.orderDetail!.escapeMode,
      'complaintDetails': state.orderDetail!.complaintDetails,
    });
    if (result.success) {
      await query();
      showToast('提交成功');
    } else {
      showToast(result.msg);
    }
  }

  sign({required String signImage, required int userid}) async {
    showProgress();
    final result = await post(
      Api.submitFixOrderOneSign,
      params: {
        'orderId': state.orderDetail!.id,
        'signatureImage': signImage,
        'userId': userid,
      },
    );
    if (result.success) {
      await query();
      showToast('签字成功');
    } else {
      showToast(result.msg);
    }
  }

  bool checkNecessaryItem() {
    if (state.orderDetail!.equipmentId == null) {
      showToast('请选择设备');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.faultDesc)) {
      showToast('请输入故障描述');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.repairman)) {
      showToast('请输入报修人姓名');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.repairTime)) {
      showToast('请选择报修时间');
      return false;
    }
    if (state.orderDetail!.repairRole == null) {
      showToast('请选择报修人角色');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.repairPhone)) {
      showToast('请输入报修人电话');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.arriveEquipmentState)) {
      showToast('请输入到达现场设备状况');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.leaveEquipmentState)) {
      showToast('请输入离开现场设备状况');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.faultCause)) {
      showToast('请输入故障原因');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.faultDisposalAction)) {
      showToast('请输入故障处理行动');
      return false;
    }
    if (ObjectUtil.isEmpty(state.orderDetail!.faultParts)) {
      showToast('请输入故障部件');
      return false;
    }
    if (state.orderDetail!.faultRepairType == 1) {
      if (state.orderDetail!.trappedCount == null) {
        showToast('请输入被困人数');
        return false;
      }
      if (state.orderDetail!.trappedMinutes == null) {
        showToast('请输入被困时间');
        return false;
      }
      if (ObjectUtil.isEmpty(state.orderDetail!.escapeMode)) {
        showToast('请输入乘客脱困方式');
        return false;
      }
      if (ObjectUtil.isEmpty(state.orderDetail!.complaintDetails)) {
        showToast('请输入乘客受伤投诉情况');
        return false;
      }
    }
    return true;
  }

  Future<bool> _checkWorkRules() async {
    showProgress();
    final result = await post<List<OrderRuleEntity>>(
      Api.getOrderRules,
      params: {'orderType': 2},
    );
    closeProgress();
    if (result.success) {
      if (state.fixOrderStatus == FixOrderStatus.checkIn) {
        bool _checkResult1 = await _checkByRules(rules: result.data, ruleKey: RuleKey.enableMultiUser);
        if (!_checkResult1) {
          return false;
        }
        bool _checkResult2 = await _checkByRules(rules: result.data, ruleKey: RuleKey.checkInDeviation);
        return _checkResult2;
      } else if (state.fixOrderStatus == FixOrderStatus.checkOut) {
        bool _checkResult1 = await _checkByRules(rules: result.data, ruleKey: RuleKey.checkOutDeviation);
        if (!_checkResult1) {
          return false;
        }
        bool _checkResult2 = await _checkByRules(rules: result.data, ruleKey: RuleKey.workDuration);
        return _checkResult2;
      } else if (state.fixOrderStatus == FixOrderStatus.commit) {
        bool _checkResult = await _checkByRules(rules: result.data, ruleKey: RuleKey.enableMultiUser);
        return _checkResult;
      } else {
        return true;
      }
    } else {
      showToast(result.msg);
      return false;
    }
  }

  // 根据规则校验
  Future<bool> _checkByRules({required List<OrderRuleEntity>? rules, RuleKey ruleKey = RuleKey.checkInDeviation}) async {
    if (ObjectUtil.isNotEmpty(rules)) {
      final orderRuleEntity = rules!.firstWhereOrNull(
          (element) => element.orderType == 2 && element.ruleKey == ruleKey.value && element.enabled == 1 && (element.ruleValue ?? 0) > 0);
      if (orderRuleEntity != null) {
        if (ruleKey == RuleKey.checkInDeviation) {
          if ((state.orderDetail!.signInDistance ?? 0) > orderRuleEntity.ruleValue!) {
            showToast('您当前位置不在签到范围内，请前往指定地点签到');
            return false;
          }
        } else if (ruleKey == RuleKey.checkOutDeviation) {
          if ((state.orderDetail!.signOutDistance ?? 0) > orderRuleEntity.ruleValue!) {
            showToast('您当前位置不在签退范围内，请前往指定地点签退');
            return false;
          }
        } else if (ruleKey == RuleKey.workDuration) {
          if (ObjectUtil.isEmpty(state.orderDetail!.signInTime)) {
            showToast('签到时间获取失败，请重试');
            return false;
          } else if ((DateUtil.getNowDateMs() - DateUtil.getDateMsByTimeStr(state.orderDetail!.signInTime!)!) <
              orderRuleEntity.ruleValue! * 60 * 1000) {
            showToast('您当前⼯作时⻓未达标，⼯作时⻓⼩于${orderRuleEntity.ruleValue!}分钟，不允许签退');
            return false;
          }
        } else if (ruleKey == RuleKey.enableMultiUser) {
          if (orderRuleEntity.ruleValue == 1 && ObjectUtil.isEmpty(state.orderDetail!.assistEmployees)) {
            Get.dialog(
              ConfirmDialog(
                content: '请至少添加一位辅助人员完成维保任务',
                isSingleButton: true,
              ),
            );
            return false;
          }
        }
      }
    }
    return true;
  }

  resume() async {
    showProgress();
    final result = await post(Api.resumeFixOrder, params: {'id': state.orderDetail!.id});
    if (result.success) {
      await query();
      showToast('恢复工单成功');
    } else {
      showToast(result.msg);
    }
  }

  accept() {
    if (state.orderDetail?.mainResponseUserId == StoreLogic.to.getUser()!.id) {
      acceptToDo();
    } else {
      Get.dialog(
        ConfirmDialog(
          content:
              '${ObjectUtil.isNotEmpty(state.orderDetail!.mainResponseUserName) ? '该工单原主响应人为${state.orderDetail!.mainResponseUserName!}' : '该工单无主响应人'}，你是否想成为该工单的主响应人？',
          onConfirm: acceptToDo,
        ),
      );
    }
  }

  acceptToDo() async {
    showProgress();
    final result = await post(
      Api.acceptFixOrder,
      params: {'id': state.orderDetail!.id},
    );
    if (result.success) {
      await query();
      showToast('接单成功');
    } else {
      showToast(result.msg);
    }
  }

  selectFaultParts() {
    Get.focusScope?.unfocus();
    Get.bottomSheet(
      ThreeDimensionalPage(
        title: state.orderDetail!.equipmentType != 2 ? '故障部件(直梯)' : '故障部件(扶梯)',
        data: state.orderDetail!.equipmentType != 2 ? failurePartForElevator : failurePartForEscalator,
        selected: state.orderDetail!.faultParts,
        resultData: (firstValue, secondValue, thirdValue) {
          state.orderDetail?.faultParts = '$firstValue/$secondValue/$thirdValue';
          update(['faultParts']);
        },
      ),
    );
  }

  toProcess() {
    Get.toNamed(Routes.process, arguments: {'type': 1, 'id': state.orderDetail!.id});
  }

  sheetAction() {
    Get.focusScope?.unfocus();
    List<String> items = ['重置工单'];
    if (state.fixOrderStatus == FixOrderStatus.checkOut) {
      items.add('调整签到时间');
    } else if (state.fixOrderStatus == FixOrderStatus.commit) {
      items.add('调整签到时间');
      items.add('调整签退时间');
    }
    showAlertBottomSheet(items,  (data, index) {
      if (data == '重置工单') {
        Get.dialog(
          ConfirmDialog(
            cancel: '重置工单',
            confirm: '取消',
            content: '确定重置工单吗？所有输入的内容将被清空',
            onCancel: () async {
              showProgress();
              final result = await post(Api.resetFixOrder, params: {'id': state.orderDetail!.id});
              closeProgress();
              if (result.success) {
                await query();
                showToast('重置成功');
              } else {
                showToast(result.msg);
              }
            },
          ),
        );
      } else if (data == '调整签到时间') {
        DatePicker.showDateTimePicker(
          Get.context!,
          currentTime: DateUtil.getDateTime(state.orderDetail!.signInTime) ?? DateTime.now(),
          maxTime: DateTime.now(),
          showTitleActions: true,
          locale: LocaleType.zh,
          onConfirm: (time) async {
            showProgress();
            final result = await post(Api.adjustFixOrderCheckIn, params: {
              'id': state.orderDetail!.id,
              'signInTime': DateUtil.formatDate(time),
            });
            closeProgress();
            if (result.success) {
              showToast('调整签到时间成功');
            } else {
              showToast(result.msg);
            }
          },
        );
      } else if (data == '调整签退时间') {
        DatePicker.showDateTimePicker(
          Get.context!,
          currentTime: DateUtil.getDateTime(state.orderDetail!.repairTime) ?? DateTime.now(),
          maxTime: DateTime.now(),
          showTitleActions: true,
          locale: LocaleType.zh,
          onConfirm: (time) async {
            showProgress();
            final result = await post(
              Api.adjustFixOrderCheckOut,
              params: {
                'id': state.orderDetail!.id,
                'signOutTime': DateUtil.formatDate(time),
              },
            );
            closeProgress();
            if (result.success) {
              showToast('调整签退时间成功');
            } else {
              showToast(result.msg);
            }
          },
        );
      }
    });
  }

  toEditAssist() async {
    var employees = await Get.toNamed(
      Routes.memberAssist,
      arguments: {
        'groupCode': state.orderDetail!.groupCode,
        'removeUserId': state.orderDetail!.mainResponseUserId,
        'members': state.orderDetail!.assistEmployees
            ?.map((e) => MainResponseMember(id: e.userId, username: e.username, phone: e.phone, employeeCode: e.employeeCode))
            .toList(),
      },
    );
    if (employees is List<MainResponseMember>) {
      showProgress();
      final result = await post(Api.saveFixOrderAssists, params: {
        'id': state.orderDetail!.id,
        'helperUserIds': employees.isNotEmpty ? employees.map((e) => e.id ?? 0).toList() : [],
      });
      closeProgress();
      if (result.success) {
        state.orderDetail!.assistEmployees = employees
            .map((e) => FixDetailAssistEmployee()
              ..employeeCode = e.employeeCode
              ..userId = e.id
              ..username = e.username
              ..phone = e.phone)
            .toList();
        update(['assist']);
        showToast('调整成功');
      } else {
        showToast(result.msg);
      }
    }
  }

  pause() {
    if (checkNecessaryItem()) {
      Get.focusScope?.unfocus();
      Get.bottomSheet(
        PauseDialog(
          onConfirm: (pauseTime, pauseStatus) async{
            showProgress();
            final result = await post(Api.pauseFixOrder, params: {
              'id': state.orderDetail!.id,
              'pauseTime': pauseTime,
              'pauseEquipmentState': pauseStatus,
              'equipmentId': state.orderDetail!.equipmentId,
              'faultRepairType': state.orderDetail!.faultRepairType,
              'faultDesc': state.orderDetail!.faultDesc,
              'repairman': state.orderDetail!.repairman,
              'repairRole': state.orderDetail!.repairRole,
              'repairTime': state.orderDetail!.repairTime,
              'repairPhone': state.orderDetail!.repairPhone,
              'arriveEquipmentState': state.orderDetail!.arriveEquipmentState,
              'leaveEquipmentState': state.orderDetail!.leaveEquipmentState,
              'faultCause': state.orderDetail!.faultCause,
              'faultDisposalAction': state.orderDetail!.faultDisposalAction,
              'faultParts': state.orderDetail!.faultParts,
              'updateParts': state.orderDetail!.updateParts,
              'updatePartsCount': state.orderDetail!.updatePartsCount,
              'trappedCount': state.orderDetail!.trappedCount,
              'trappedMinutes': state.orderDetail!.trappedMinutes,
              'escapeMode': state.orderDetail!.escapeMode,
              'complaintDetails': state.orderDetail!.complaintDetails,
              'helperUserIds': state.orderDetail!.assistEmployees?.map((e) => e.userId.toString()).toList(),
            });
            if (result.success) {
              await query();
              showToast('暂停工单成功');
            } else {
              showToast(result.msg);
            }
          },
        ),
      );
    }
  }

  selectDevice() async {
    var device = await Get.toNamed(Routes.deviceSelect, arguments: DeviceProjectEquipmentInfoList()..id = state.orderDetail!.equipmentId);
    if (device != null) {
      _updateEquipmentAndProject(device);
      update(['device']);
    }
  }

  _updateEquipmentAndProject(DeviceProjectEquipmentInfoList deviceItemEntity) {
    state.orderDetail!.projectName = deviceItemEntity.projectName;
    state.orderDetail!.projectLocation = deviceItemEntity.projectLocation;
    state.orderDetail!.buildingCode = deviceItemEntity.buildingCode;
    state.orderDetail!.elevatorCode = deviceItemEntity.elevatorCode;
    state.orderDetail!.equipmentId = deviceItemEntity.id;
    state.orderDetail!.equipmentCode = deviceItemEntity.equipmentCode;
    state.orderDetail!.equipmentType = deviceItemEntity.equipmentType;
    state.orderDetail!.equipmentTypeName = deviceItemEntity.equipmentTypeName;
    if (state.orderDetail!.equipmentType != 2) {
      state.orderDetail!.faultParts = null;
    }
  }

  selectArriveEquipmentState() {
    Get.focusScope?.unfocus();
    Get.bottomSheet(
      TwoDimensionalPage(
        title: state.orderDetail!.equipmentType != 2 ? '现场设备状况(直梯)' : '现场设备状况(扶梯)',
        data: state.orderDetail!.equipmentType != 2 ? currentDeviceStateForElevator : currentDeviceStateForEscalator,
        selected: state.orderDetail!.arriveEquipmentState,
        resultData: (firstValue, secondValue) {
          state.orderDetail?.arriveEquipmentState = '$firstValue/$secondValue';
          update(['arriveEquipmentState']);
        },
      ),
    );
  }

  selectLeaveEquipmentState() {
    Get.focusScope?.unfocus();
    const leaveDeviceState = ['正常运行', '可运行，未完全修复', '停止运行'];
    int _index = state.orderDetail!.leaveEquipmentState == null ? -1 : leaveDeviceState.indexOf(state.orderDetail!.leaveEquipmentState!);
    Get.bottomSheet(
      SingleDialog(
        title: '离开现场设备状况',
        initialIndex: _index > -1 ? _index : 0,
        resultData: (index, value) async {
          state.orderDetail!.leaveEquipmentState = value;
          update(['leaveEquipmentState']);
        },
        data: leaveDeviceState,
      ),
    );
  }

  selectFaultCause() {
    Get.focusScope?.unfocus();
    Get.bottomSheet(
      TwoDimensionalPage(
        title: state.orderDetail!.equipmentType != 2 ? '故障原因(直梯)' : '故障原因(扶梯)',
        data: state.orderDetail!.equipmentType != 2 ? failureReasonForElevator : failureReasonForEscalator,
        selected: state.orderDetail!.faultCause,
        resultData: (firstValue, secondValue) {
          state.orderDetail!.faultCause = '$firstValue/$secondValue';
          update(['faultCause']);
        },
      ),
    );
  }

  selectFaultDisposalAction() {
    Get.focusScope?.unfocus();
    const failureFix = ['清洁/润滑', '操作检查', '更换', '修理', '调校/重置', '其它'];
    int _index = state.orderDetail!.faultDisposalAction == null ? -1 : failureFix.indexOf(state.orderDetail!.faultDisposalAction!);
    Get.bottomSheet(
      SingleDialog(
        title: '故障处理行动',
        initialIndex: _index > -1 ? _index : 0,
        resultData: (index, value) async {
          state.orderDetail!.faultDisposalAction = value;
          update(['faultDisposalAction']);
        },
        data: failureFix,
      ),
    );
  }

  selectFaultRepairType(bool isNormal) {
    if (!isNormal && [2, 5].contains(state.orderDetail!.equipmentType)) {
      /// 自动扶梯或者杂物电梯不能切换到困人情况
      state.orderDetail!.faultRepairType = 2;
      showToast('扶梯或者杂物电梯不存在困人情况');
    } else {
      state.orderDetail!.faultRepairType = (isNormal ? 2 : 1);
    }
    update(['faultRepairType']);
  }

  selectRepairTime() {
    Get.focusScope?.unfocus();
    Get.bottomSheet(
      FullTimeDialog(
        title: '报修时间',
        initialDateTime: DateUtil.getDateTime(state.orderDetail!.repairTime) ?? DateTime.now(),
        onResult: (dateTime) {
          state.orderDetail!.repairTime = DateUtil.formatDate(dateTime);
          update(['repairTime']);
        },
      ),
    );
  }

  selectRepairMan() {
    Get.focusScope?.unfocus();
    Get.dialog(
      InputDialog(
        title: '报修人姓名',
        onSave: (value) {
          state.orderDetail!.repairman = value;
          update(['repairMan']);
        },
        initialValue: state.orderDetail!.repairman,
      ),
    );
  }

  selectRepairRole() {
    Get.focusScope?.unfocus();
    const reportRole = ['业主', '乘客', '甲方或物业工作人员', '维保员工', '其他'];
    int _index = state.orderDetail!.repairRoleName == null ? -1 : reportRole.indexOf(state.orderDetail!.repairRoleName!);
    Get.bottomSheet(
      SingleDialog(
        title: '报修人角色',
        initialIndex: _index > -1 ? _index : 0,
        resultData: (index, value) async {
          state.orderDetail!.repairRole = index + 1;
          update(['repairRole']);
        },
        data: reportRole,
      ),
    );
  }

  selectRepairPhone() {
    Get.focusScope?.unfocus();
    Get.dialog(
      InputDialog(
        title: '报修人电话',
        onSave: (value) {
          state.orderDetail!.repairPhone = value;
          update(['repairPhone']);
        },
        initialValue: state.orderDetail!.repairPhone,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(15), FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  selectUpdateParts() {
    Get.focusScope?.unfocus();
    Get.dialog(
      InputDialog(
        title: '更换部件名称',
        onSave: (value) {
          state.orderDetail!.updateParts = value;
          update(['updateParts']);
        },
        initialValue: state.orderDetail!.updateParts,
      ),
    );
  }

  selectEscapeMode() {
    Get.focusScope?.unfocus();
    const passengerEscapeMethod = ['维保员工解救脱困', '甲方物业工作人员解救脱困', '乘客自行脱困', '其他'];
    int _index = state.orderDetail!.escapeMode == null ? -1 : passengerEscapeMethod.indexOf(state.orderDetail!.escapeMode!);
    Get.bottomSheet(
      SingleDialog(
        title: '乘客脱困方式',
        initialIndex: _index > -1 ? _index : 0,
        resultData: (index, value) {
          state.orderDetail!.escapeMode = value;
          update(['escapeMode']);
        },
        data: passengerEscapeMethod,
      ),
    );
  }

  selectCompaintDetails() {
    Get.focusScope?.unfocus();
    const passengerComplaint = ['乘客受伤，安抚后有投诉风险', '乘客受伤，已安抚无投诉风险', '乘客未受伤，安抚后有投诉风险', '乘客未受伤，安抚后无投诉风险'];
    int _index = state.orderDetail!.complaintDetails == null ? -1 : passengerComplaint.indexOf(state.orderDetail!.complaintDetails!);
    Get.bottomSheet(
      SingleDialog(
        title: '乘客受伤投诉情况',
        initialIndex: _index > -1 ? _index : 0,
        resultData: (index, value) async {
          state.orderDetail!.complaintDetails = value;
          update(['complaintDetails']);
        },
        data: passengerComplaint,
      ),
    );
  }

  toRemark({bool isEnableEdit = false}) {
    Get.toNamed(Routes.remark, arguments: {
      'id': state.orderDetail!.id,
      'type': 1,
      'content': state.orderDetail!.remark,
      'imagePic': state.orderDetail!.remarkImages?.join(','),
      'enableEdit': isEnableEdit,
    });
  }

  assistNotSigns() {
    showAlertBottomSheet(['辅助人员签字'], (data, index) {
      var list = state.orderDetail!.assistEmployees
          ?.where((element) => element.signatureImage == null || element.signatureImage!.isEmpty)
          .map((e) => MainResponseMember()
            ..employeeCode = e.employeeCode
            ..username = e.username
            ..id = e.userId
            ..phone = e.phone)
          .toList();
      Get.toNamed(Routes.assistNotSigns, arguments: {
        'list': list,
        'signatureImage': state.orderDetail!.signatureImage,
        'type': 2,
      });
    });
  }

  orderAction() {
    Get.focusScope?.unfocus();
    List<String> items = [];
    if (StoreLogic.to.permissions.contains(UserPermission.detailAssignTicketPermission)) {
      items.add('转派工单');
    }
    if (StoreLogic.to.permissions.contains(UserPermission.detailCancelTicketPermission)) {
      items.add('取消工单');
    }
    if (items.isNotEmpty) {
      showAlertBottomSheet(items, (data, index) async {
        if (data == '转派工单') {
          var memberSelectedEntity = await Get.toNamed(Routes.fixSelectMember, arguments: {
            'model': FixMemberSelectedEntity()
              ..selectedGroupCode = state.orderDetail!.groupCode
              ..selectedGroupName = state.orderDetail!.groupName
              ..selectedUserId = state.orderDetail!.mainResponseUserId
              ..selectedUserName = state.orderDetail!.mainResponseUserName,
          });
          if (memberSelectedEntity is FixMemberSelectedEntity) {
            showProgress();
            Map _map = {
              'id': state.orderDetail!.id,
              'groupCode': memberSelectedEntity.selectedGroupCode,
              'transferToMe': false,
            };
            if (memberSelectedEntity.selectedUserId! > -1) {
              _map['mainResponseUserId'] = memberSelectedEntity.selectedUserId!;
            }
            final result = await post(Api.transferFixOrder, params: _map);
            if (result.success) {
              await query();
              showToast('转派成功');
            } else {
              showToast(result.msg);
            }
          }
        } else if (data == '取消工单') {
          Get.dialog(
            CancelOrderDialog(
              onConfirm: (value) async {
                showProgress();
                final result = await post(Api.cancelFixOrder, params: {
                  'id': state.orderDetail!.id,
                  'cancelReason': value,
                });
                if (result.success) {
                  showToast('取消成功');
                  Get.back();
                } else {
                  showToast(result.msg);
                }
              },
            ),
          );
        }
      });
    }
  }

  setRemarkData(String remarkText, List<String> list) {
    state.orderDetail!.remark = remarkText;
    state.orderDetail!.remarkImages = list;
    update(['remark']);
  }

  toKfps() {
    if (state.fixOrderStatus == FixOrderStatus.checkIn) {
      Get.dialog(
        ConfirmDialog(
          content: '完成签到后，方可访问设备空间。请先进行签到操作。',
          confirm: '知道了',
          isSingleButton: true,
        ),
      );
    } else {
      KfpsUtil.jumpPage(
        orderNumber: state.orderDetail!.orderNumber!,
        equipmentCode: state.orderDetail!.equipmentCode!,
        projectName: state.orderDetail!.projectName,
      );
    }
  }
}
