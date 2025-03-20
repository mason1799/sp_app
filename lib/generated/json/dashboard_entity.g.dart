import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/dashboard_entity.dart';

DashboardEntity $DashboardEntityFromJson(Map<String, dynamic> json) {
  final DashboardEntity dashboardEntity = DashboardEntity();
  final DashboardProjectInfo? projectInfo = jsonConvert.convert<DashboardProjectInfo>(json['projectInfo']);
  if (projectInfo != null) {
    dashboardEntity.projectInfo = projectInfo;
  }
  final DashboardFaultRepair? faultRepairInfo = jsonConvert.convert<DashboardFaultRepair>(json['faultRepairInfo']);
  if (faultRepairInfo != null) {
    dashboardEntity.faultRepairInfo = faultRepairInfo;
  }
  final DashboardToDoOrder? toDoOrderInfo = jsonConvert.convert<DashboardToDoOrder>(json['toDoOrderInfo']);
  if (toDoOrderInfo != null) {
    dashboardEntity.toDoOrderInfo = toDoOrderInfo;
  }
  final DashboardTodayWork? todayWorkSimpleInfo = jsonConvert.convert<DashboardTodayWork>(json['todayWorkSimpleInfo']);
  if (todayWorkSimpleInfo != null) {
    dashboardEntity.todayWorkSimpleInfo = todayWorkSimpleInfo;
  }
  final int? clientUnSignSum = jsonConvert.convert<int>(json['clientUnSignSum']);
  if (clientUnSignSum != null) {
    dashboardEntity.clientUnSignSum = clientUnSignSum;
  }
  final int? safetyOfficerUnSignSum = jsonConvert.convert<int>(json['safetyOfficerUnSignSum']);
  if (safetyOfficerUnSignSum != null) {
    dashboardEntity.safetyOfficerUnSignSum = safetyOfficerUnSignSum;
  }
  return dashboardEntity;
}

Map<String, dynamic> $DashboardEntityToJson(DashboardEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['projectInfo'] = entity.projectInfo?.toJson();
  data['faultRepairInfo'] = entity.faultRepairInfo?.toJson();
  data['toDoOrderInfo'] = entity.toDoOrderInfo?.toJson();
  data['todayWorkSimpleInfo'] = entity.todayWorkSimpleInfo?.toJson();
  data['clientUnSignSum'] = entity.clientUnSignSum;
  data['safetyOfficerUnSignSum'] = entity.safetyOfficerUnSignSum;
  return data;
}

extension DashboardEntityExtension on DashboardEntity {
  DashboardEntity copyWith({
    DashboardProjectInfo? projectInfo,
    DashboardFaultRepair? faultRepairInfo,
    DashboardToDoOrder? toDoOrderInfo,
    DashboardTodayWork? todayWorkSimpleInfo,
    int? clientUnSignSum,
    int? safetyOfficerUnSignSum,
  }) {
    return DashboardEntity()
      ..projectInfo = projectInfo ?? this.projectInfo
      ..faultRepairInfo = faultRepairInfo ?? this.faultRepairInfo
      ..toDoOrderInfo = toDoOrderInfo ?? this.toDoOrderInfo
      ..todayWorkSimpleInfo = todayWorkSimpleInfo ?? this.todayWorkSimpleInfo
      ..clientUnSignSum = clientUnSignSum ?? this.clientUnSignSum
      ..safetyOfficerUnSignSum = safetyOfficerUnSignSum ?? this.safetyOfficerUnSignSum;
  }
}

DashboardProjectInfo $DashboardProjectInfoFromJson(Map<String, dynamic> json) {
  final DashboardProjectInfo dashboardProjectInfo = DashboardProjectInfo();
  final int? projectSum = jsonConvert.convert<int>(json['projectSum']);
  if (projectSum != null) {
    dashboardProjectInfo.projectSum = projectSum;
  }
  final int? equipmentSum = jsonConvert.convert<int>(json['equipmentSum']);
  if (equipmentSum != null) {
    dashboardProjectInfo.equipmentSum = equipmentSum;
  }
  final int? iotNum = jsonConvert.convert<int>(json['iotNum']);
  if (iotNum != null) {
    dashboardProjectInfo.iotNum = iotNum;
  }
  return dashboardProjectInfo;
}

Map<String, dynamic> $DashboardProjectInfoToJson(DashboardProjectInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['projectSum'] = entity.projectSum;
  data['equipmentSum'] = entity.equipmentSum;
  data['iotNum'] = entity.iotNum;
  return data;
}

extension DashboardProjectInfoExtension on DashboardProjectInfo {
  DashboardProjectInfo copyWith({
    int? projectSum,
    int? equipmentSum,
    int? iotNum,
  }) {
    return DashboardProjectInfo()
      ..projectSum = projectSum ?? this.projectSum
      ..equipmentSum = equipmentSum ?? this.equipmentSum
      ..iotNum = iotNum ?? this.iotNum;
  }
}

DashboardFaultRepair $DashboardFaultRepairFromJson(Map<String, dynamic> json) {
  final DashboardFaultRepair dashboardFaultRepair = DashboardFaultRepair();
  final int? normalRunningSum = jsonConvert.convert<int>(json['normalRunningSum']);
  if (normalRunningSum != null) {
    dashboardFaultRepair.normalRunningSum = normalRunningSum;
  }
  final int? maintenanceingSum = jsonConvert.convert<int>(json['maintenanceingSum']);
  if (maintenanceingSum != null) {
    dashboardFaultRepair.maintenanceingSum = maintenanceingSum;
  }
  final int? repairingSum = jsonConvert.convert<int>(json['repairingSum']);
  if (repairingSum != null) {
    dashboardFaultRepair.repairingSum = repairingSum;
  }
  final int? trappedSum = jsonConvert.convert<int>(json['trappedSum']);
  if (trappedSum != null) {
    dashboardFaultRepair.trappedSum = trappedSum;
  }
  final int? stopOverDaySum = jsonConvert.convert<int>(json['stopOverDaySum']);
  if (stopOverDaySum != null) {
    dashboardFaultRepair.stopOverDaySum = stopOverDaySum;
  }
  return dashboardFaultRepair;
}

Map<String, dynamic> $DashboardFaultRepairToJson(DashboardFaultRepair entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['normalRunningSum'] = entity.normalRunningSum;
  data['maintenanceingSum'] = entity.maintenanceingSum;
  data['repairingSum'] = entity.repairingSum;
  data['trappedSum'] = entity.trappedSum;
  data['stopOverDaySum'] = entity.stopOverDaySum;
  return data;
}

extension DashboardFaultRepairExtension on DashboardFaultRepair {
  DashboardFaultRepair copyWith({
    int? normalRunningSum,
    int? maintenanceingSum,
    int? repairingSum,
    int? trappedSum,
    int? stopOverDaySum,
  }) {
    return DashboardFaultRepair()
      ..normalRunningSum = normalRunningSum ?? this.normalRunningSum
      ..maintenanceingSum = maintenanceingSum ?? this.maintenanceingSum
      ..repairingSum = repairingSum ?? this.repairingSum
      ..trappedSum = trappedSum ?? this.trappedSum
      ..stopOverDaySum = stopOverDaySum ?? this.stopOverDaySum;
  }
}

DashboardToDoOrder $DashboardToDoOrderFromJson(Map<String, dynamic> json) {
  final DashboardToDoOrder dashboardToDoOrder = DashboardToDoOrder();
  final int? faultRepairSum = jsonConvert.convert<int>(json['faultRepairSum']);
  if (faultRepairSum != null) {
    dashboardToDoOrder.faultRepairSum = faultRepairSum;
  }
  final int? routineMaintenanceSum = jsonConvert.convert<int>(json['routineMaintenanceSum']);
  if (routineMaintenanceSum != null) {
    dashboardToDoOrder.routineMaintenanceSum = routineMaintenanceSum;
  }
  return dashboardToDoOrder;
}

Map<String, dynamic> $DashboardToDoOrderToJson(DashboardToDoOrder entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['faultRepairSum'] = entity.faultRepairSum;
  data['routineMaintenanceSum'] = entity.routineMaintenanceSum;
  return data;
}

extension DashboardToDoOrderExtension on DashboardToDoOrder {
  DashboardToDoOrder copyWith({
    int? faultRepairSum,
    int? routineMaintenanceSum,
  }) {
    return DashboardToDoOrder()
      ..faultRepairSum = faultRepairSum ?? this.faultRepairSum
      ..routineMaintenanceSum = routineMaintenanceSum ?? this.routineMaintenanceSum;
  }
}

DashboardTodayWork $DashboardTodayWorkFromJson(Map<String, dynamic> json) {
  final DashboardTodayWork dashboardTodayWork = DashboardTodayWork();
  final int? faultRepairUnfinishedSum = jsonConvert.convert<int>(json['faultRepairUnfinishedSum']);
  if (faultRepairUnfinishedSum != null) {
    dashboardTodayWork.faultRepairUnfinishedSum = faultRepairUnfinishedSum;
  }
  final int? maintenanceUnfinishedSum = jsonConvert.convert<int>(json['maintenanceUnfinishedSum']);
  if (maintenanceUnfinishedSum != null) {
    dashboardTodayWork.maintenanceUnfinishedSum = maintenanceUnfinishedSum;
  }
  return dashboardTodayWork;
}

Map<String, dynamic> $DashboardTodayWorkToJson(DashboardTodayWork entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['faultRepairUnfinishedSum'] = entity.faultRepairUnfinishedSum;
  data['maintenanceUnfinishedSum'] = entity.maintenanceUnfinishedSum;
  return data;
}

extension DashboardTodayWorkExtension on DashboardTodayWork {
  DashboardTodayWork copyWith({
    int? faultRepairUnfinishedSum,
    int? maintenanceUnfinishedSum,
  }) {
    return DashboardTodayWork()
      ..faultRepairUnfinishedSum = faultRepairUnfinishedSum ?? this.faultRepairUnfinishedSum
      ..maintenanceUnfinishedSum = maintenanceUnfinishedSum ?? this.maintenanceUnfinishedSum;
  }
}