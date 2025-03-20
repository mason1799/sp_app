import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/over_time_entity.dart';

OverTimeEntity $OverTimeEntityFromJson(Map<String, dynamic> json) {
  final OverTimeEntity overTimeEntity = OverTimeEntity();
  final int? adjustType = jsonConvert.convert<int>(json['adjustType']);
  if (adjustType != null) {
    overTimeEntity.adjustType = adjustType;
  }
  final int? dataType = jsonConvert.convert<int>(json['dataType']);
  if (dataType != null) {
    overTimeEntity.dataType = dataType;
  }
  final String? overdueStartDate = jsonConvert.convert<String>(json['overdueStartDate']);
  if (overdueStartDate != null) {
    overTimeEntity.overdueStartDate = overdueStartDate;
  }
  final String? overdueEndDate = jsonConvert.convert<String>(json['overdueEndDate']);
  if (overdueEndDate != null) {
    overTimeEntity.overdueEndDate = overdueEndDate;
  }
  final String? timeoutValue = jsonConvert.convert<String>(json['timeoutValue']);
  if (timeoutValue != null) {
    overTimeEntity.timeoutValue = timeoutValue;
  }
  final List<OverTimeModuleInfo>? moduleInfoList = (json['moduleInfoList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<OverTimeModuleInfo>(e) as OverTimeModuleInfo).toList();
  if (moduleInfoList != null) {
    overTimeEntity.moduleInfoList = moduleInfoList;
  }
  final List<OverTimeAdjustOrder>? adjustOrderList = (json['adjustOrderList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<OverTimeAdjustOrder>(e) as OverTimeAdjustOrder).toList();
  if (adjustOrderList != null) {
    overTimeEntity.adjustOrderList = adjustOrderList;
  }
  return overTimeEntity;
}

Map<String, dynamic> $OverTimeEntityToJson(OverTimeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['adjustType'] = entity.adjustType;
  data['dataType'] = entity.dataType;
  data['overdueStartDate'] = entity.overdueStartDate;
  data['overdueEndDate'] = entity.overdueEndDate;
  data['timeoutValue'] = entity.timeoutValue;
  data['moduleInfoList'] = entity.moduleInfoList?.map((v) => v.toJson()).toList();
  data['adjustOrderList'] = entity.adjustOrderList?.map((v) => v.toJson()).toList();
  return data;
}

extension OverTimeEntityExtension on OverTimeEntity {
  OverTimeEntity copyWith({
    int? adjustType,
    int? dataType,
    String? overdueStartDate,
    String? overdueEndDate,
    String? timeoutValue,
    List<OverTimeModuleInfo>? moduleInfoList,
    List<OverTimeAdjustOrder>? adjustOrderList,
  }) {
    return OverTimeEntity()
      ..adjustType = adjustType ?? this.adjustType
      ..dataType = dataType ?? this.dataType
      ..overdueStartDate = overdueStartDate ?? this.overdueStartDate
      ..overdueEndDate = overdueEndDate ?? this.overdueEndDate
      ..timeoutValue = timeoutValue ?? this.timeoutValue
      ..moduleInfoList = moduleInfoList ?? this.moduleInfoList
      ..adjustOrderList = adjustOrderList ?? this.adjustOrderList;
  }
}

OverTimeModuleInfo $OverTimeModuleInfoFromJson(Map<String, dynamic> json) {
  final OverTimeModuleInfo overTimeModuleInfo = OverTimeModuleInfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    overTimeModuleInfo.id = id;
  }
  final int? arrangeId = jsonConvert.convert<int>(json['arrangeId']);
  if (arrangeId != null) {
    overTimeModuleInfo.arrangeId = arrangeId;
  }
  final int? moduleId = jsonConvert.convert<int>(json['moduleId']);
  if (moduleId != null) {
    overTimeModuleInfo.moduleId = moduleId;
  }
  final String? moduleName = jsonConvert.convert<String>(json['moduleName']);
  if (moduleName != null) {
    overTimeModuleInfo.moduleName = moduleName;
  }
  return overTimeModuleInfo;
}

Map<String, dynamic> $OverTimeModuleInfoToJson(OverTimeModuleInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['arrangeId'] = entity.arrangeId;
  data['moduleId'] = entity.moduleId;
  data['moduleName'] = entity.moduleName;
  return data;
}

extension OverTimeModuleInfoExtension on OverTimeModuleInfo {
  OverTimeModuleInfo copyWith({
    int? id,
    int? arrangeId,
    int? moduleId,
    String? moduleName,
  }) {
    return OverTimeModuleInfo()
      ..id = id ?? this.id
      ..arrangeId = arrangeId ?? this.arrangeId
      ..moduleId = moduleId ?? this.moduleId
      ..moduleName = moduleName ?? this.moduleName;
  }
}

OverTimeAdjustOrder $OverTimeAdjustOrderFromJson(Map<String, dynamic> json) {
  final OverTimeAdjustOrder overTimeAdjustOrder = OverTimeAdjustOrder();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    overTimeAdjustOrder.id = id;
  }
  final String? overdueDateBegin = jsonConvert.convert<String>(json['overdueDateBegin']);
  if (overdueDateBegin != null) {
    overTimeAdjustOrder.overdueDateBegin = overdueDateBegin;
  }
  final String? overdueDateEnd = jsonConvert.convert<String>(json['overdueDateEnd']);
  if (overdueDateEnd != null) {
    overTimeAdjustOrder.overdueDateEnd = overdueDateEnd;
  }
  final bool? overdue = jsonConvert.convert<bool>(json['overdue']);
  if (overdue != null) {
    overTimeAdjustOrder.overdue = overdue;
  }
  return overTimeAdjustOrder;
}

Map<String, dynamic> $OverTimeAdjustOrderToJson(OverTimeAdjustOrder entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['overdueDateBegin'] = entity.overdueDateBegin;
  data['overdueDateEnd'] = entity.overdueDateEnd;
  data['overdue'] = entity.overdue;
  return data;
}

extension OverTimeAdjustOrderExtension on OverTimeAdjustOrder {
  OverTimeAdjustOrder copyWith({
    int? id,
    String? overdueDateBegin,
    String? overdueDateEnd,
    bool? overdue,
  }) {
    return OverTimeAdjustOrder()
      ..id = id ?? this.id
      ..overdueDateBegin = overdueDateBegin ?? this.overdueDateBegin
      ..overdueDateEnd = overdueDateEnd ?? this.overdueDateEnd
      ..overdue = overdue ?? this.overdue;
  }
}