import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/service_group_entity.g.dart';

@JsonSerializable()
class ServiceGroupEntity {
  String? groupCode;
  String? groupName;
  String? departmentName;
  String? employee;
  int? equipmentNum;
  List<ServiceGroupMember>? members;

  ServiceGroupEntity();

  factory ServiceGroupEntity.fromJson(Map<String, dynamic> json) => $ServiceGroupEntityFromJson(json);

  Map<String, dynamic> toJson() => $ServiceGroupEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ServiceGroupMember {
  String? username;
  String? employeeCode;

  ServiceGroupMember();

  factory ServiceGroupMember.fromJson(Map<String, dynamic> json) => $ServiceGroupMemberFromJson(json);

  Map<String, dynamic> toJson() => $ServiceGroupMemberToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
