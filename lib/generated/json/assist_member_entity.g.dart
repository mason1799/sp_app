import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/assist_member_entity.dart';

AssistMemberEntity $AssistMemberEntityFromJson(Map<String, dynamic> json) {
  final AssistMemberEntity assistMemberEntity = AssistMemberEntity();
  final String? employeeCode = jsonConvert.convert<String>(json['employeeCode']);
  if (employeeCode != null) {
    assistMemberEntity.employeeCode = employeeCode;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    assistMemberEntity.username = username;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    assistMemberEntity.phone = phone;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    assistMemberEntity.groupCode = groupCode;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    assistMemberEntity.userId = userId;
  }
  return assistMemberEntity;
}

Map<String, dynamic> $AssistMemberEntityToJson(AssistMemberEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['employeeCode'] = entity.employeeCode;
  data['username'] = entity.username;
  data['phone'] = entity.phone;
  data['groupCode'] = entity.groupCode;
  data['userId'] = entity.userId;
  return data;
}

extension AssistMemberEntityExtension on AssistMemberEntity {
  AssistMemberEntity copyWith({
    String? employeeCode,
    String? username,
    String? phone,
    String? groupCode,
    int? userId,
  }) {
    return AssistMemberEntity()
      ..employeeCode = employeeCode ?? this.employeeCode
      ..username = username ?? this.username
      ..phone = phone ?? this.phone
      ..groupCode = groupCode ?? this.groupCode
      ..userId = userId ?? this.userId;
  }
}