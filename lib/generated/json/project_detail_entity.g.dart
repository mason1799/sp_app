import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/project_detail_entity.dart';
import 'package:konesp/entity/equipment_detail_entity.dart';


ProjectDetailEntity $ProjectDetailEntityFromJson(Map<String, dynamic> json) {
  final ProjectDetailEntity projectDetailEntity = ProjectDetailEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    projectDetailEntity.id = id;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    projectDetailEntity.projectName = projectName;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    projectDetailEntity.projectLocation = projectLocation;
  }
  final String? projectType = jsonConvert.convert<String>(json['projectType']);
  if (projectType != null) {
    projectDetailEntity.projectType = projectType;
  }
  final int? equipmentNum = jsonConvert.convert<int>(json['equipmentNum']);
  if (equipmentNum != null) {
    projectDetailEntity.equipmentNum = equipmentNum;
  }
  final int? iotNum = jsonConvert.convert<int>(json['iotNum']);
  if (iotNum != null) {
    projectDetailEntity.iotNum = iotNum;
  }
  final List<EquipmentDetailEntity>? equipmentInfoVoList = (json['equipmentInfoVoList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<EquipmentDetailEntity>(e) as EquipmentDetailEntity).toList();
  if (equipmentInfoVoList != null) {
    projectDetailEntity.equipmentInfoVoList = equipmentInfoVoList;
  }
  return projectDetailEntity;
}

Map<String, dynamic> $ProjectDetailEntityToJson(ProjectDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['projectName'] = entity.projectName;
  data['projectLocation'] = entity.projectLocation;
  data['projectType'] = entity.projectType;
  data['equipmentNum'] = entity.equipmentNum;
  data['iotNum'] = entity.iotNum;
  data['equipmentInfoVoList'] = entity.equipmentInfoVoList?.map((v) => v.toJson()).toList();
  return data;
}

extension ProjectDetailEntityExtension on ProjectDetailEntity {
  ProjectDetailEntity copyWith({
    int? id,
    String? projectName,
    String? projectLocation,
    String? projectType,
    int? equipmentNum,
    int? iotNum,
    List<EquipmentDetailEntity>? equipmentInfoVoList,
  }) {
    return ProjectDetailEntity()
      ..id = id ?? this.id
      ..projectName = projectName ?? this.projectName
      ..projectLocation = projectLocation ?? this.projectLocation
      ..projectType = projectType ?? this.projectType
      ..equipmentNum = equipmentNum ?? this.equipmentNum
      ..iotNum = iotNum ?? this.iotNum
      ..equipmentInfoVoList = equipmentInfoVoList ?? this.equipmentInfoVoList;
  }
}