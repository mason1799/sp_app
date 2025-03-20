import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/project_entity.dart';

ProjectEntity $ProjectEntityFromJson(Map<String, dynamic> json) {
  final ProjectEntity projectEntity = ProjectEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    projectEntity.id = id;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    projectEntity.projectName = projectName;
  }
  final String? projectCode = jsonConvert.convert<String>(json['projectCode']);
  if (projectCode != null) {
    projectEntity.projectCode = projectCode;
  }
  final String? province = jsonConvert.convert<String>(json['province']);
  if (province != null) {
    projectEntity.province = province;
  }
  final String? prefectureLevelCity = jsonConvert.convert<String>(json['prefectureLevelCity']);
  if (prefectureLevelCity != null) {
    projectEntity.prefectureLevelCity = prefectureLevelCity;
  }
  final String? countyLevelCity = jsonConvert.convert<String>(json['countyLevelCity']);
  if (countyLevelCity != null) {
    projectEntity.countyLevelCity = countyLevelCity;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    projectEntity.projectLocation = projectLocation;
  }
  final String? levelThreeCode = jsonConvert.convert<String>(json['levelThreeCode']);
  if (levelThreeCode != null) {
    projectEntity.levelThreeCode = levelThreeCode;
  }
  final String? projectType = jsonConvert.convert<String>(json['projectType']);
  if (projectType != null) {
    projectEntity.projectType = projectType;
  }
  final int? equipmentNum = jsonConvert.convert<int>(json['equipmentNum']);
  if (equipmentNum != null) {
    projectEntity.equipmentNum = equipmentNum;
  }
  final int? iotNum = jsonConvert.convert<int>(json['iotNum']);
  if (iotNum != null) {
    projectEntity.iotNum = iotNum;
  }
  return projectEntity;
}

Map<String, dynamic> $ProjectEntityToJson(ProjectEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['projectName'] = entity.projectName;
  data['projectCode'] = entity.projectCode;
  data['province'] = entity.province;
  data['prefectureLevelCity'] = entity.prefectureLevelCity;
  data['countyLevelCity'] = entity.countyLevelCity;
  data['projectLocation'] = entity.projectLocation;
  data['levelThreeCode'] = entity.levelThreeCode;
  data['projectType'] = entity.projectType;
  data['equipmentNum'] = entity.equipmentNum;
  data['iotNum'] = entity.iotNum;
  return data;
}

extension ProjectEntityExtension on ProjectEntity {
  ProjectEntity copyWith({
    int? id,
    String? projectName,
    String? projectCode,
    String? province,
    String? prefectureLevelCity,
    String? countyLevelCity,
    String? projectLocation,
    String? levelThreeCode,
    String? projectType,
    int? equipmentNum,
    int? iotNum,
  }) {
    return ProjectEntity()
      ..id = id ?? this.id
      ..projectName = projectName ?? this.projectName
      ..projectCode = projectCode ?? this.projectCode
      ..province = province ?? this.province
      ..prefectureLevelCity = prefectureLevelCity ?? this.prefectureLevelCity
      ..countyLevelCity = countyLevelCity ?? this.countyLevelCity
      ..projectLocation = projectLocation ?? this.projectLocation
      ..levelThreeCode = levelThreeCode ?? this.levelThreeCode
      ..projectType = projectType ?? this.projectType
      ..equipmentNum = equipmentNum ?? this.equipmentNum
      ..iotNum = iotNum ?? this.iotNum;
  }
}