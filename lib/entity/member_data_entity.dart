import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/member_data_entity.g.dart';

@JsonSerializable()
class MemberDataEntity {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? gender;
  String? duty;
  String? contractStartDate;
  String? contractEndDate;
  String? onTheJob;
  String? avatar;

  MemberDataEntity();

  factory MemberDataEntity.fromJson(Map<String, dynamic> json) => $MemberDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $MemberDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
