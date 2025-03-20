import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/device_project_entity.dart';
import 'package:konesp/widget/error_page.dart';

class DeviceSelectState extends GetxController {
  var pageStatus = PageStatus.loading.obs;
  var devices = <DeviceProjectEntity>[].obs;
  var allDevices = <DeviceProjectEntity>[].obs;
  Rx<DeviceProjectEquipmentInfoList?> currentSelect = Rx<DeviceProjectEquipmentInfoList>(DeviceProjectEquipmentInfoList());
  var searchController = TextEditingController();
  late List<bool> indexExpand;

  DeviceSelectState() {
    currentSelect.value = Get.arguments ?? DeviceProjectEquipmentInfoList();
    indexExpand = [];
  }
}
