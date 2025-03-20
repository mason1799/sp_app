import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/user_department_entity.g.dart';

@JsonSerializable()
class UserDepartmentEntity {
  String? id;
  String? name;

  UserDepartmentEntity();

  factory UserDepartmentEntity.fromJson(Map<String, dynamic> json) => $UserDepartmentEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserDepartmentEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
