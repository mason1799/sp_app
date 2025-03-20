import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/device_project_entity.g.dart';

@JsonSerializable()
class DeviceProjectEntity {
  int? id;
  String? projectName;
  String? countyLevelCity;
  String? projectLocation;
  double? longitude;
  double? latitude;
  List<DeviceProjectEquipmentInfoList>? equipmentInfoList;

  DeviceProjectEntity();

  factory DeviceProjectEntity.fromJson(Map<String, dynamic> json) => $DeviceProjectEntityFromJson(json);

  Map<String, dynamic> toJson() => $DeviceProjectEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DeviceProjectEquipmentInfoList {
  int? id;
  String? equipmentCode;

  // FORCED_DRIVE(1, "曳引与强制驱动电梯"),
  // ESCALATOR(2, "自动扶梯与自动人行道"),
  // HYDRAULIC(3, "液压电梯"),
  // FIREMAN(4, "消防员电梯"),
  // SUNDRIES(5, "杂物电梯"),
  // EXPLOSION_PROOF(6, "防爆电梯"),
  int? equipmentType;
  String? equipmentTypeName;
  String? mainMaintainerEmployeeCode;
  String? mainMaintainerUserName;
  String? maintainerGroupCode;
  String? maintainerGroupName;
  String? buildingCode;
  String? elevatorCode;
  String? projectName;
  String? projectLocation;
  int? mainRepairerUserId;
  String? mainRepairerUserName;

  DeviceProjectEquipmentInfoList();

  factory DeviceProjectEquipmentInfoList.fromJson(Map<String, dynamic> json) => $DeviceProjectEquipmentInfoListFromJson(json);

  Map<String, dynamic> toJson() => $DeviceProjectEquipmentInfoListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
