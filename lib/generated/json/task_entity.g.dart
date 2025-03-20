import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/task_entity.dart';

TaskEntity $TaskEntityFromJson(Map<String, dynamic> json) {
  final TaskEntity taskEntity = TaskEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    taskEntity.id = id;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    taskEntity.orderType = orderType;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    taskEntity.projectName = projectName;
  }
  final String? arrangeName = jsonConvert.convert<String>(json['arrangeName']);
  if (arrangeName != null) {
    taskEntity.arrangeName = arrangeName;
  }
  final String? buildingCode = jsonConvert.convert<String>(json['buildingCode']);
  if (buildingCode != null) {
    taskEntity.buildingCode = buildingCode;
  }
  final String? elevatorCode = jsonConvert.convert<String>(json['elevatorCode']);
  if (elevatorCode != null) {
    taskEntity.elevatorCode = elevatorCode;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    taskEntity.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    taskEntity.groupName = groupName;
  }
  final String? orderModul = jsonConvert.convert<String>(json['orderModul']);
  if (orderModul != null) {
    taskEntity.orderModul = orderModul;
  }
  final String? mainResponseUserName = jsonConvert.convert<String>(json['mainResponseUserName']);
  if (mainResponseUserName != null) {
    taskEntity.mainResponseUserName = mainResponseUserName;
  }
  final String? equipmentCode = jsonConvert.convert<String>(json['equipmentCode']);
  if (equipmentCode != null) {
    taskEntity.equipmentCode = equipmentCode;
  }
  final int? mainResponseUserId = jsonConvert.convert<int>(json['mainResponseUserId']);
  if (mainResponseUserId != null) {
    taskEntity.mainResponseUserId = mainResponseUserId;
  }
  final int? mainMaintainerUserId = jsonConvert.convert<int>(json['mainMaintainerUserId']);
  if (mainMaintainerUserId != null) {
    taskEntity.mainMaintainerUserId = mainMaintainerUserId;
  }
  final int? state = jsonConvert.convert<int>(json['state']);
  if (state != null) {
    taskEntity.state = state;
  }
  final int? startTime = jsonConvert.convert<int>(json['startTime']);
  if (startTime != null) {
    taskEntity.startTime = startTime;
  }
  final int? equipmentTypeCode = jsonConvert.convert<int>(json['equipmentTypeCode']);
  if (equipmentTypeCode != null) {
    taskEntity.equipmentTypeCode = equipmentTypeCode;
  }
  final String? repairTimeStr = jsonConvert.convert<String>(json['repairTimeStr']);
  if (repairTimeStr != null) {
    taskEntity.repairTimeStr = repairTimeStr;
  }
  final int? faultRepairType = jsonConvert.convert<int>(json['faultRepairType']);
  if (faultRepairType != null) {
    taskEntity.faultRepairType = faultRepairType;
  }
  return taskEntity;
}

Map<String, dynamic> $TaskEntityToJson(TaskEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['orderType'] = entity.orderType;
  data['projectName'] = entity.projectName;
  data['arrangeName'] = entity.arrangeName;
  data['buildingCode'] = entity.buildingCode;
  data['elevatorCode'] = entity.elevatorCode;
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['orderModul'] = entity.orderModul;
  data['mainResponseUserName'] = entity.mainResponseUserName;
  data['equipmentCode'] = entity.equipmentCode;
  data['mainResponseUserId'] = entity.mainResponseUserId;
  data['mainMaintainerUserId'] = entity.mainMaintainerUserId;
  data['state'] = entity.state;
  data['startTime'] = entity.startTime;
  data['equipmentTypeCode'] = entity.equipmentTypeCode;
  data['repairTimeStr'] = entity.repairTimeStr;
  data['faultRepairType'] = entity.faultRepairType;
  return data;
}

extension TaskEntityExtension on TaskEntity {
  TaskEntity copyWith({
    int? id,
    int? orderType,
    String? projectName,
    String? arrangeName,
    String? buildingCode,
    String? elevatorCode,
    String? groupCode,
    String? groupName,
    String? orderModul,
    String? mainResponseUserName,
    String? equipmentCode,
    int? mainResponseUserId,
    int? mainMaintainerUserId,
    int? state,
    int? startTime,
    int? equipmentTypeCode,
    String? repairTimeStr,
    int? faultRepairType,
  }) {
    return TaskEntity()
      ..id = id ?? this.id
      ..orderType = orderType ?? this.orderType
      ..projectName = projectName ?? this.projectName
      ..arrangeName = arrangeName ?? this.arrangeName
      ..buildingCode = buildingCode ?? this.buildingCode
      ..elevatorCode = elevatorCode ?? this.elevatorCode
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..orderModul = orderModul ?? this.orderModul
      ..mainResponseUserName = mainResponseUserName ?? this.mainResponseUserName
      ..equipmentCode = equipmentCode ?? this.equipmentCode
      ..mainResponseUserId = mainResponseUserId ?? this.mainResponseUserId
      ..mainMaintainerUserId = mainMaintainerUserId ?? this.mainMaintainerUserId
      ..state = state ?? this.state
      ..startTime = startTime ?? this.startTime
      ..equipmentTypeCode = equipmentTypeCode ?? this.equipmentTypeCode
      ..repairTimeStr = repairTimeStr ?? this.repairTimeStr
      ..faultRepairType = faultRepairType ?? this.faultRepairType;
  }
}

TaskGroup $TaskGroupFromJson(Map<String, dynamic> json) {
  final TaskGroup taskGroup = TaskGroup();
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    taskGroup.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    taskGroup.groupName = groupName;
  }
  final List<TaskEntity>? orders = (json['orders'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TaskEntity>(e) as TaskEntity).toList();
  if (orders != null) {
    taskGroup.orders = orders;
  }
  final List<TaskMember>? employees = (json['employees'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TaskMember>(e) as TaskMember).toList();
  if (employees != null) {
    taskGroup.employees = employees;
  }
  final List<TaskProject>? projects = (json['projects'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TaskProject>(e) as TaskProject).toList();
  if (projects != null) {
    taskGroup.projects = projects;
  }
  return taskGroup;
}

Map<String, dynamic> $TaskGroupToJson(TaskGroup entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['orders'] = entity.orders?.map((v) => v.toJson()).toList();
  data['employees'] = entity.employees?.map((v) => v.toJson()).toList();
  data['projects'] = entity.projects?.map((v) => v.toJson()).toList();
  return data;
}

extension TaskGroupExtension on TaskGroup {
  TaskGroup copyWith({
    String? groupCode,
    String? groupName,
    List<TaskEntity>? orders,
    List<TaskMember>? employees,
    List<TaskProject>? projects,
  }) {
    return TaskGroup()
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..orders = orders ?? this.orders
      ..employees = employees ?? this.employees
      ..projects = projects ?? this.projects;
  }
}

TaskMember $TaskMemberFromJson(Map<String, dynamic> json) {
  final TaskMember taskMember = TaskMember();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    taskMember.id = id;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    taskMember.username = username;
  }
  final bool? leader = jsonConvert.convert<bool>(json['leader']);
  if (leader != null) {
    taskMember.leader = leader;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    taskMember.avatar = avatar;
  }
  final int? awaitFinish = jsonConvert.convert<int>(json['awaitFinish']);
  if (awaitFinish != null) {
    taskMember.awaitFinish = awaitFinish;
  }
  final int? response = jsonConvert.convert<int>(json['response']);
  if (response != null) {
    taskMember.response = response;
  }
  final int? finish = jsonConvert.convert<int>(json['finish']);
  if (finish != null) {
    taskMember.finish = finish;
  }
  return taskMember;
}

Map<String, dynamic> $TaskMemberToJson(TaskMember entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['leader'] = entity.leader;
  data['avatar'] = entity.avatar;
  data['awaitFinish'] = entity.awaitFinish;
  data['response'] = entity.response;
  data['finish'] = entity.finish;
  return data;
}

extension TaskMemberExtension on TaskMember {
  TaskMember copyWith({
    String? id,
    String? username,
    bool? leader,
    String? avatar,
    int? awaitFinish,
    int? response,
    int? finish,
  }) {
    return TaskMember()
      ..id = id ?? this.id
      ..username = username ?? this.username
      ..leader = leader ?? this.leader
      ..avatar = avatar ?? this.avatar
      ..awaitFinish = awaitFinish ?? this.awaitFinish
      ..response = response ?? this.response
      ..finish = finish ?? this.finish;
  }
}

TaskProject $TaskProjectFromJson(Map<String, dynamic> json) {
  final TaskProject taskProject = TaskProject();
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    taskProject.projectName = projectName;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    taskProject.projectLocation = projectLocation;
  }
  final int? awaitFinish = jsonConvert.convert<int>(json['awaitFinish']);
  if (awaitFinish != null) {
    taskProject.awaitFinish = awaitFinish;
  }
  final int? response = jsonConvert.convert<int>(json['response']);
  if (response != null) {
    taskProject.response = response;
  }
  final int? finish = jsonConvert.convert<int>(json['finish']);
  if (finish != null) {
    taskProject.finish = finish;
  }
  return taskProject;
}

Map<String, dynamic> $TaskProjectToJson(TaskProject entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['projectName'] = entity.projectName;
  data['projectLocation'] = entity.projectLocation;
  data['awaitFinish'] = entity.awaitFinish;
  data['response'] = entity.response;
  data['finish'] = entity.finish;
  return data;
}

extension TaskProjectExtension on TaskProject {
  TaskProject copyWith({
    String? projectName,
    String? projectLocation,
    int? awaitFinish,
    int? response,
    int? finish,
  }) {
    return TaskProject()
      ..projectName = projectName ?? this.projectName
      ..projectLocation = projectLocation ?? this.projectLocation
      ..awaitFinish = awaitFinish ?? this.awaitFinish
      ..response = response ?? this.response
      ..finish = finish ?? this.finish;
  }
}

MyTaskEntity $MyTaskEntityFromJson(Map<String, dynamic> json) {
  final MyTaskEntity myTaskEntity = MyTaskEntity();
  final List<int>? unfinished = (json['unfinished'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (unfinished != null) {
    myTaskEntity.unfinished = unfinished;
  }
  final List<int>? pending = (json['pending'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (pending != null) {
    myTaskEntity.pending = pending;
  }
  return myTaskEntity;
}

Map<String, dynamic> $MyTaskEntityToJson(MyTaskEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['unfinished'] = entity.unfinished;
  data['pending'] = entity.pending;
  return data;
}

extension MyTaskEntityExtension on MyTaskEntity {
  MyTaskEntity copyWith({
    List<int>? unfinished,
    List<int>? pending,
  }) {
    return MyTaskEntity()
      ..unfinished = unfinished ?? this.unfinished
      ..pending = pending ?? this.pending;
  }
}

GroupDetailEntity $GroupDetailEntityFromJson(Map<String, dynamic> json) {
  final GroupDetailEntity groupDetailEntity = GroupDetailEntity();
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    groupDetailEntity.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    groupDetailEntity.groupName = groupName;
  }
  final String? employee = jsonConvert.convert<String>(json['employee']);
  if (employee != null) {
    groupDetailEntity.employee = employee;
  }
  final int? awaitFinish = jsonConvert.convert<int>(json['awaitFinish']);
  if (awaitFinish != null) {
    groupDetailEntity.awaitFinish = awaitFinish;
  }
  final int? response = jsonConvert.convert<int>(json['response']);
  if (response != null) {
    groupDetailEntity.response = response;
  }
  final int? finish = jsonConvert.convert<int>(json['finish']);
  if (finish != null) {
    groupDetailEntity.finish = finish;
  }
  return groupDetailEntity;
}

Map<String, dynamic> $GroupDetailEntityToJson(GroupDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['employee'] = entity.employee;
  data['awaitFinish'] = entity.awaitFinish;
  data['response'] = entity.response;
  data['finish'] = entity.finish;
  return data;
}

extension GroupDetailEntityExtension on GroupDetailEntity {
  GroupDetailEntity copyWith({
    String? groupCode,
    String? groupName,
    String? employee,
    int? awaitFinish,
    int? response,
    int? finish,
  }) {
    return GroupDetailEntity()
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..employee = employee ?? this.employee
      ..awaitFinish = awaitFinish ?? this.awaitFinish
      ..response = response ?? this.response
      ..finish = finish ?? this.finish;
  }
}

GroupListRootEntity $GroupListRootEntityFromJson(Map<String, dynamic> json) {
  final GroupListRootEntity groupListRootEntity = GroupListRootEntity();
  final int? awaitFinish = jsonConvert.convert<int>(json['awaitFinish']);
  if (awaitFinish != null) {
    groupListRootEntity.awaitFinish = awaitFinish;
  }
  final int? response = jsonConvert.convert<int>(json['response']);
  if (response != null) {
    groupListRootEntity.response = response;
  }
  final int? finish = jsonConvert.convert<int>(json['finish']);
  if (finish != null) {
    groupListRootEntity.finish = finish;
  }
  final List<TaskEntity>? orders = (json['orders'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TaskEntity>(e) as TaskEntity).toList();
  if (orders != null) {
    groupListRootEntity.orders = orders;
  }
  return groupListRootEntity;
}

Map<String, dynamic> $GroupListRootEntityToJson(GroupListRootEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['awaitFinish'] = entity.awaitFinish;
  data['response'] = entity.response;
  data['finish'] = entity.finish;
  data['orders'] = entity.orders?.map((v) => v.toJson()).toList();
  return data;
}

extension GroupListRootEntityExtension on GroupListRootEntity {
  GroupListRootEntity copyWith({
    int? awaitFinish,
    int? response,
    int? finish,
    List<TaskEntity>? orders,
  }) {
    return GroupListRootEntity()
      ..awaitFinish = awaitFinish ?? this.awaitFinish
      ..response = response ?? this.response
      ..finish = finish ?? this.finish
      ..orders = orders ?? this.orders;
  }
}