import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/user_info_entity.dart';

UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
  final UserInfoEntity userInfoEntity = UserInfoEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userInfoEntity.id = id;
  }
  final List<UserInfoRoleEntity>? roles = (json['roles'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<UserInfoRoleEntity>(e) as UserInfoRoleEntity).toList();
  if (roles != null) {
    userInfoEntity.roles = roles;
  }
  final String? tenantId = jsonConvert.convert<String>(json['tenantId']);
  if (tenantId != null) {
    userInfoEntity.tenantId = tenantId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    userInfoEntity.username = username;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userInfoEntity.phone = phone;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    userInfoEntity.gender = gender;
  }
  final String? contractStartDate = jsonConvert.convert<String>(json['contractStartDate']);
  if (contractStartDate != null) {
    userInfoEntity.contractStartDate = contractStartDate;
  }
  final String? contractEndDate = jsonConvert.convert<String>(json['contractEndDate']);
  if (contractEndDate != null) {
    userInfoEntity.contractEndDate = contractEndDate;
  }
  final String? onTheJob = jsonConvert.convert<String>(json['onTheJob']);
  if (onTheJob != null) {
    userInfoEntity.onTheJob = onTheJob;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    userInfoEntity.avatar = avatar;
  }
  final String? operationCertificate = jsonConvert.convert<String>(json['operationCertificate']);
  if (operationCertificate != null) {
    userInfoEntity.operationCertificate = operationCertificate;
  }
  final bool? leader = jsonConvert.convert<bool>(json['leader']);
  if (leader != null) {
    userInfoEntity.leader = leader;
  }
  final bool? group = jsonConvert.convert<bool>(json['group']);
  if (group != null) {
    userInfoEntity.group = group;
  }
  final String? employeeCode = jsonConvert.convert<String>(json['employeeCode']);
  if (employeeCode != null) {
    userInfoEntity.employeeCode = employeeCode;
  }
  final String? companyName = jsonConvert.convert<String>(json['companyName']);
  if (companyName != null) {
    userInfoEntity.companyName = companyName;
  }
  final bool? isFirstLogin = jsonConvert.convert<bool>(json['isFirstLogin']);
  if (isFirstLogin != null) {
    userInfoEntity.isFirstLogin = isFirstLogin;
  }
  final bool? isSafetyOfficer = jsonConvert.convert<bool>(json['isSafetyOfficer']);
  if (isSafetyOfficer != null) {
    userInfoEntity.isSafetyOfficer = isSafetyOfficer;
  }
  final String? duty = jsonConvert.convert<String>(json['duty']);
  if (duty != null) {
    userInfoEntity.duty = duty;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    userInfoEntity.email = email;
  }
  final String? organName = jsonConvert.convert<String>(json['organName']);
  if (organName != null) {
    userInfoEntity.organName = organName;
  }
  final String? operationCertificateCode = jsonConvert.convert<String>(json['operationCertificateCode']);
  if (operationCertificateCode != null) {
    userInfoEntity.operationCertificateCode = operationCertificateCode;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['roles'] = entity.roles?.map((v) => v.toJson()).toList();
  data['tenantId'] = entity.tenantId;
  data['username'] = entity.username;
  data['phone'] = entity.phone;
  data['gender'] = entity.gender;
  data['contractStartDate'] = entity.contractStartDate;
  data['contractEndDate'] = entity.contractEndDate;
  data['onTheJob'] = entity.onTheJob;
  data['avatar'] = entity.avatar;
  data['operationCertificate'] = entity.operationCertificate;
  data['leader'] = entity.leader;
  data['group'] = entity.group;
  data['employeeCode'] = entity.employeeCode;
  data['companyName'] = entity.companyName;
  data['isFirstLogin'] = entity.isFirstLogin;
  data['isSafetyOfficer'] = entity.isSafetyOfficer;
  data['duty'] = entity.duty;
  data['email'] = entity.email;
  data['organName'] = entity.organName;
  data['operationCertificateCode'] = entity.operationCertificateCode;
  return data;
}

extension UserInfoEntityExtension on UserInfoEntity {
  UserInfoEntity copyWith({
    int? id,
    List<UserInfoRoleEntity>? roles,
    String? tenantId,
    String? username,
    String? phone,
    String? gender,
    String? contractStartDate,
    String? contractEndDate,
    String? onTheJob,
    String? avatar,
    String? operationCertificate,
    bool? leader,
    bool? group,
    String? employeeCode,
    String? companyName,
    bool? isFirstLogin,
    bool? isSafetyOfficer,
    String? duty,
    String? email,
    String? organName,
    String? operationCertificateCode,
  }) {
    return UserInfoEntity()
      ..id = id ?? this.id
      ..roles = roles ?? this.roles
      ..tenantId = tenantId ?? this.tenantId
      ..username = username ?? this.username
      ..phone = phone ?? this.phone
      ..gender = gender ?? this.gender
      ..contractStartDate = contractStartDate ?? this.contractStartDate
      ..contractEndDate = contractEndDate ?? this.contractEndDate
      ..onTheJob = onTheJob ?? this.onTheJob
      ..avatar = avatar ?? this.avatar
      ..operationCertificate = operationCertificate ?? this.operationCertificate
      ..leader = leader ?? this.leader
      ..group = group ?? this.group
      ..employeeCode = employeeCode ?? this.employeeCode
      ..companyName = companyName ?? this.companyName
      ..isFirstLogin = isFirstLogin ?? this.isFirstLogin
      ..isSafetyOfficer = isSafetyOfficer ?? this.isSafetyOfficer
      ..duty = duty ?? this.duty
      ..email = email ?? this.email
      ..organName = organName ?? this.organName
      ..operationCertificateCode = operationCertificateCode ?? this.operationCertificateCode;
  }
}

UserInfoRoleEntity $UserInfoRoleEntityFromJson(Map<String, dynamic> json) {
  final UserInfoRoleEntity userInfoRoleEntity = UserInfoRoleEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userInfoRoleEntity.id = id;
  }
  final String? roleName = jsonConvert.convert<String>(json['roleName']);
  if (roleName != null) {
    userInfoRoleEntity.roleName = roleName;
  }
  return userInfoRoleEntity;
}

Map<String, dynamic> $UserInfoRoleEntityToJson(UserInfoRoleEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['roleName'] = entity.roleName;
  return data;
}

extension UserInfoRoleEntityExtension on UserInfoRoleEntity {
  UserInfoRoleEntity copyWith({
    int? id,
    String? roleName,
  }) {
    return UserInfoRoleEntity()
      ..id = id ?? this.id
      ..roleName = roleName ?? this.roleName;
  }
}