import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/fix_detail_entity.g.dart';

@JsonSerializable()
class FixDetailEntity {
  int? id;
  String? orderNumber;
  int? orderState;
  int? equipmentId;
  String? equipmentCode;
  int? faultRepairType; //1困人 2普通
  String? faultDesc;
  int? mainResponseUserId;
  String? mainResponseUserName;
  String? groupCode;
  String? groupName;
  String? repairman;
  int? repairRole;
  String? repairTime;
  String? assistEmployee;
  List<String?>? assistSignatureImage;
  List<FixDetailAssistEmployee>? assistEmployees;
  String? repairPhone;
  String? signInTime;
  String? signInLocation;
  double? signInDistance;
  String? arriveEquipmentState;
  String? leaveEquipmentState;
  String? faultCause;
  String? faultDisposalAction;
  String? faultParts;
  String? updateParts;
  int? updatePartsCount;
  int? trappedCount;
  int? trappedMinutes;
  String? escapeMode;
  String? complaintDetails;
  String? remark;
  List<String>? remarkImages;
  String? signOutTime;
  String? signOutLocation;
  double? signOutDistance;
  String? signatureImage;
  String? projectCode;
  String? projectName;
  String? projectLocation;
  double? longitude;
  double? latitude;
  String? buildingCode;
  String? elevatorCode;
  int? equipmentType;
  String? equipmentTypeName;
  int? mainRepairerUserId;
  String? mainRepairerUserName;
  String? stopTime;
  int? flow;
  bool? isKceEquipment;

  FixDetailEntity();

  factory FixDetailEntity.fromJson(Map<String, dynamic> json) => $FixDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $FixDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  String? get repairRoleName {
    // 1业主，2乘客，3甲方或物业工作人员，4维保员工，5其他
    if (repairRole == 1) {
      return '业主';
    } else if (repairRole == 2) {
      return '乘客';
    } else if (repairRole == 3) {
      return '甲方或物业工作人员';
    } else if (repairRole == 4) {
      return '维保员工';
    } else if (repairRole == 5) {
      return '其他';
    }
    return null;
  }
}

@JsonSerializable()
class FixDetailAssistEmployee {
  int? userId;
  String? employeeCode;
  String? username;
  String? phone;
  String? groupCode;
  String? groupName;
  String? signatureImage;

  FixDetailAssistEmployee();

  factory FixDetailAssistEmployee.fromJson(Map<String, dynamic> json) => $FixDetailAssistEmployeeFromJson(json);

  Map<String, dynamic> toJson() => $FixDetailAssistEmployeeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
