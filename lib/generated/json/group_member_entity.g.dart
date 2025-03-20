import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/group_member_entity.dart';

GroupMemberEntity $GroupMemberEntityFromJson(Map<String, dynamic> json) {
  final GroupMemberEntity groupMemberEntity = GroupMemberEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    groupMemberEntity.id = id;
  }
  final String? employeeCode = jsonConvert.convert<String>(json['employeeCode']);
  if (employeeCode != null) {
    groupMemberEntity.employeeCode = employeeCode;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    groupMemberEntity.username = username;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    groupMemberEntity.phone = phone;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    groupMemberEntity.userId = userId;
  }
  return groupMemberEntity;
}

Map<String, dynamic> $GroupMemberEntityToJson(GroupMemberEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['employeeCode'] = entity.employeeCode;
  data['username'] = entity.username;
  data['phone'] = entity.phone;
  data['userId'] = entity.userId;
  return data;
}

extension GroupMemberEntityExtension on GroupMemberEntity {
  GroupMemberEntity copyWith({
    int? id,
    String? employeeCode,
    String? username,
    String? phone,
    int? userId,
  }) {
    return GroupMemberEntity()
      ..id = id ?? this.id
      ..employeeCode = employeeCode ?? this.employeeCode
      ..username = username ?? this.username
      ..phone = phone ?? this.phone
      ..userId = userId ?? this.userId;
  }
}