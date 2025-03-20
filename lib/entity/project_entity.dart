import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/project_entity.g.dart';

export 'package:konesp/generated/json/project_entity.g.dart';

@JsonSerializable()
class ProjectEntity {
  int? id;
  String? projectName;
  String? projectCode;
  String? province;
  String? prefectureLevelCity;
  String? countyLevelCity;
  String? projectLocation;
  String? levelThreeCode;
  String? projectType;
  int? equipmentNum;
  int? iotNum;

  ProjectEntity();

  factory ProjectEntity.fromJson(Map<String, dynamic> json) => $ProjectEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProjectEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
