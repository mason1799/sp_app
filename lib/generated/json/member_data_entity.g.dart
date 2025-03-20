import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/member_data_entity.dart';

MemberDataEntity $MemberDataEntityFromJson(Map<String, dynamic> json) {
  final MemberDataEntity memberDataEntity = MemberDataEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    memberDataEntity.id = id;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    memberDataEntity.username = username;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    memberDataEntity.email = email;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    memberDataEntity.phone = phone;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    memberDataEntity.gender = gender;
  }
  final String? duty = jsonConvert.convert<String>(json['duty']);
  if (duty != null) {
    memberDataEntity.duty = duty;
  }
  final String? contractStartDate = jsonConvert.convert<String>(json['contractStartDate']);
  if (contractStartDate != null) {
    memberDataEntity.contractStartDate = contractStartDate;
  }
  final String? contractEndDate = jsonConvert.convert<String>(json['contractEndDate']);
  if (contractEndDate != null) {
    memberDataEntity.contractEndDate = contractEndDate;
  }
  final String? onTheJob = jsonConvert.convert<String>(json['onTheJob']);
  if (onTheJob != null) {
    memberDataEntity.onTheJob = onTheJob;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    memberDataEntity.avatar = avatar;
  }
  return memberDataEntity;
}

Map<String, dynamic> $MemberDataEntityToJson(MemberDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['email'] = entity.email;
  data['phone'] = entity.phone;
  data['gender'] = entity.gender;
  data['duty'] = entity.duty;
  data['contractStartDate'] = entity.contractStartDate;
  data['contractEndDate'] = entity.contractEndDate;
  data['onTheJob'] = entity.onTheJob;
  data['avatar'] = entity.avatar;
  return data;
}

extension MemberDataEntityExtension on MemberDataEntity {
  MemberDataEntity copyWith({
    int? id,
    String? username,
    String? email,
    String? phone,
    String? gender,
    String? duty,
    String? contractStartDate,
    String? contractEndDate,
    String? onTheJob,
    String? avatar,
  }) {
    return MemberDataEntity()
      ..id = id ?? this.id
      ..username = username ?? this.username
      ..email = email ?? this.email
      ..phone = phone ?? this.phone
      ..gender = gender ?? this.gender
      ..duty = duty ?? this.duty
      ..contractStartDate = contractStartDate ?? this.contractStartDate
      ..contractEndDate = contractEndDate ?? this.contractEndDate
      ..onTheJob = onTheJob ?? this.onTheJob
      ..avatar = avatar ?? this.avatar;
  }
}