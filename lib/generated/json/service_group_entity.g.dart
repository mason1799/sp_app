import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/service_group_entity.dart';

ServiceGroupEntity $ServiceGroupEntityFromJson(Map<String, dynamic> json) {
  final ServiceGroupEntity serviceGroupEntity = ServiceGroupEntity();
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    serviceGroupEntity.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    serviceGroupEntity.groupName = groupName;
  }
  final String? departmentName = jsonConvert.convert<String>(json['departmentName']);
  if (departmentName != null) {
    serviceGroupEntity.departmentName = departmentName;
  }
  final String? employee = jsonConvert.convert<String>(json['employee']);
  if (employee != null) {
    serviceGroupEntity.employee = employee;
  }
  final int? equipmentNum = jsonConvert.convert<int>(json['equipmentNum']);
  if (equipmentNum != null) {
    serviceGroupEntity.equipmentNum = equipmentNum;
  }
  final List<ServiceGroupMember>? members = (json['members'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ServiceGroupMember>(e) as ServiceGroupMember).toList();
  if (members != null) {
    serviceGroupEntity.members = members;
  }
  return serviceGroupEntity;
}

Map<String, dynamic> $ServiceGroupEntityToJson(ServiceGroupEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['departmentName'] = entity.departmentName;
  data['employee'] = entity.employee;
  data['equipmentNum'] = entity.equipmentNum;
  data['members'] = entity.members?.map((v) => v.toJson()).toList();
  return data;
}

extension ServiceGroupEntityExtension on ServiceGroupEntity {
  ServiceGroupEntity copyWith({
    String? groupCode,
    String? groupName,
    String? departmentName,
    String? employee,
    int? equipmentNum,
    List<ServiceGroupMember>? members,
  }) {
    return ServiceGroupEntity()
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..departmentName = departmentName ?? this.departmentName
      ..employee = employee ?? this.employee
      ..equipmentNum = equipmentNum ?? this.equipmentNum
      ..members = members ?? this.members;
  }
}

ServiceGroupMember $ServiceGroupMemberFromJson(Map<String, dynamic> json) {
  final ServiceGroupMember serviceGroupMember = ServiceGroupMember();
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    serviceGroupMember.username = username;
  }
  final String? employeeCode = jsonConvert.convert<String>(json['employeeCode']);
  if (employeeCode != null) {
    serviceGroupMember.employeeCode = employeeCode;
  }
  return serviceGroupMember;
}

Map<String, dynamic> $ServiceGroupMemberToJson(ServiceGroupMember entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['username'] = entity.username;
  data['employeeCode'] = entity.employeeCode;
  return data;
}

extension ServiceGroupMemberExtension on ServiceGroupMember {
  ServiceGroupMember copyWith({
    String? username,
    String? employeeCode,
  }) {
    return ServiceGroupMember()
      ..username = username ?? this.username
      ..employeeCode = employeeCode ?? this.employeeCode;
  }
}