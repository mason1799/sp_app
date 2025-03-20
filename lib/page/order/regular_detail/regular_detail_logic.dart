import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/entity/order_rule_entity.dart';
import 'package:konesp/entity/over_time_entity.dart';
import 'package:konesp/entity/regular_detail_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/order/regular_select_member/regular_select_member_state.dart';
import 'package:konesp/res/colors.dart';
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
import 'package:konesp/widget/sheet/adjust_dialog.dart';
import 'package:konesp/widget/sheet/alert_bottom_sheet.dart';
import 'package:konesp/widget/sheet/cancel_order_dialog.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:konesp/widget/sheet/hm_time_dialog.dart';
import 'package:konesp/widget/sheet/operate_dialog.dart';
import 'package:sprintf/sprintf.dart';

import 'regular_detail_state.dart';

class RegularDetailLogic extends BaseController {
  final RegularDetailState state = RegularDetailState();

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
    final result = await get<RegularDetailEntity>(
      sprintf(Api.regularOrderDetail, [state.id]),
    );
    if (result.success) {
      state.orderDetail = result.data!;
      state.pageStatus = PageStatus.success;
      if (showUnderCheckIn() || showUnderCheckOut()) {
        nextToDo();
      } else {
        closeProgress();
        update();
      }
    } else {
      showToast(result.msg);
      if (state.orderDetail == null) {
        state.pageStatus = PageStatus.error;
        update();
      }
    }
  }

  String? getBtnText() {
    if (isAheadReply()) {
      return '提前回复';
    } else if (showUnderCheckIn()) {
      return '签到';
    } else if (isResponding()) {
      if (state.orderDetail!.stepState == null || state.orderDetail!.stepState == 1 || !checkCountState()) {
        return '继续检查';
      } else if (state.orderDetail!.stepState == 2 && checkCountState()) {
        return '签退';
      } else if (state.orderDetail!.stepState == 3) {
        return '提交工单';
      } else if ([4, 5].contains(state.orderDetail!.stepState)) {
        return '签字';
      }
    }
    return null;
  }

  bool checkCountState() {
    return state.orderDetail!.checkTotalNum == state.orderDetail!.totalNum;
  }

  String getTips() {
    if (isUnResponse()) {
      return '当前工单未响应';
    }
    if (isResponding()) {
      if (state.orderDetail!.stepState == 3) {
        return '响应中：工单待提交';
      } else if (state.orderDetail!.stepState == 4) {
        return '响应中：主响应人、辅助人员未签字';
      } else if (state.orderDetail!.stepState == 5) {
        return "你已成功提交工单，当${getSignName() ?? ''}签字后工单状态将自动转变为完成";
      }
      return '当前工单正在响应中…';
    }
    if (isFinish()) {
      return '已完成';
    }
    return '';
  }

  String? getTipsIcon() {
    if (isUnResponse()) {
      return 'tip_icon';
    }
    if (isResponding()) {
      if (state.orderDetail!.stepState == 4 || state.orderDetail!.stepState == 5 || state.orderDetail!.stepState == 6) {
        return 'warn_icon';
      }
      return 'loading_icon';
    }
    if (isFinish()) {
      return 'finish_icon';
    }
    return null;
  }

  bool showPostCommit() {
    return [4, 5, 6, 9].contains(state.orderDetail!.stepState);
  }

  bool showUnderCheckIn() {
    return state.orderDetail!.state == 1 && state.orderDetail!.stepState == null;
  }

  bool showUnderCheckOut() {
    return state.orderDetail!.state == 2 && state.orderDetail!.stepState == 2;
  }

  //当前‘继续检查’
  bool showUnderContinueCheck() {
    return state.orderDetail!.state == 2 && state.orderDetail!.stepState == 1;
  }

  bool showUnderCommit() {
    return state.orderDetail!.state == 2 && state.orderDetail!.stepState == 3;
  }

  bool isShowButtonFin() {
    return (isShowButton() && !isAssist() && signSpecial(state.orderDetail!.mainResponseUserCode)) ||
        isAheadReply() ||
        (isShowButton() && showPostCommit() && isAssist() && !containsSignInfo());
  }

  //已响应的工单：主管，同组人只能查看
  bool isReadOnlyDetail() {
    return ((state.orderDetail!.mainResponseUserCode != null && state.orderDetail!.mainResponseUserCode != StoreLogic.to.getUser()?.employeeCode) &&
        state.orderDetail!.state != 1);
  }

  bool signSpecial(String? code) {
    if (state.orderDetail!.signatureImage != null && code != null) {
      return !state.orderDetail!.signatureImage!.contains(code);
    }
    return state.orderDetail!.stepState != 5;
  }

  bool alreadySign() {
    if (state.orderDetail!.signatureImage != null && state.orderDetail!.mainResponseUserCode != null) {
      return !state.orderDetail!.signatureImage!.contains(state.orderDetail!.mainResponseUserCode!);
    }
    return true;
  }

  // 是否存在辅助人员未签字的情况
  bool isExistAssistNotSigned() {
    if (ObjectUtil.isNotEmpty(state.orderDetail!.signatureImage) && ObjectUtil.isNotEmpty(state.orderDetail!.assistEmployeeArr)) {
      bool _isExist = false;
      for (final entity in state.orderDetail!.assistEmployeeArr!) {
        if (!state.orderDetail!.signatureImage!.contains(entity.employeeCode ?? 'EmployeeCode')) {
          _isExist = true;
          break;
        }
      }
      return _isExist;
    }
    return false;
  }

  bool containsSignInfo() {
    String code = StoreLogic.to.getUser()?.employeeCode ?? 'owner';
    String? sign = state.orderDetail!.signatureImage;
    return sign != null && sign != '' && sign.contains(code);
  }

  bool isCheckIn() {
    return [null, 1, 2, 3].contains(state.orderDetail!.stepState);
  }

  bool isCheckOut() {
    return state.orderDetail!.stepState != null && state.orderDetail!.stepState == 3;
  }

  void commitOverTime({required int adjustType}) async {
    Map<String, dynamic> map = {};
    map['adjustType'] = adjustType;
    map['dataType'] = 1;
    map['adjustOrderList'] = [
      {
        'id': state.orderDetail!.id,
        'adjustTaskDate': DateUtil.formatDate(DateTime.now(), format: DateFormats.ymd),
      }
    ];
    showProgress();
    final result = await post<OverTimeEntity>(Api.checkRegularOrderOverTime, params: map);
    closeProgress();
    if (result.success) {
      OverTimeEntity? _overTimeEntity = result.data;
      if (_overTimeEntity != null && ObjectUtil.isNotEmpty(result.data!.adjustOrderList)) {
        if (_overTimeEntity.adjustOrderList![0].overdue == true) {
          Get.toNamed(Routes.overTime, arguments: {'id': state.orderDetail!.id, 'entity': _overTimeEntity});
        } else {
          showProgress();
          final insertResult = await post(
            Api.insertRegularOrderAdjustment,
            params: {
              'adjustType': adjustType,
              'dataType': 1,
              'adjustOrderList': [
                {
                  'id': state.orderDetail!.id,
                  'adjustTaskDate': DateUtil.formatDate(DateTime.now(), format: DateFormats.ymd),
                  'overdue': false,
                  'adjustMainResponseUserId': StoreLogic.to.getUser()!.id,
                  'adjustMainResponseUserName': StoreLogic.to.getUser()!.username
                }
              ],
            },
          );
          closeProgress();
          if (insertResult.success) {
            await query();
            showToast('提前回复成功');
          } else {
            showToast(insertResult.msg);
          }
        }
      } else {
        showToast('数据返回错误');
      }
    } else {
      showToast(result.msg);
    }
  }

  Color getTipsColor() {
    if (isUnResponse()) {
      return Colours.secondary;
    }
    if (isResponding()) {
      return Color(0xFFFFF4E8);
    }
    if (isFinish()) {
      return Color(0xffE5FFF9);
    }
    return Colours.secondary;
  }

  Color getTxtColor() {
    if (isUnResponse()) {
      return Colours.primary;
    }
    if (isResponding()) {
      return Color(0xFFF98600);
    }
    if (isFinish()) {
      return Color(0xff00BA34);
    }
    return Colours.primary;
  }

  bool isUnResponse() {
    return state.orderDetail!.state == 1;
  }

  bool isResponding() {
    return state.orderDetail!.state == 2;
  }

  bool isFinish() {
    return state.orderDetail!.state == 3;
  }

  bool isAssist() {
    return state.orderDetail!.assist != null && state.orderDetail!.assist == true;
  }

  bool isAheadReply() {
    return state.orderDetail!.aheadReply != null && state.orderDetail!.aheadReply == true;
  }

  bool isShowButton() {
    return isUnResponse() || isResponding();
  }

  String replaceSymbol(String? str) {
    if (ObjectUtil.isNotEmpty(str)) {
      return str!.replaceAll(',', '、');
    }
    return '';
  }

  void nextToDo() async {
    final result = await post<List<OrderRuleEntity>>(
      Api.getOrderRules,
      params: {'orderType': 1},
    );
    if (result.success) {
      state.orderRules = result.data;
      if (ObjectUtil.isNotEmpty(state.orderRules)) {
        for (OrderRuleEntity element in state.orderRules!) {
          if (element.ruleKey == RuleKey.checkInDeviation.value && element.enabled == 1 && (element.ruleValue ?? 0) > 0) {
            state.checkInDeviation = element.ruleValue!;
          } else if (element.ruleKey == RuleKey.checkOutDeviation.value && element.enabled == 1 && (element.ruleValue ?? 0) > 0) {
            state.checkOutDeviation = element.ruleValue!;
          }
        }
      }
    }
    LocationUtil().startLocation(
      onResult: (entity) {
        double _distance = Geolocator.distanceBetween(
          entity.latitude!,
          entity.longitude!,
          state.orderDetail!.latitude ?? 0,
          state.orderDetail!.longitude ?? 0,
        );
        if (showUnderCheckIn()) {
          state.startLocation = entity.address;
          state.startDistance = _distance;
          state.startCoordinates = '${entity.longitude!},${entity.latitude!}';
        } else if (showUnderCheckOut()) {
          state.endLocation = entity.address;
          state.endDistance = _distance;
          state.endCoordinates = '${entity.longitude!},${entity.latitude!}';
        }
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
        closeProgress();
        update();
      },
    );
  }

  void getLocation() async {
    state.loading = true;
    update(['location']);
    LocationUtil().startLocation(
      onResult: (entity) async {
        double _distance = Geolocator.distanceBetween(
          entity.latitude!,
          entity.longitude!,
          state.orderDetail!.latitude ?? 0,
          state.orderDetail!.longitude ?? 0,
        );
        if (showUnderCheckIn()) {
          state.startLocation = entity.address;
          state.startDistance = _distance;
          state.startCoordinates = '${entity.longitude!},${entity.latitude!}';
        } else if (showUnderCheckOut()) {
          state.endLocation = entity.address;
          state.endDistance = _distance;
          state.endCoordinates = '${entity.longitude!},${entity.latitude!}';
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

  void commitSign({required String signImage}) async {
    showProgress();
    final result = await post(
      Api.submitRegularOrderOneSign,
      params: {'id': state.orderDetail!.id, 'signatureImage': signImage},
    );
    if (result.success) {
      await query();
      showToast('签字成功');
    } else {
      showToast(result.msg);
    }
  }

  // 提交工单
  void commit() async {
    if (!await _checkWorkRules()) {
      return;
    }
    showProgress();
    final result = await post(Api.submitRegularOrder, params: {'id': state.orderDetail!.id!});
    if (result.success) {
      final stuffsBox = await Hive.openBox(Constant.stuffsBox);
      await stuffsBox.delete('${state.orderDetail!.id!}');
      await query();
      showToast('提交成功');
    } else {
      showToast(result.msg);
    }
  }

  Future<void> changeCheckOutTime(DateTime date) async {
    if (date.millisecondsSinceEpoch < (state.orderDetail!.startTime ?? 0)) {
      showToast('签退时间必须晚于签到时间');
      return;
    }
    showProgress();
    final result = await post(
      Api.adjustRegularOrderCheckOut,
      params: {
        'id': state.orderDetail!.id!,
        'endTime': DateUtil.formatDate(date),
      },
    );
    if (result.success) {
      await query();
      showToast('修改签退时间成功');
    } else {
      showToast(result.msg);
    }
  }

  Future<void> changeCheckInTime(DateTime date) async {
    if (date.millisecondsSinceEpoch > DateUtil.getNowDateMs()) {
      showToast('签到时间不能超过当前时间');
      return;
    }
    if ((state.orderDetail!.endTime ?? 0) > 0 && date.millisecondsSinceEpoch > state.orderDetail!.endTime!) {
      showToast('签到时间不能超过签退时间');
      return;
    }
    showProgress();
    final result = await post(Api.adjustRegularOrderCheckIn, params: {
      'id': state.orderDetail!.id!,
      'startTime': DateUtil.formatDate(date),
    });
    if (result.success) {
      await query();
      showToast('修改签到时间成功');
    } else {
      showToast(result.msg);
    }
  }

  String convertSignData(bool isName) {
    String? sign = state.orderDetail!.signatureImage;
    List<MainResponseMember>? assists = state.orderDetail!.assistEmployeeArr;
    StringBuffer bufferName = StringBuffer();
    StringBuffer bufferImage = StringBuffer();
    StringBuffer bufferCode = StringBuffer();

    if (sign != null && sign != '') {
      try {
        var map = jsonDecode(sign);
        String owner = state.orderDetail!.mainResponseUserCode ?? 'owner';
        if (!bufferCode.toString().contains(owner) && !alreadySign()) {
          bufferName.write(state.orderDetail!.mainResponseUserName);
          bufferName.write('、');
          bufferCode.write(owner);
          bufferCode.write('、');
          bufferImage.write(map[owner]);
          bufferImage.write('、');
        }
        assists?.forEach((element) {
          if (map[element.employeeCode] != null) {
            bufferName.write(element.username);
            bufferName.write('、');
            bufferCode.write(element.employeeCode);
            bufferCode.write('、');
            bufferImage.write(map[element.employeeCode]);
            bufferImage.write('、');
          }
        });
        if (ObjectUtil.isNotEmpty(state.orderDetail!.safetyOfficerSignatureImage)&&ObjectUtil.isNotEmpty(state.orderDetail!.safetyOfficerApprovalBy)) {
          bufferImage.write(state.orderDetail!.safetyOfficerSignatureImage);
          bufferImage.write('、');
          bufferName.write(state.orderDetail!.safetyOfficerApprovalBy);
          bufferName.write('、');
        }
        if (ObjectUtil.isNotEmpty(state.orderDetail!.clientSignatureImage)&&ObjectUtil.isNotEmpty(state.orderDetail!.clientApprovalBy)) {
          bufferImage.write(state.orderDetail!.clientSignatureImage);
          bufferImage.write('、');
          bufferName.write(state.orderDetail!.clientApprovalBy);
          bufferName.write('、');
        }
      } catch (e) {
        return '';
      }
    }
    if (isName && bufferName.toString() != '') {
      return bufferName.toString().substring(0, bufferName.length - 1);
    } else if (!isName && bufferImage.toString() != '') {
      return bufferImage.toString().substring(0, bufferImage.length - 1);
    } else {
      return '';
    }
  }

  List<String> signedImages() {
    List<String> list = [];
    String pics = convertSignData(false);
    if (ObjectUtil.isNotEmpty(pics) && ObjectUtil.isNotEmpty(pics.split('、'))) {
      list = pics.split('、');
    }
    return list;
  }

  void resetOrder() async {
    showProgress();
    final result = await get(sprintf(Api.resetRegularOrder, [state.orderDetail!.id!]));
    if (result.success) {
      await query();
      showToast('重置成功');
      final stuffsBox = await Hive.openBox(Constant.stuffsBox);
      await stuffsBox.delete('${state.orderDetail!.id!}');
    } else {
      closeProgress();
      showToast(result.msg);
    }
  }

  String? getSignName() {
    String? sign = state.orderDetail!.signatureImage;
    List<MainResponseMember>? list = state.orderDetail!.assistEmployeeArr;
    String? current = state.orderDetail!.mainResponseUserName;
    if (list != null && sign != null && sign != '' && ObjectUtil.isNotEmpty(current)) {
      StringBuffer buffer = StringBuffer();
      for (var e in list) {
        if (e.employeeCode != null && !sign.contains(e.employeeCode!)) {
          buffer.write(e.username);
          buffer.write(',');
        }
      }
      if (buffer.toString().isNotEmpty) {
        return buffer.toString().substring(0, buffer.length - 1);
      }
    }
    return current;
  }

  void transferOrCancelSheet() {
    Get.focusScope?.unfocus();
    List<String> items = [];
    if (StoreLogic.to.permissions.contains(UserPermission.detailAssignTicketPermission)) {
      items.add('转派工单');
    }
    if (StoreLogic.to.permissions.contains(UserPermission.detailAssignToMePermission) &&
        state.orderDetail!.mainResponseUserId != StoreLogic.to.getUser()!.id) {
      items.add('转派给我');
    }
    if (StoreLogic.to.permissions.contains(UserPermission.detailCancelTicketPermission)) {
      items.add('取消工单');
    }
    if (items.isNotEmpty) {
      showAlertBottomSheet(items, (data, index) async {
        if (data == '转派工单') {
          var memberSelectedEntity = await Get.toNamed(Routes.regularSelectMember, arguments: {
            'model': RegularMemberSelectedEntity()
              ..selectedUserId = state.orderDetail!.mainResponseUserId
              ..selectedUserName = state.orderDetail!.mainResponseUserName
              ..selectedGroupCode = state.orderDetail!.groupCode
              ..selectedGroupName = state.orderDetail!.groupName,
          });
          if (memberSelectedEntity is RegularMemberSelectedEntity) {
            //保养工单转派给别人，不需要考虑指定组（目前不支持，只有故障工单可以指定组）
            Get.dialog(
              ConfirmDialog(
                content:
                    '${ObjectUtil.isNotEmpty(state.orderDetail!.mainResponseUserName) ? '该工单原主响应人为${state.orderDetail!.mainResponseUserName!}' : '该工单无主响应人'}，确认变更为${memberSelectedEntity.selectedUserName!}？',
                onConfirm: () => transferOrderToOther(memberSelectedEntity),
              ),
            );
          }
        } else if (data == '转派给我') {
          if (ObjectUtil.isNotEmpty(state.orderDetail!.mainResponseUserName)) {
            Get.dialog(
              ConfirmDialog(
                content:
                    '${ObjectUtil.isNotEmpty(state.orderDetail!.mainResponseUserName) ? '该工单原主响应人为${state.orderDetail!.mainResponseUserName!}' : '该工单无主响应人'}，你是否想成为该工单的主响应人？',
                onConfirm: () => transferOrderToMe(3),
              ),
            );
          } else {
            Get.dialog(
              ConfirmDialog(
                content: '该设备无主响应人，你是否想成为该设备的主响应人',
                cancel: '仅响应一次',
                confirm: '成为主响应人',
                onCancel: () => transferOrderToMe(1),
                onConfirm: () => transferOrderToMe(2),
              ),
            );
          }
        } else if (data == '取消工单') {
          Get.dialog(
            CancelOrderDialog(
              onConfirm: (value) => cancelOrder(value),
            ),
          );
        }
      });
    }
  }

  void moreBtn() {
    Get.bottomSheet(
      OperateDialog(
        checkInDate: isCheckIn() ? () => Get.bottomSheet(HmTimeDialog(onResult: (value) => changeCheckInTime(value))) : null,
        checkOutDate: isCheckOut() ? () => Get.bottomSheet(HmTimeDialog(onResult: (value) => changeCheckOutTime(value))) : null,
        assistNotSigns: showPostCommit() && isExistAssistNotSigned()
            ? () => Get.toNamed(Routes.assistNotSigns, arguments: {
                  'list': state.orderDetail!.assistEmployeeArr,
                  'signatureImage': state.orderDetail!.signatureImage,
                  'type': 1,
                })
            : null,
        recovery: isCheckIn()
            ? () => Get.dialog(
                  ConfirmDialog(
                    onCancel: resetOrder,
                    cancel: '重置工单',
                    confirm: '取消',
                    content: '确定重置工单吗？所有输入的内容将被清空',
                  ),
                )
            : null,
      ),
    );
  }

  //检查规则
  Future<bool> _checkWorkRules() async {
    showProgress();
    final result = await post<List<OrderRuleEntity>>(
      Api.getOrderRules,
      params: {'orderType': 1},
    );
    closeProgress();
    if (result.success) {
      if (showUnderCheckIn()) {
        bool _checkResult1 = await _checkByRules(rules: result.data, ruleKey: RuleKey.enableMultiUser);
        if (!_checkResult1) {
          return false;
        }
        bool _checkResult2 = await _checkByRules(rules: result.data, ruleKey: RuleKey.checkInDeviation);
        return _checkResult2;
      } else if (showUnderCheckOut()) {
        bool _checkResult1 = await _checkByRules(rules: result.data, ruleKey: RuleKey.checkOutDeviation);
        if (!_checkResult1) {
          return false;
        }
        bool _checkResult2 = await _checkByRules(rules: result.data, ruleKey: RuleKey.workDuration);
        return _checkResult2;
      } else if (showUnderCommit()) {
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

  //根据规则校验
  Future<bool> _checkByRules({required List<OrderRuleEntity>? rules, RuleKey ruleKey = RuleKey.checkInDeviation}) async {
    if (ObjectUtil.isNotEmpty(rules)) {
      OrderRuleEntity? orderRuleEntity = rules!.firstWhereOrNull(
          (element) => element.orderType == 1 && element.ruleKey == ruleKey.value && element.enabled == 1 && (element.ruleValue ?? 0) > 0);
      if (orderRuleEntity != null) {
        if (ruleKey == RuleKey.checkInDeviation) {
          if ((state.startDistance ?? 0) > orderRuleEntity.ruleValue!) {
            showToast('您当前位置不在签到范围内，请前往指定地点签到');
            return false;
          }
        } else if (ruleKey == RuleKey.checkOutDeviation) {
          if ((state.endDistance ?? 0) > orderRuleEntity.ruleValue!) {
            showToast('您当前位置不在签退范围内，请前往指定地点签退');
            return false;
          }
        } else if (ruleKey == RuleKey.workDuration) {
          int _startTime = state.orderDetail!.startTime ?? 0;
          if (_startTime <= 0) {
            showToast('签到时间获取失败，请重试');
            return false;
          } else if ((DateUtil.getNowDateMs() - _startTime) < orderRuleEntity.ruleValue! * 60 * 1000) {
            showToast('您当前⼯作时⻓未达标，⼯作时⻓⼩于${orderRuleEntity.ruleValue}分钟，不允许签退');
            return false;
          }
        } else if (ruleKey == RuleKey.enableMultiUser) {
          if (orderRuleEntity.ruleValue == 1 && ObjectUtil.isEmpty(state.orderDetail!.assistEmployee)) {
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

  //签到
  void checkIn() async {
    if (ObjectUtil.isEmpty(state.startLocation) || ObjectUtil.isEmpty(state.startDistance) || ObjectUtil.isEmpty(state.startCoordinates)) {
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
    final _uploadResult = await OssUtil.instance.upload(
      _path,
      timeTag: TimeTagFormat.checkIn,
      dict: 'detail',
      isDecorateMark: true,
    );
    if (_uploadResult.success) {
      final checkInResult = await post(Api.checkInRegularOrder, params: {
        'id': state.orderDetail!.id!,
        'startTime': DateUtil.getNowDateMs(),
        'startImage': _uploadResult.data!.ossKey!,
        'startLocation': state.startLocation,
        'startDistance': state.startDistance,
        'coordinates': state.startCoordinates,
      });
      if (checkInResult.success) {
        await query();
        Future.delayed(
          Duration(milliseconds: 500),
          () => Get.toNamed(Routes.checkStuffs, arguments: {'entity': state.orderDetail, 'editMode': isCheckIn()}),
        );
      } else {
        showToast(checkInResult.msg);
      }
    } else {
      showToast(_uploadResult.msg);
    }
  }

  //签退
  void checkOut() async {
    if (ObjectUtil.isEmpty(state.endLocation) || ObjectUtil.isEmpty(state.endDistance) || ObjectUtil.isEmpty(state.endCoordinates)) {
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
      timeTag: TimeTagFormat.checkOut,
      dict: 'detail',
      isDecorateMark: true,
    );
    if (uploadResult.success) {
      final checkOutResult = await post(Api.checkOutRegularOrder, params: {
        'id': state.orderDetail!.id,
        'endTime': DateUtil.getNowDateMs(),
        'endImage': uploadResult.data!.ossKey!,
        'endLocation': state.endLocation,
        'endDistance': state.endDistance,
        'coordinates': state.endCoordinates,
        'startTime': state.orderDetail!.startTime,
      });
      if (checkOutResult.success) {
        await query();
        showToast('签退成功');
      } else {
        showToast(checkOutResult.msg);
      }
    } else {
      showToast(uploadResult.msg);
    }
  }

  void bottomPressed() async {
    //主保养人变更：有维保组的用户，该设备如果没有主保养人时，可以成为主保养人
    if ((state.orderDetail!.mainMaintainerUserId == null) &&
        (state.orderDetail!.state == 1 || isAheadReply()) &&
        StoreLogic.to.getUser()!.group == true) {
      Get.dialog(
        ConfirmDialog(
          content: '该设备无主保养人，你是否想成为该设备的主保养人？',
          cancel: '仅响应一次',
          confirm: '成为主保养人',
          onConfirm: () => transferOrderToMe(2),
          onCancel: () => transferOrderToMe(1),
        ),
      );
      return;
    }
    //主响应人变更：响应人为空或者工单响应人不是当前登录用户
    if ((ObjectUtil.isEmpty(state.orderDetail!.mainResponseUserId) ||
            (ObjectUtil.isNotEmpty(state.orderDetail!.mainResponseUserId) && StoreLogic.to.getUser()!.id != state.orderDetail!.mainResponseUserId)) &&
        state.orderDetail!.state == 1) {
      Get.dialog(
        ConfirmDialog(
          content:
              '${ObjectUtil.isNotEmpty(state.orderDetail!.mainResponseUserName) ? '该工单原主响应人为${state.orderDetail!.mainResponseUserName!}' : '该工单无主响应人'}，你是否想成为该工单的主响应人？',
          onConfirm: () => transferOrderToMe(3),
        ),
      );
      return;
    }
    //提前回复
    if (isAheadReply()) {
      Get.bottomSheet(
        AdjustDialog(
          shortTerm: () => commitOverTime(adjustType: 1),
          longTerm: () => commitOverTime(adjustType: 2),
        ),
      );
      return;
    }
    //未响应
    if (state.orderDetail!.state == 1) {
      checkIn();
    } else if (state.orderDetail!.state == 2) {
      // 签到之后进入清单项检查
      if (state.orderDetail!.stepState == null || state.orderDetail!.stepState == 1 || !checkCountState()) {
        Get.toNamed(Routes.checkStuffs, arguments: {'entity': state.orderDetail, 'editMode': isCheckIn()});
      } else if (state.orderDetail!.stepState == 2 && checkCountState()) {
        checkOut();
      } else if (state.orderDetail!.stepState == 3) {
        commit();
      } else if ([4, 5].contains(state.orderDetail!.stepState)) {
        Get.toNamed(Routes.signatureBoard,
            arguments: {'employeeCode': isAssist() ? StoreLogic.to.getUser()!.employeeCode : state.orderDetail!.mainResponseUserCode, 'type': 1});
      }
    }
  }

  void toRemark() {
    Get.toNamed(Routes.remark, arguments: {
      'id': state.orderDetail!.id,
      'type': 0,
      'content': state.orderDetail!.remark,
      'imagePic': state.orderDetail!.orderImage,
      'enableEdit': !((isResponding() && showPostCommit()) || isFinish() || isAssist()),
    });
  }

  void toAssist() async {
    var employees = await Get.toNamed(
      Routes.memberAssist,
      arguments: {
        'groupCode': state.orderDetail!.groupCode ?? '',
        'removeUserId': state.orderDetail!.mainResponseUserId,
        'members': state.orderDetail!.assistEmployeeArr,
      },
    );
    if (employees != null) {
      StringBuffer buffer = StringBuffer();
      for (var element in employees) {
        buffer.write(element.employeeCode);
        buffer.write(',');
      }
      String assist = '';
      if (buffer.isNotEmpty) {
        assist = buffer.toString().substring(0, buffer.length - 1);
      }
      showProgress();
      final result = await post(Api.saveRegularOrderAssists, params: {
        'id': state.orderDetail!.id!,
        'assistEmployee': assist,
      });
      if (result.success) {
        await query();
        showToast('调整成功');
      } else {
        showToast(result.msg);
      }
    }
  }

  void toCheckStuffs() {
    Get.toNamed(Routes.checkStuffs, arguments: {'entity': state.orderDetail, 'editMode': isCheckIn() && !isAssist()});
  }

  void toProcess() {
    Get.toNamed(Routes.process, arguments: {'type': 0, 'id': state.orderDetail!.id});
  }

  /// 转派保养工单给别人或整个组
  transferOrderToOther(RegularMemberSelectedEntity memberSelectedEntity) async {
    Map _map = {
      'id': state.orderDetail!.id,
      'transferType': 2,
      'responseType': 3,
      'groupCode': memberSelectedEntity.selectedGroupCode,
      'groupName': memberSelectedEntity.selectedGroupName,
      'mainResponseUserId': memberSelectedEntity.selectedUserId!,
      'mainResponseUserName': memberSelectedEntity.selectedUserName!
    };
    _map['mainResponseUserName'] = memberSelectedEntity.selectedUserName!;
    showProgress();
    final result = await post(Api.transferRegularOrder, params: _map);
    if (result.success) {
      await query();
      showToast('转派成功');
    } else {
      showToast(result.msg);
    }
  }

  /// 转派保养工单给我  响应类型 转派给我的情况下，1响应1次，2成为主保养人，3成为主响应人
  transferOrderToMe(int responseType) async {
    showProgress();
    final result = await post(Api.transferRegularOrder, params: {
      'id': state.orderDetail!.id,
      'transferType': 1,
      'responseType': responseType,
    });
    if (result.success) {
      await query();
      if (responseType == 1) {
        showToast('本次响应成功');
      } else if (responseType == 2) {
        showToast('你已成为该设备主保养人');
      } else {
        showToast('工单主响应人改变成功');
      }
    } else {
      showToast(result.msg);
    }
  }

  /// 取消保养工单
  cancelOrder(String cancelReason) async {
    showProgress();
    final result = await post(
      Api.cancelRegularOrder,
      params: {'remark': cancelReason, 'id': state.orderDetail!.id},
    );
    if (result.success) {
      showToast('取消成功');
      Get.back();
    } else {
      showToast(result.msg);
    }
  }

  void toKfps() {
    if (showUnderCheckIn()) {
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
