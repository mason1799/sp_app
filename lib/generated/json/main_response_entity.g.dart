import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/main_response_entity.dart';

MainResponseEntity $MainResponseEntityFromJson(Map<String, dynamic> json) {
  final MainResponseEntity mainResponseEntity = MainResponseEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    mainResponseEntity.id = id;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    mainResponseEntity.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    mainResponseEntity.groupName = groupName;
  }
  final List<MainResponseMember>? memberList = (json['memberList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MainResponseMember>(e) as MainResponseMember).toList();
  if (memberList != null) {
    mainResponseEntity.memberList = memberList;
  }
  return mainResponseEntity;
}

Map<String, dynamic> $MainResponseEntityToJson(MainResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['memberList'] = entity.memberList?.map((v) => v.toJson()).toList();
  return data;
}

extension MainResponseEntityExtension on MainResponseEntity {
  MainResponseEntity copyWith({
    int? id,
    String? groupCode,
    String? groupName,
    List<MainResponseMember>? memberList,
  }) {
    return MainResponseEntity()
      ..id = id ?? this.id
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..memberList = memberList ?? this.memberList;
  }
}

MainResponseMember $MainResponseMemberFromJson(Map<String, dynamic> json) {
  final MainResponseMember mainResponseMember = MainResponseMember();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    mainResponseMember.id = id;
  }
  final String? employeeCode = jsonConvert.convert<String>(json['employeeCode']);
  if (employeeCode != null) {
    mainResponseMember.employeeCode = employeeCode;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    mainResponseMember.username = username;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    mainResponseMember.phone = phone;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    mainResponseMember.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    mainResponseMember.groupName = groupName;
  }
  return mainResponseMember;
}

Map<String, dynamic> $MainResponseMemberToJson(MainResponseMember entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['employeeCode'] = entity.employeeCode;
  data['username'] = entity.username;
  data['phone'] = entity.phone;
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  return data;
}

extension MainResponseMemberExtension on MainResponseMember {
  MainResponseMember copyWith({
    int? id,
    String? employeeCode,
    String? username,
    String? phone,
    String? groupCode,
    String? groupName,
  }) {
    return MainResponseMember()
      ..id = id ?? this.id
      ..employeeCode = employeeCode ?? this.employeeCode
      ..username = username ?? this.username
      ..phone = phone ?? this.phone
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName;
  }
}