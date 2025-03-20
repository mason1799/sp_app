import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/task_list_entity.g.dart';

import 'package:konesp/entity/task_entity.dart';

@JsonSerializable()
class TaskListEntity {
  List<TaskEntity>? orders;
  int? orderNum;
  int? repairOrderNum;

  TaskListEntity();

  factory TaskListEntity.fromJson(Map<String, dynamic> json) => $TaskListEntityFromJson(json);

  Map<String, dynamic> toJson() => $TaskListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
