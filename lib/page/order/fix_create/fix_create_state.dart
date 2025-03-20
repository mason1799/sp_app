import 'package:flutter/material.dart';
import 'package:konesp/entity/device_project_entity.dart';

class FixCreateState {
  final textFaultDescController = TextEditingController();
  final textFaultDescFocusNode = FocusNode();

  String? selectTime;
  DeviceProjectEquipmentInfoList? selectDevice;
  int? selectedUserId;
  String? selectedUserName;
  String? selectedGroupCode;
  String? selectedGroupName;
  String? currentPeople;
  String? reportor;
  String? phone;
  late bool isNormal;
  late bool isSubmiting;

  FixCreateState() {
    isNormal = true;
    isSubmiting = false;
  }
}
