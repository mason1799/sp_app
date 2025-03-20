import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/entity/dashboard_entity.dart';
import 'package:konesp/entity/weather_entity.dart';
import 'package:konesp/http/http.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/main/main_logic.dart';
import 'package:konesp/page/task/my_task/my_task_logic.dart';
import 'package:konesp/page/task/task_logic.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/kfps_util.dart';
import 'package:konesp/util/location_util.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:sprintf/sprintf.dart';

import 'dashboard_state.dart';

class DashboardLogic extends BaseController {
  final DashboardState state = DashboardState();

  query() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await StoreLogic.to.whenInApp();
      queryDashboard();
      KfpsUtil.initAppLicense();
      queryWeather();
      queryUser();
    });
  }

  Future<void> queryDashboard() async {
    buildGrids();
    final result = await get<DashboardEntity>(Api.dashboard);
    if (result.success) {
      state.dashboardEntity = result.data;
      state.pageStatus = PageStatus.success;
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update();
  }

  Future<void> queryUser() async {
    await StoreLogic.to.queryUserInfo();
    await StoreLogic.to.queryPermissions();
    buildGrids();
  }

  void toTaskTabByIndex(int index) {
    if (index > 1 || index < 0) {
      return;
    }
    if (Get.isRegistered<MainLogic>()) {
      Get.find<MainLogic>().selectToIndex(1);
    }
    if (Get.isRegistered<TaskLogic>()) {
      Get.find<TaskLogic>().state.tabController.animateTo(0);
    }
    if (Get.isRegistered<MyTaskLogic>()) {
      Get.find<MyTaskLogic>().state.selectedDate = DateTime.now();
    }
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        if (Get.isRegistered<MyTaskLogic>()) {
          Get.find<MyTaskLogic>().state.tabController.animateTo(index);
        }
      },
    );
  }

  buildGrids() {
    state.grids = [
      if (StoreLogic.to.permissions.contains(UserPermission.showEquiment))
        GridModel(
          title: '我的设备',
          icon: 'equipment',
          color: Color(0xFF9bb2f6),
          onTap: () => Get.toNamed(Routes.projectList),
        ),
      if (StoreLogic.to.permissions.contains(UserPermission.showContract))
        GridModel(
          title: '我的合同',
          icon: 'contract',
          color: Color(0xFFc8e7de),
          onTap: () => Get.toNamed(Routes.contractList),
        ),
      if (StoreLogic.to.permissions.contains(UserPermission.showmemberManager))
        GridModel(
          title: '人员管理',
          icon: 'member',
          color: Color(0xFFcde1ea),
          onTap: () => Get.toNamed(Routes.memberList),
        ),
      if (StoreLogic.to.permissions.contains(UserPermission.showserviceGroup))
        GridModel(
          title: '维保小组',
          icon: 'service_group',
          color: Color(0xFFfce9e8),
          onTap: () => Get.toNamed(Routes.serviceGroupParent),
        ),
      if (StoreLogic.to.permissions.contains(UserPermission.showcustomerSign))
        GridModel(
          title: '客户签字',
          icon: 'signature',
          color: Color(0xFF97c3f6),
          onTap: () => Get.toNamed(Routes.customerSignature),
          number: state.dashboardEntity?.clientUnSignSum ?? 0,
        ),
      if (StoreLogic.to.getUser()?.isSafetyOfficer == true)
        GridModel(
          title: '安全员签字',
          icon: 'safeguard',
          color: Color(0xFFdce4f9),
          onTap: () => Get.toNamed(Routes.safeguardSignature),
          number: state.dashboardEntity?.safetyOfficerUnSignSum ?? 0,
        ),
    ];
    update(['grids']);
  }

  get equipmentSummary => [
        {'title': '正常运行台量', 'number': state.dashboardEntity?.faultRepairInfo?.normalRunningSum},
        {'title': '例行保养', 'number': state.dashboardEntity?.faultRepairInfo?.maintenanceingSum},
        {'title': '故障报修', 'number': state.dashboardEntity?.faultRepairInfo?.repairingSum},
        {'title': '当前困人', 'number': state.dashboardEntity?.faultRepairInfo?.trappedSum},
        {'title': '停梯超过24h', 'number': state.dashboardEntity?.faultRepairInfo?.stopOverDaySum},
        {'title': '项目总数', 'number': state.dashboardEntity?.projectInfo?.projectSum},
        {'title': '台量总数', 'number': state.dashboardEntity?.projectInfo?.equipmentSum},
        {'title': 'IoT台量', 'number': state.dashboardEntity?.projectInfo?.iotNum},
      ];

  get todos => [
        {'title': '故障报修', 'number': state.dashboardEntity?.toDoOrderInfo?.faultRepairSum},
        {'title': '例行保养', 'number': state.dashboardEntity?.toDoOrderInfo?.routineMaintenanceSum},
      ];

  String getIconByName(String weatherPhenomenon) {
    if (weatherPhenomenon.contains('雨')) {
      return 'rainy';
    } else if (weatherPhenomenon.contains('雪')) {
      return 'snowy';
    } else if (weatherPhenomenon.contains('多云')) {
      return 'duoyun';
    } else if (weatherPhenomenon.contains('晴间多云')) {
      return 'fine';
    } else if (weatherPhenomenon.contains('雾') || weatherPhenomenon.contains('霾')) {
      return 'foggy';
    } else if (weatherPhenomenon.contains('尘')) {
      return 'dust';
    } else if (weatherPhenomenon.contains('阴')) {
      return 'cloudy';
    } else if (weatherPhenomenon.contains('晴')) {
      return 'sunny';
    } else {
      return 'other_weather';
    }
  }

  Future<void> queryWeather() async {
    if (state.weatherStatus == PageStatus.empty) {
      state.weatherStatus = PageStatus.loading;
      update(['weather']);
    }
    LocationUtil().startLocation(
      onResult: (entity) async {
        final weatherResult = await Http().weatherQuery<List<WeatherEntity>>(sprintf(Constant.WEATHER_URL, [entity.adCode]));
        if (weatherResult.success) {
          state.weatherStatus = PageStatus.success;
          state.weatherEntity = weatherResult.data!.first;
        } else {
          state.weatherStatus = PageStatus.error;
        }
        update(['weather']);
      },
      onError: (code, msg) {
        if (code == 1) {
          state.weatherStatus = PageStatus.error;
        } else {
          state.weatherStatus = PageStatus.empty;
          Get.dialog(
            ConfirmDialog(
              content: '定位权限未开启，请打开权限',
              confirm: '去设置',
              onConfirm: () async => await Geolocator.openLocationSettings(),
            ),
          );
        }
        update(['weather']);
      },
    );
  }
}
