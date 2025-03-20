import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:konesp/entity/equipment_detail_entity.dart';
import 'package:konesp/entity/iot_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/alert_bottom_sheet.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:sprintf/sprintf.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../project_detail/project_detail_logic.dart';
import 'equipment_detail_state.dart';

class EquipmentDetailLogic extends BaseController with WidgetsBindingObserver {
  final EquipmentDetailState state = EquipmentDetailState();

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() {
    query();
  }

  @override
  void onClose() {
    _closeIoT();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    super.didChangeAppLifecycleState(lifecycleState);
    switch (lifecycleState) {
      case AppLifecycleState.resumed:
        _connectIoT();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _closeIoT();
        break;
      default:
        break;
    }
  }

  query() async {
    final result = await get<EquipmentDetailEntity>(sprintf(Api.equipmentDetail, [state.id]));
    if (result.success) {
      state.detailEntity = result.data!;
      state.pageStatus = PageStatus.success;
      _connectIoT();
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  _connectIoT() async {
    if (state.detailEntity != null && state.detailEntity!.iotOnline == 2) {
      final _wsUrl = Get.find<BuildEnvironment>().wsUrl;
      final _tenantId = StoreLogic.to.getUser()!.tenantId;
      final _userId = StoreLogic.to.getUser()!.id;
      final _code = state.detailEntity!.equipmentCode;
      state.channel = WebSocketChannel.connect(Uri.parse('$_wsUrl/maintain/webSocket/notification/app/$_tenantId/$_userId/$_code'));
      await state.channel!.ready;
      state.channel?.stream.listen((message) {
        final entity = IotEntity.fromJson(jsonDecode(message));
        state.detailEntity!.currentSpeed = entity.currentSpeed;
        state.detailEntity!.currentFloor = entity.currentFloor;
        state.detailEntity!.safeCircuit = entity.safeCircuit;
        state.detailEntity!.runDirection = entity.runDirection;
        state.detailEntity!.elevatorOperation = entity.elevatorOperation;
        state.detailEntity!.status = entity.status;
        update(['iot']);
      });
      _startPingPong();
    }
  }

  _closeIoT() {
    state.timer?.cancel();
    state.channel?.sink.close();
  }

  _startPingPong() {
    if (state.timer != null && state.timer!.isActive) {
      return;
    }
    state.timer = Timer.periodic(Duration(seconds: 20), (timer) {
      state.channel?.sink.add(jsonEncode({'type': 'ping'}));
    });
  }

  moreAction() {
    List<String> items = [];
    if (StoreLogic.to.permissions.contains(UserPermission.editEquipment)) {
      items.add('编辑');
    }
    if (StoreLogic.to.permissions.contains(UserPermission.deleteEquipment)) {
      items.add('删除');
    }
    if (items.isNotEmpty) {
      showAlertBottomSheet(items, (data, index) async {
        if (data == '编辑') {
          Get.toNamed(Routes.equipmentEdit, arguments: {'id': state.id});
        } else if (data == '删除') {
          Get.dialog(
            ConfirmDialog(
              content: '你确定要删除该设备吗?',
              onConfirm: () async {
                showProgress();
                final result = await delete(sprintf(Api.deleteEquipment, [state.id]));
                closeProgress();
                if (result.success) {
                  if (Get.isRegistered<ProjectDetailLogic>()) {
                    Get.find<ProjectDetailLogic>().deleteEquipment(state.id);
                  }
                  showToast('设备删除成功');
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
}
