import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/device_project_entity.dart';

DeviceProjectEntity $DeviceProjectEntityFromJson(Map<String, dynamic> json) {
  final DeviceProjectEntity deviceProjectEntity = DeviceProjectEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    deviceProjectEntity.id = id;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    deviceProjectEntity.projectName = projectName;
  }
  final String? countyLevelCity = jsonConvert.convert<String>(json['countyLevelCity']);
  if (countyLevelCity != null) {
    deviceProjectEntity.countyLevelCity = countyLevelCity;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    deviceProjectEntity.projectLocation = projectLocation;
  }
  final double? longitude = jsonConvert.convert<double>(json['longitude']);
  if (longitude != null) {
    deviceProjectEntity.longitude = longitude;
  }
  final double? latitude = jsonConvert.convert<double>(json['latitude']);
  if (latitude != null) {
    deviceProjectEntity.latitude = latitude;
  }
  final List<DeviceProjectEquipmentInfoList>? equipmentInfoList = (json['equipmentInfoList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<DeviceProjectEquipmentInfoList>(e) as DeviceProjectEquipmentInfoList).toList();
  if (equipmentInfoList != null) {
    deviceProjectEntity.equipmentInfoList = equipmentInfoList;
  }
  return deviceProjectEntity;
}

Map<String, dynamic> $DeviceProjectEntityToJson(DeviceProjectEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['projectName'] = entity.projectName;
  data['countyLevelCity'] = entity.countyLevelCity;
  data['projectLocation'] = entity.projectLocation;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['equipmentInfoList'] = entity.equipmentInfoList?.map((v) => v.toJson()).toList();
  return data;
}

extension DeviceProjectEntityExtension on DeviceProjectEntity {
  DeviceProjectEntity copyWith({
    int? id,
    String? projectName,
    String? countyLevelCity,
    String? projectLocation,
    double? longitude,
    double? latitude,
    List<DeviceProjectEquipmentInfoList>? equipmentInfoList,
  }) {
    return DeviceProjectEntity()
      ..id = id ?? this.id
      ..projectName = projectName ?? this.projectName
      ..countyLevelCity = countyLevelCity ?? this.countyLevelCity
      ..projectLocation = projectLocation ?? this.projectLocation
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..equipmentInfoList = equipmentInfoList ?? this.equipmentInfoList;
  }
}

DeviceProjectEquipmentInfoList $DeviceProjectEquipmentInfoListFromJson(Map<String, dynamic> json) {
  final DeviceProjectEquipmentInfoList deviceProjectEquipmentInfoList = DeviceProjectEquipmentInfoList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    deviceProjectEquipmentInfoList.id = id;
  }
  final String? equipmentCode = jsonConvert.convert<String>(json['equipmentCode']);
  if (equipmentCode != null) {
    deviceProjectEquipmentInfoList.equipmentCode = equipmentCode;
  }
  final int? equipmentType = jsonConvert.convert<int>(json['equipmentType']);
  if (equipmentType != null) {
    deviceProjectEquipmentInfoList.equipmentType = equipmentType;
  }
  final String? equipmentTypeName = jsonConvert.convert<String>(json['equipmentTypeName']);
  if (equipmentTypeName != null) {
    deviceProjectEquipmentInfoList.equipmentTypeName = equipmentTypeName;
  }
  final String? mainMaintainerEmployeeCode = jsonConvert.convert<String>(json['mainMaintainerEmployeeCode']);
  if (mainMaintainerEmployeeCode != null) {
    deviceProjectEquipmentInfoList.mainMaintainerEmployeeCode = mainMaintainerEmployeeCode;
  }
  final String? mainMaintainerUserName = jsonConvert.convert<String>(json['mainMaintainerUserName']);
  if (mainMaintainerUserName != null) {
    deviceProjectEquipmentInfoList.mainMaintainerUserName = mainMaintainerUserName;
  }
  final String? maintainerGroupCode = jsonConvert.convert<String>(json['maintainerGroupCode']);
  if (maintainerGroupCode != null) {
    deviceProjectEquipmentInfoList.maintainerGroupCode = maintainerGroupCode;
  }
  final String? maintainerGroupName = jsonConvert.convert<String>(json['maintainerGroupName']);
  if (maintainerGroupName != null) {
    deviceProjectEquipmentInfoList.maintainerGroupName = maintainerGroupName;
  }
  final String? buildingCode = jsonConvert.convert<String>(json['buildingCode']);
  if (buildingCode != null) {
    deviceProjectEquipmentInfoList.buildingCode = buildingCode;
  }
  final String? elevatorCode = jsonConvert.convert<String>(json['elevatorCode']);
  if (elevatorCode != null) {
    deviceProjectEquipmentInfoList.elevatorCode = elevatorCode;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    deviceProjectEquipmentInfoList.projectName = projectName;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    deviceProjectEquipmentInfoList.projectLocation = projectLocation;
  }
  final int? mainRepairerUserId = jsonConvert.convert<int>(json['mainRepairerUserId']);
  if (mainRepairerUserId != null) {
    deviceProjectEquipmentInfoList.mainRepairerUserId = mainRepairerUserId;
  }
  final String? mainRepairerUserName = jsonConvert.convert<String>(json['mainRepairerUserName']);
  if (mainRepairerUserName != null) {
    deviceProjectEquipmentInfoList.mainRepairerUserName = mainRepairerUserName;
  }
  return deviceProjectEquipmentInfoList;
}

Map<String, dynamic> $DeviceProjectEquipmentInfoListToJson(DeviceProjectEquipmentInfoList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['equipmentCode'] = entity.equipmentCode;
  data['equipmentType'] = entity.equipmentType;
  data['equipmentTypeName'] = entity.equipmentTypeName;
  data['mainMaintainerEmployeeCode'] = entity.mainMaintainerEmployeeCode;
  data['mainMaintainerUserName'] = entity.mainMaintainerUserName;
  data['maintainerGroupCode'] = entity.maintainerGroupCode;
  data['maintainerGroupName'] = entity.maintainerGroupName;
  data['buildingCode'] = entity.buildingCode;
  data['elevatorCode'] = entity.elevatorCode;
  data['projectName'] = entity.projectName;
  data['projectLocation'] = entity.projectLocation;
  data['mainRepairerUserId'] = entity.mainRepairerUserId;
  data['mainRepairerUserName'] = entity.mainRepairerUserName;
  return data;
}

extension DeviceProjectEquipmentInfoListExtension on DeviceProjectEquipmentInfoList {
  DeviceProjectEquipmentInfoList copyWith({
    int? id,
    String? equipmentCode,
    int? equipmentType,
    String? equipmentTypeName,
    String? mainMaintainerEmployeeCode,
    String? mainMaintainerUserName,
    String? maintainerGroupCode,
    String? maintainerGroupName,
    String? buildingCode,
    String? elevatorCode,
    String? projectName,
    String? projectLocation,
    int? mainRepairerUserId,
    String? mainRepairerUserName,
  }) {
    return DeviceProjectEquipmentInfoList()
      ..id = id ?? this.id
      ..equipmentCode = equipmentCode ?? this.equipmentCode
      ..equipmentType = equipmentType ?? this.equipmentType
      ..equipmentTypeName = equipmentTypeName ?? this.equipmentTypeName
      ..mainMaintainerEmployeeCode = mainMaintainerEmployeeCode ?? this.mainMaintainerEmployeeCode
      ..mainMaintainerUserName = mainMaintainerUserName ?? this.mainMaintainerUserName
      ..maintainerGroupCode = maintainerGroupCode ?? this.maintainerGroupCode
      ..maintainerGroupName = maintainerGroupName ?? this.maintainerGroupName
      ..buildingCode = buildingCode ?? this.buildingCode
      ..elevatorCode = elevatorCode ?? this.elevatorCode
      ..projectName = projectName ?? this.projectName
      ..projectLocation = projectLocation ?? this.projectLocation
      ..mainRepairerUserId = mainRepairerUserId ?? this.mainRepairerUserId
      ..mainRepairerUserName = mainRepairerUserName ?? this.mainRepairerUserName;
  }
}