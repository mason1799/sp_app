import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/department_info_entity.g.dart';

@JsonSerializable()
class DepartmentInfoEntity {
  String? id;
  String? parentId;
  double? sort;
  String? name;
  List<DepartmentInfoEntity>? children;
  double? directorId;
  String? directorName;
  String? directorPhone;
  double? employeeNumber;
  double? level;

  DepartmentInfoEntity();

  factory DepartmentInfoEntity.fromJson(Map<String, dynamic> json) => $DepartmentInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $DepartmentInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
