import 'dart:convert';

import 'package:konesp/entity/equipment_detail_entity.dart';
import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/project_detail_entity.g.dart';

@JsonSerializable()
class ProjectDetailEntity {
  int? id;
  String? projectName;
  String? projectLocation;
  String? projectType;
  int? equipmentNum;
  int? iotNum;
  List<EquipmentDetailEntity>? equipmentInfoVoList;

  ProjectDetailEntity();

  factory ProjectDetailEntity.fromJson(Map<String, dynamic> json) => $ProjectDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProjectDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}