import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/main_response_entity.g.dart';

@JsonSerializable()
class MainResponseEntity {
  int? id;
  String? groupCode;
  String? groupName;
  List<MainResponseMember>? memberList;

  MainResponseEntity({this.id, this.groupCode, this.groupName, this.memberList});

  factory MainResponseEntity.fromJson(Map<String, dynamic> json) => $MainResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $MainResponseEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MainResponseMember {
  int? id;
  String? employeeCode;
  String? username;
  String? phone;
  String? groupCode;
  String? groupName;

  MainResponseMember({this.id, this.employeeCode, this.username, this.phone});

  factory MainResponseMember.fromJson(Map<String, dynamic> json) => $MainResponseMemberFromJson(json);

  Map<String, dynamic> toJson() => $MainResponseMemberToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
