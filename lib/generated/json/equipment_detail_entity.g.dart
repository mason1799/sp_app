import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/equipment_detail_entity.dart';

EquipmentDetailEntity $EquipmentDetailEntityFromJson(Map<String, dynamic> json) {
  final EquipmentDetailEntity equipmentDetailEntity = EquipmentDetailEntity();
  final String? department = jsonConvert.convert<String>(json['department']);
  if (department != null) {
    equipmentDetailEntity.department = department;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    equipmentDetailEntity.id = id;
  }
  final String? levelThreeCode = jsonConvert.convert<String>(json['levelThreeCode']);
  if (levelThreeCode != null) {
    equipmentDetailEntity.levelThreeCode = levelThreeCode;
  }
  final String? equipmentCode = jsonConvert.convert<String>(json['equipmentCode']);
  if (equipmentCode != null) {
    equipmentDetailEntity.equipmentCode = equipmentCode;
  }
  final String? buildingCode = jsonConvert.convert<String>(json['buildingCode']);
  if (buildingCode != null) {
    equipmentDetailEntity.buildingCode = buildingCode;
  }
  final String? elevatorCode = jsonConvert.convert<String>(json['elevatorCode']);
  if (elevatorCode != null) {
    equipmentDetailEntity.elevatorCode = elevatorCode;
  }
  final String? equipmentType = jsonConvert.convert<String>(json['equipmentType']);
  if (equipmentType != null) {
    equipmentDetailEntity.equipmentType = equipmentType;
  }
  final int? equipmentTypeCode = jsonConvert.convert<int>(json['equipmentTypeCode']);
  if (equipmentTypeCode != null) {
    equipmentDetailEntity.equipmentTypeCode = equipmentTypeCode;
  }
  final String? departmentName = jsonConvert.convert<String>(json['departmentName']);
  if (departmentName != null) {
    equipmentDetailEntity.departmentName = departmentName;
  }
  final String? maintainerGroupName = jsonConvert.convert<String>(json['maintainerGroupName']);
  if (maintainerGroupName != null) {
    equipmentDetailEntity.maintainerGroupName = maintainerGroupName;
  }
  final String? maintainerGroupCode = jsonConvert.convert<String>(json['maintainerGroupCode']);
  if (maintainerGroupCode != null) {
    equipmentDetailEntity.maintainerGroupCode = maintainerGroupCode;
  }
  final String? mainMaintainerUserId = jsonConvert.convert<String>(json['mainMaintainerUserId']);
  if (mainMaintainerUserId != null) {
    equipmentDetailEntity.mainMaintainerUserId = mainMaintainerUserId;
  }
  final String? mainMaintainerUserName = jsonConvert.convert<String>(json['mainMaintainerUserName']);
  if (mainMaintainerUserName != null) {
    equipmentDetailEntity.mainMaintainerUserName = mainMaintainerUserName;
  }
  final String? mainRepairerUserId = jsonConvert.convert<String>(json['mainRepairerUserId']);
  if (mainRepairerUserId != null) {
    equipmentDetailEntity.mainRepairerUserId = mainRepairerUserId;
  }
  final String? mainRepairerUserName = jsonConvert.convert<String>(json['mainRepairerUserName']);
  if (mainRepairerUserName != null) {
    equipmentDetailEntity.mainRepairerUserName = mainRepairerUserName;
  }
  final String? equipmentBrand = jsonConvert.convert<String>(json['equipmentBrand']);
  if (equipmentBrand != null) {
    equipmentDetailEntity.equipmentBrand = equipmentBrand;
  }
  final String? equipmentCheckDate = jsonConvert.convert<String>(json['equipmentCheckDate']);
  if (equipmentCheckDate != null) {
    equipmentDetailEntity.equipmentCheckDate = equipmentCheckDate;
  }
  final String? nextYearCheckDate = jsonConvert.convert<String>(json['nextYearCheckDate']);
  if (nextYearCheckDate != null) {
    equipmentDetailEntity.nextYearCheckDate = nextYearCheckDate;
  }
  final String? nextOsgDate = jsonConvert.convert<String>(json['nextOsgDate']);
  if (nextOsgDate != null) {
    equipmentDetailEntity.nextOsgDate = nextOsgDate;
  }
  final String? next125Date = jsonConvert.convert<String>(json['next125Date']);
  if (next125Date != null) {
    equipmentDetailEntity.next125Date = next125Date;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    equipmentDetailEntity.projectName = projectName;
  }
  final int? projectId = jsonConvert.convert<int>(json['projectId']);
  if (projectId != null) {
    equipmentDetailEntity.projectId = projectId;
  }
  final String? province = jsonConvert.convert<String>(json['province']);
  if (province != null) {
    equipmentDetailEntity.province = province;
  }
  final String? prefectureLevelCity = jsonConvert.convert<String>(json['prefectureLevelCity']);
  if (prefectureLevelCity != null) {
    equipmentDetailEntity.prefectureLevelCity = prefectureLevelCity;
  }
  final String? countyLevelCity = jsonConvert.convert<String>(json['countyLevelCity']);
  if (countyLevelCity != null) {
    equipmentDetailEntity.countyLevelCity = countyLevelCity;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    equipmentDetailEntity.projectLocation = projectLocation;
  }
  final String? projectType = jsonConvert.convert<String>(json['projectType']);
  if (projectType != null) {
    equipmentDetailEntity.projectType = projectType;
  }
  final String? equipmentState = jsonConvert.convert<String>(json['equipmentState']);
  if (equipmentState != null) {
    equipmentDetailEntity.equipmentState = equipmentState;
  }
  final int? contractId = jsonConvert.convert<int>(json['contractId']);
  if (contractId != null) {
    equipmentDetailEntity.contractId = contractId;
  }
  final String? contractCode = jsonConvert.convert<String>(json['contractCode']);
  if (contractCode != null) {
    equipmentDetailEntity.contractCode = contractCode;
  }
  final String? contractName = jsonConvert.convert<String>(json['contractName']);
  if (contractName != null) {
    equipmentDetailEntity.contractName = contractName;
  }
  final String? contractType = jsonConvert.convert<String>(json['contractType']);
  if (contractType != null) {
    equipmentDetailEntity.contractType = contractType;
  }
  final String? equipmentStartDate = jsonConvert.convert<String>(json['equipmentStartDate']);
  if (equipmentStartDate != null) {
    equipmentDetailEntity.equipmentStartDate = equipmentStartDate;
  }
  final String? equipmentEndDate = jsonConvert.convert<String>(json['equipmentEndDate']);
  if (equipmentEndDate != null) {
    equipmentDetailEntity.equipmentEndDate = equipmentEndDate;
  }
  final String? equipmentLocation = jsonConvert.convert<String>(json['equipmentLocation']);
  if (equipmentLocation != null) {
    equipmentDetailEntity.equipmentLocation = equipmentLocation;
  }
  final String? buildingElevatorCode = jsonConvert.convert<String>(json['buildingElevatorCode']);
  if (buildingElevatorCode != null) {
    equipmentDetailEntity.buildingElevatorCode = buildingElevatorCode;
  }
  final String? projectLocationDetail = jsonConvert.convert<String>(json['projectLocationDetail']);
  if (projectLocationDetail != null) {
    equipmentDetailEntity.projectLocationDetail = projectLocationDetail;
  }
  final String? mainRepairerEmployeeCode = jsonConvert.convert<String>(json['mainRepairerEmployeeCode']);
  if (mainRepairerEmployeeCode != null) {
    equipmentDetailEntity.mainRepairerEmployeeCode = mainRepairerEmployeeCode;
  }
  final String? mainMaintainerEmployeeCode = jsonConvert.convert<String>(json['mainMaintainerEmployeeCode']);
  if (mainMaintainerEmployeeCode != null) {
    equipmentDetailEntity.mainMaintainerEmployeeCode = mainMaintainerEmployeeCode;
  }
  final String? registerCode = jsonConvert.convert<String>(json['registerCode']);
  if (registerCode != null) {
    equipmentDetailEntity.registerCode = registerCode;
  }
  final String? code96333 = jsonConvert.convert<String>(json['code96333']);
  if (code96333 != null) {
    equipmentDetailEntity.code96333 = code96333;
  }
  final String? floorNum = jsonConvert.convert<String>(json['floorNum']);
  if (floorNum != null) {
    equipmentDetailEntity.floorNum = floorNum;
  }
  final String? lobbyNum = jsonConvert.convert<String>(json['lobbyNum']);
  if (lobbyNum != null) {
    equipmentDetailEntity.lobbyNum = lobbyNum;
  }
  final String? currentFloor = jsonConvert.convert<String>(json['currentFloor']);
  if (currentFloor != null) {
    equipmentDetailEntity.currentFloor = currentFloor;
  }
  final int? runDirection = jsonConvert.convert<int>(json['runDirection']);
  if (runDirection != null) {
    equipmentDetailEntity.runDirection = runDirection;
  }
  final double? currentSpeed = jsonConvert.convert<double>(json['currentSpeed']);
  if (currentSpeed != null) {
    equipmentDetailEntity.currentSpeed = currentSpeed;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    equipmentDetailEntity.status = status;
  }
  final int? elevatorOperation = jsonConvert.convert<int>(json['elevatorOperation']);
  if (elevatorOperation != null) {
    equipmentDetailEntity.elevatorOperation = elevatorOperation;
  }
  final int? safeCircuit = jsonConvert.convert<int>(json['safeCircuit']);
  if (safeCircuit != null) {
    equipmentDetailEntity.safeCircuit = safeCircuit;
  }
  final int? iotOnline = jsonConvert.convert<int>(json['iotOnline']);
  if (iotOnline != null) {
    equipmentDetailEntity.iotOnline = iotOnline;
  }
  final String? iotCode = jsonConvert.convert<String>(json['iotCode']);
  if (iotCode != null) {
    equipmentDetailEntity.iotCode = iotCode;
  }
  final int? temperature = jsonConvert.convert<int>(json['temperature']);
  if (temperature != null) {
    equipmentDetailEntity.temperature = temperature;
  }
  return equipmentDetailEntity;
}

Map<String, dynamic> $EquipmentDetailEntityToJson(EquipmentDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['department'] = entity.department;
  data['id'] = entity.id;
  data['levelThreeCode'] = entity.levelThreeCode;
  data['equipmentCode'] = entity.equipmentCode;
  data['buildingCode'] = entity.buildingCode;
  data['elevatorCode'] = entity.elevatorCode;
  data['equipmentType'] = entity.equipmentType;
  data['equipmentTypeCode'] = entity.equipmentTypeCode;
  data['departmentName'] = entity.departmentName;
  data['maintainerGroupName'] = entity.maintainerGroupName;
  data['maintainerGroupCode'] = entity.maintainerGroupCode;
  data['mainMaintainerUserId'] = entity.mainMaintainerUserId;
  data['mainMaintainerUserName'] = entity.mainMaintainerUserName;
  data['mainRepairerUserId'] = entity.mainRepairerUserId;
  data['mainRepairerUserName'] = entity.mainRepairerUserName;
  data['equipmentBrand'] = entity.equipmentBrand;
  data['equipmentCheckDate'] = entity.equipmentCheckDate;
  data['nextYearCheckDate'] = entity.nextYearCheckDate;
  data['nextOsgDate'] = entity.nextOsgDate;
  data['next125Date'] = entity.next125Date;
  data['projectName'] = entity.projectName;
  data['projectId'] = entity.projectId;
  data['province'] = entity.province;
  data['prefectureLevelCity'] = entity.prefectureLevelCity;
  data['countyLevelCity'] = entity.countyLevelCity;
  data['projectLocation'] = entity.projectLocation;
  data['projectType'] = entity.projectType;
  data['equipmentState'] = entity.equipmentState;
  data['contractId'] = entity.contractId;
  data['contractCode'] = entity.contractCode;
  data['contractName'] = entity.contractName;
  data['contractType'] = entity.contractType;
  data['equipmentStartDate'] = entity.equipmentStartDate;
  data['equipmentEndDate'] = entity.equipmentEndDate;
  data['equipmentLocation'] = entity.equipmentLocation;
  data['buildingElevatorCode'] = entity.buildingElevatorCode;
  data['projectLocationDetail'] = entity.projectLocationDetail;
  data['mainRepairerEmployeeCode'] = entity.mainRepairerEmployeeCode;
  data['mainMaintainerEmployeeCode'] = entity.mainMaintainerEmployeeCode;
  data['registerCode'] = entity.registerCode;
  data['code96333'] = entity.code96333;
  data['floorNum'] = entity.floorNum;
  data['lobbyNum'] = entity.lobbyNum;
  data['currentFloor'] = entity.currentFloor;
  data['runDirection'] = entity.runDirection;
  data['currentSpeed'] = entity.currentSpeed;
  data['status'] = entity.status;
  data['elevatorOperation'] = entity.elevatorOperation;
  data['safeCircuit'] = entity.safeCircuit;
  data['iotOnline'] = entity.iotOnline;
  data['iotCode'] = entity.iotCode;
  data['temperature'] = entity.temperature;
  return data;
}

extension EquipmentDetailEntityExtension on EquipmentDetailEntity {
  EquipmentDetailEntity copyWith({
    String? department,
    int? id,
    String? levelThreeCode,
    String? equipmentCode,
    String? buildingCode,
    String? elevatorCode,
    String? equipmentType,
    int? equipmentTypeCode,
    String? departmentName,
    String? maintainerGroupName,
    String? maintainerGroupCode,
    String? mainMaintainerUserId,
    String? mainMaintainerUserName,
    String? mainRepairerUserId,
    String? mainRepairerUserName,
    String? equipmentBrand,
    String? equipmentCheckDate,
    String? nextYearCheckDate,
    String? nextOsgDate,
    String? next125Date,
    String? projectName,
    int? projectId,
    String? province,
    String? prefectureLevelCity,
    String? countyLevelCity,
    String? projectLocation,
    String? projectType,
    String? equipmentState,
    int? contractId,
    String? contractCode,
    String? contractName,
    String? contractType,
    String? equipmentStartDate,
    String? equipmentEndDate,
    String? equipmentLocation,
    String? buildingElevatorCode,
    String? projectLocationDetail,
    String? mainRepairerEmployeeCode,
    String? mainMaintainerEmployeeCode,
    String? registerCode,
    String? code96333,
    String? floorNum,
    String? lobbyNum,
    String? currentFloor,
    int? runDirection,
    double? currentSpeed,
    int? status,
    int? elevatorOperation,
    int? safeCircuit,
    int? iotOnline,
    String? iotCode,
    int? temperature,
  }) {
    return EquipmentDetailEntity()
      ..department = department ?? this.department
      ..id = id ?? this.id
      ..levelThreeCode = levelThreeCode ?? this.levelThreeCode
      ..equipmentCode = equipmentCode ?? this.equipmentCode
      ..buildingCode = buildingCode ?? this.buildingCode
      ..elevatorCode = elevatorCode ?? this.elevatorCode
      ..equipmentType = equipmentType ?? this.equipmentType
      ..equipmentTypeCode = equipmentTypeCode ?? this.equipmentTypeCode
      ..departmentName = departmentName ?? this.departmentName
      ..maintainerGroupName = maintainerGroupName ?? this.maintainerGroupName
      ..maintainerGroupCode = maintainerGroupCode ?? this.maintainerGroupCode
      ..mainMaintainerUserId = mainMaintainerUserId ?? this.mainMaintainerUserId
      ..mainMaintainerUserName = mainMaintainerUserName ?? this.mainMaintainerUserName
      ..mainRepairerUserId = mainRepairerUserId ?? this.mainRepairerUserId
      ..mainRepairerUserName = mainRepairerUserName ?? this.mainRepairerUserName
      ..equipmentBrand = equipmentBrand ?? this.equipmentBrand
      ..equipmentCheckDate = equipmentCheckDate ?? this.equipmentCheckDate
      ..nextYearCheckDate = nextYearCheckDate ?? this.nextYearCheckDate
      ..nextOsgDate = nextOsgDate ?? this.nextOsgDate
      ..next125Date = next125Date ?? this.next125Date
      ..projectName = projectName ?? this.projectName
      ..projectId = projectId ?? this.projectId
      ..province = province ?? this.province
      ..prefectureLevelCity = prefectureLevelCity ?? this.prefectureLevelCity
      ..countyLevelCity = countyLevelCity ?? this.countyLevelCity
      ..projectLocation = projectLocation ?? this.projectLocation
      ..projectType = projectType ?? this.projectType
      ..equipmentState = equipmentState ?? this.equipmentState
      ..contractId = contractId ?? this.contractId
      ..contractCode = contractCode ?? this.contractCode
      ..contractName = contractName ?? this.contractName
      ..contractType = contractType ?? this.contractType
      ..equipmentStartDate = equipmentStartDate ?? this.equipmentStartDate
      ..equipmentEndDate = equipmentEndDate ?? this.equipmentEndDate
      ..equipmentLocation = equipmentLocation ?? this.equipmentLocation
      ..buildingElevatorCode = buildingElevatorCode ?? this.buildingElevatorCode
      ..projectLocationDetail = projectLocationDetail ?? this.projectLocationDetail
      ..mainRepairerEmployeeCode = mainRepairerEmployeeCode ?? this.mainRepairerEmployeeCode
      ..mainMaintainerEmployeeCode = mainMaintainerEmployeeCode ?? this.mainMaintainerEmployeeCode
      ..registerCode = registerCode ?? this.registerCode
      ..code96333 = code96333 ?? this.code96333
      ..floorNum = floorNum ?? this.floorNum
      ..lobbyNum = lobbyNum ?? this.lobbyNum
      ..currentFloor = currentFloor ?? this.currentFloor
      ..runDirection = runDirection ?? this.runDirection
      ..currentSpeed = currentSpeed ?? this.currentSpeed
      ..status = status ?? this.status
      ..elevatorOperation = elevatorOperation ?? this.elevatorOperation
      ..safeCircuit = safeCircuit ?? this.safeCircuit
      ..iotOnline = iotOnline ?? this.iotOnline
      ..iotCode = iotCode ?? this.iotCode
      ..temperature = temperature ?? this.temperature;
  }
}