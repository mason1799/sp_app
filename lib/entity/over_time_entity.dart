import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/over_time_entity.g.dart';

@JsonSerializable()
class OverTimeEntity {
  int? adjustType;
  int? dataType;
  String? overdueStartDate;
  String? overdueEndDate;
  String? timeoutValue;
  List<OverTimeModuleInfo>? moduleInfoList;
  List<OverTimeAdjustOrder>? adjustOrderList;

  OverTimeEntity();

  factory OverTimeEntity.fromJson(Map<String, dynamic> json) => $OverTimeEntityFromJson(json);

  Map<String, dynamic> toJson() => $OverTimeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OverTimeModuleInfo {
  int? id;
  int? arrangeId;
  int? moduleId;
  String? moduleName;

  OverTimeModuleInfo();

  factory OverTimeModuleInfo.fromJson(Map<String, dynamic> json) => $OverTimeModuleInfoFromJson(json);

  Map<String, dynamic> toJson() => $OverTimeModuleInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OverTimeAdjustOrder {
  int? id;
  String? overdueDateBegin;
  String? overdueDateEnd;
  bool? overdue;

  OverTimeAdjustOrder();

  factory OverTimeAdjustOrder.fromJson(Map<String, dynamic> json) => $OverTimeAdjustOrderFromJson(json);

  Map<String, dynamic> toJson() => $OverTimeAdjustOrderToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
