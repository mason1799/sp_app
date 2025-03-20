import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/equipment_detail_entity.g.dart';

@JsonSerializable()
class EquipmentDetailEntity {
  String? department;
  int? id;
  String? levelThreeCode;
  String? equipmentCode;
  String? buildingCode;
  String? elevatorCode;
  String? equipmentType;
  int? equipmentTypeCode;
  String? departmentName;
  String? maintainerGroupName;
  String? maintainerGroupCode;
  String? mainMaintainerUserId;
  String? mainMaintainerUserName;
  String? mainRepairerUserId;
  String? mainRepairerUserName;
  String? equipmentBrand;
  String? equipmentCheckDate;
  String? nextYearCheckDate;
  String? nextOsgDate;
  String? next125Date;
  String? projectName;
  int? projectId;
  String? province;
  String? prefectureLevelCity;
  String? countyLevelCity;
  String? projectLocation;
  String? projectType;
  String? equipmentState;
  int? contractId;
  String? contractCode;
  String? contractName;
  String? contractType;
  String? equipmentStartDate;
  String? equipmentEndDate;
  String? equipmentLocation;
  String? buildingElevatorCode;
  String? projectLocationDetail;
  String? mainRepairerEmployeeCode;
  String? mainMaintainerEmployeeCode;
  String? registerCode;
  String? code96333;
  String? floorNum;
  String? lobbyNum;
  String? currentFloor;
  int? runDirection;
  double? currentSpeed;
  int? status;
  int? elevatorOperation;
  int? safeCircuit;
  int? iotOnline;
  String? iotCode;
  int? temperature;

  EquipmentDetailEntity();

  factory EquipmentDetailEntity.fromJson(Map<String, dynamic> json) => $EquipmentDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $EquipmentDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
