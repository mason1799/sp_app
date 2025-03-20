import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/group_member_entity.g.dart';

export 'package:konesp/generated/json/group_member_entity.g.dart';

@JsonSerializable()
class GroupMemberEntity {
  int? id;
  String? employeeCode;
  String? username;
  String? phone;
  int? userId;

  GroupMemberEntity();

  factory GroupMemberEntity.fromJson(Map<String, dynamic> json) => $GroupMemberEntityFromJson(json);

  Map<String, dynamic> toJson() => $GroupMemberEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
