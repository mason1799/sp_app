import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity {
  int? id;
  List<UserInfoRoleEntity>? roles;
  String? tenantId;
  String? username;
  String? phone;
  String? gender;
  String? contractStartDate;
  String? contractEndDate;
  String? onTheJob;
  String? avatar;
  String? operationCertificate;
  bool? leader;
  bool? group;
  String? employeeCode;
  String? companyName;
  bool? isFirstLogin;
  bool? isSafetyOfficer;
  String? duty;
  String? email;
  String? organName;
  String? operationCertificateCode;

  UserInfoEntity();

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoRoleEntity {
  int? id;
  String? roleName;

  UserInfoRoleEntity();

  factory UserInfoRoleEntity.fromJson(Map<String, dynamic> json) => $UserInfoRoleEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoRoleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
