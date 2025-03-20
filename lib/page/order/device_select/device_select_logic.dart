import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/device_project_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';

import 'device_select_state.dart';

class DeviceSelectLogic extends BaseController {
  final DeviceSelectState state = DeviceSelectState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await post<List<DeviceProjectEntity>>(Api.deviceListByProject, params: {});
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data!)) {
        state.devices.value = result.data!;
        state.pageStatus.value = PageStatus.success;
      } else {
        state.pageStatus.value = PageStatus.empty;
      }
      state.allDevices.addAll(state.devices);
      state.indexExpand = List.generate(state.devices.length, (index) => false);
      var defaultIndex = findCurrentIndex();
      if (defaultIndex > -1) {
        state.indexExpand[defaultIndex] = true;
      }
    } else {
      state.pageStatus.value = PageStatus.error;
      showToast(result.msg);
    }
  }

  filterRefreshData() {
    String _search = state.searchController.text;
    if (ObjectUtil.isEmpty(_search)) {
      state.devices.value = [...state.allDevices];
      state.devices.refresh();
      state.indexExpand = List.generate(state.devices.length, (index) => true);
      return;
    }
    List<DeviceProjectEntity> list = getNewList();
    List<DeviceProjectEntity> tempList = [];
    for (var device in list) {
      if (ObjectUtil.isNotEmpty(_search) && device.projectName != null && device.projectName!.contains(_search)) {
        tempList.add(device);
      } else if (device.equipmentInfoList != null) {
        List<DeviceProjectEquipmentInfoList>? equipmentInfoList = [];
        for (var e in device.equipmentInfoList!) {
          if (ObjectUtil.isNotEmpty(_search) &&
              ((e.equipmentCode != null && e.equipmentCode!.contains(_search)) ||
                  (e.buildingCode != null && e.buildingCode!.contains(_search)) ||
                  (e.elevatorCode != null && e.elevatorCode!.contains(_search)))) {
            equipmentInfoList.add(e);
          }
        }
        if (equipmentInfoList.isNotEmpty) {
          device.equipmentInfoList = equipmentInfoList;
          tempList.add(device);
        }
      }
    }
    state.devices.value = [...tempList];
    state.devices.refresh();
  }

  getNewList() {
    List<DeviceProjectEntity> list = [];
    DeviceProjectEntity entity;
    for (var element in state.allDevices) {
      entity = DeviceProjectEntity();
      entity.projectName = element.projectName;
      entity.projectLocation = element.projectLocation;
      entity.id = element.id;
      entity.latitude = element.latitude;
      entity.longitude = element.longitude;
      List<DeviceProjectEquipmentInfoList>? itemList = [];
      itemList.addAll(element.equipmentInfoList ?? []);
      entity.equipmentInfoList = itemList;
      list.add(entity);
    }
    return list;
  }

  int findCurrentIndex() {
    int index = -1;
    if (state.currentSelect.value?.projectName != null && state.currentSelect.value?.projectName != '' && state.allDevices.isNotEmpty) {
      for (int i = 0; i < state.allDevices.length; i++) {
        if (state.allDevices[i].projectName == state.currentSelect.value?.projectName) {
          index = i;
          break;
        }
      }
    }
    return index;
  }

  void search() {
    Get.focusScope?.unfocus();
    filterRefreshData();
  }
}
