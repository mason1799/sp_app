import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/task_list_entity.dart';
import 'package:konesp/entity/task_entity.dart';


TaskListEntity $TaskListEntityFromJson(Map<String, dynamic> json) {
  final TaskListEntity taskListEntity = TaskListEntity();
  final List<TaskEntity>? orders = (json['orders'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TaskEntity>(e) as TaskEntity).toList();
  if (orders != null) {
    taskListEntity.orders = orders;
  }
  final int? orderNum = jsonConvert.convert<int>(json['orderNum']);
  if (orderNum != null) {
    taskListEntity.orderNum = orderNum;
  }
  final int? repairOrderNum = jsonConvert.convert<int>(json['repairOrderNum']);
  if (repairOrderNum != null) {
    taskListEntity.repairOrderNum = repairOrderNum;
  }
  return taskListEntity;
}

Map<String, dynamic> $TaskListEntityToJson(TaskListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orders'] = entity.orders?.map((v) => v.toJson()).toList();
  data['orderNum'] = entity.orderNum;
  data['repairOrderNum'] = entity.repairOrderNum;
  return data;
}

extension TaskListEntityExtension on TaskListEntity {
  TaskListEntity copyWith({
    List<TaskEntity>? orders,
    int? orderNum,
    int? repairOrderNum,
  }) {
    return TaskListEntity()
      ..orders = orders ?? this.orders
      ..orderNum = orderNum ?? this.orderNum
      ..repairOrderNum = repairOrderNum ?? this.repairOrderNum;
  }
}