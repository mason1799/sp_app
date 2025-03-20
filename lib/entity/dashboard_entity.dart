import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/dashboard_entity.g.dart';

@JsonSerializable()
class DashboardEntity {
  DashboardProjectInfo? projectInfo;
  DashboardFaultRepair? faultRepairInfo;
  DashboardToDoOrder? toDoOrderInfo;
  DashboardTodayWork? todayWorkSimpleInfo;
  int? clientUnSignSum;
  int? safetyOfficerUnSignSum;

  DashboardEntity();

  factory DashboardEntity.fromJson(Map<String, dynamic> json) => $DashboardEntityFromJson(json);

  Map<String, dynamic> toJson() => $DashboardEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardProjectInfo {
  int? projectSum;
  int? equipmentSum;
  int? iotNum;

  DashboardProjectInfo();

  factory DashboardProjectInfo.fromJson(Map<String, dynamic> json) => $DashboardProjectInfoFromJson(json);

  Map<String, dynamic> toJson() => $DashboardProjectInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardFaultRepair {
  int? normalRunningSum;
  int? maintenanceingSum;
  int? repairingSum;
  int? trappedSum;
  int? stopOverDaySum;

  DashboardFaultRepair();

  factory DashboardFaultRepair.fromJson(Map<String, dynamic> json) => $DashboardFaultRepairFromJson(json);

  Map<String, dynamic> toJson() => $DashboardFaultRepairToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardToDoOrder {
  int? faultRepairSum;
  int? routineMaintenanceSum;

  DashboardToDoOrder();

  factory DashboardToDoOrder.fromJson(Map<String, dynamic> json) => $DashboardToDoOrderFromJson(json);

  Map<String, dynamic> toJson() => $DashboardToDoOrderToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DashboardTodayWork {
  int? faultRepairUnfinishedSum;
  int? maintenanceUnfinishedSum;

  DashboardTodayWork();

  factory DashboardTodayWork.fromJson(Map<String, dynamic> json) => $DashboardTodayWorkFromJson(json);

  Map<String, dynamic> toJson() => $DashboardTodayWorkToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
