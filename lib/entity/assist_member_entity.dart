import 'dart:convert';

import 'package:konesp/generated/json/assist_member_entity.g.dart';
import 'package:konesp/generated/json/base/json_field.dart';

@JsonSerializable()
class AssistMemberEntity {
  String? employeeCode;
  String? username;
  String? phone;
  String? groupCode;
  int? userId;

  AssistMemberEntity();

  factory AssistMemberEntity.fromJson(Map<String, dynamic> json) => $AssistMemberEntityFromJson(json);

  Map<String, dynamic> toJson() => $AssistMemberEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
