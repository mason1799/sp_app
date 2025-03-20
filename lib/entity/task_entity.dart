import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/task_entity.g.dart';

@JsonSerializable()
class TaskEntity {
  int? id;

  /// 工单类型
  int? orderType; // 1 保养 2 故障

  /// 项目名称
  String? projectName;

  /// 编排方案名称
  String? arrangeName;

  /// 楼号
  String? buildingCode;

  /// 梯号
  String? elevatorCode;

  /// 维保组编号
  String? groupCode;

  /// 维保组名称
  String? groupName;

  /// 工单模块
  String? orderModul;

  ///主响应人姓名
  String? mainResponseUserName;

  /// 设备编号
  String? equipmentCode;

  /// 主响应人ID
  int? mainResponseUserId;

  /// 主保养人ID
  int? mainMaintainerUserId;

  /// 0未下发 、1未响应 、2响应中 、3已完成 、4已取消
  int? state;

  int? startTime;

  /// 设备类型
  int? equipmentTypeCode;

  /// 报修时间
  String? repairTimeStr;

  /// 故障工单是否困人或普通
  int? faultRepairType;

  /// 0未下发 、1未响应 、2响应中 、3已完成 、4已取消
  String get stateValue {
    switch (state) {
      case 1:
        return '未响应';
      case 2:
        return '响应中';
      case 3:
        return '已完成';
      case 4:
        return '已取消';
      default:
        return '未下发';
    }
  }

  TaskEntity();

  factory TaskEntity.fromJson(Map<String, dynamic> json) => $TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => $TaskEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

/// 维保组
@JsonSerializable()
class TaskGroup {
  String? groupCode;
  String? groupName;
  List<TaskEntity>? orders; // 无保养人工单
  List<TaskMember>? employees; // 组员
  List<TaskProject>? projects; // 项目

  TaskGroup();

  factory TaskGroup.fromJson(Map<String, dynamic> json) => $TaskGroupFromJson(json);

  Map<String, dynamic> toJson() => $TaskGroupToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TaskMember {
  String? id;
  String? username;
  bool? leader;
  String? avatar;
  int? awaitFinish;
  int? response;
  int? finish;

  TaskMember();

  factory TaskMember.fromJson(Map<String, dynamic> json) => $TaskMemberFromJson(json);

  Map<String, dynamic> toJson() => $TaskMemberToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TaskProject {
  String? projectName;
  String? projectLocation;
  int? awaitFinish;
  int? response;
  int? finish;

  TaskProject();

  factory TaskProject.fromJson(Map<String, dynamic> json) => $TaskProjectFromJson(json);

  Map<String, dynamic> toJson() => $TaskProjectToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MyTaskEntity {
  List<int>? unfinished;
  List<int>? pending;

  MyTaskEntity();

  factory MyTaskEntity.fromJson(Map<String, dynamic> json) => $MyTaskEntityFromJson(json);

  Map<String, dynamic> toJson() => $MyTaskEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class GroupDetailEntity {
  String? groupCode;
  String? groupName;
  String? employee;
  int? awaitFinish;
  int? response;
  int? finish;

  GroupDetailEntity();

  factory GroupDetailEntity.fromJson(Map<String, dynamic> json) => $GroupDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $GroupDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class GroupListRootEntity {
  int? awaitFinish;
  int? response;
  int? finish;
  List<TaskEntity>? orders;

  GroupListRootEntity();

  factory GroupListRootEntity.fromJson(Map<String, dynamic> json) => $GroupListRootEntityFromJson(json);

  Map<String, dynamic> toJson() => $GroupListRootEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}