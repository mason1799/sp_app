import 'dart:convert';

import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/regular_detail_entity.g.dart';

@JsonSerializable()
class RegularDetailEntity {
  int? id;
  String? orderNumber;
  String? orderType;
  String? projectCode;
  String? projectName;
  String? projectLocation;
  String? arrangeName;
  String? assistEmployee;
  List<MainResponseMember>? assistEmployeeArr;
  String? mainResponseUserName;
  String? mainMaintainerUserName;
  String? startLocation;
  int? startDistance;
  String? endLocation;
  int? endDistance;
  String? buildingCode;
  String? elevatorCode;
  String? equipmentTypeName;
  String? equipmentCode;
  String? groupCode;
  String? groupName;
  String? orderModul;

  //0未下发 、1未响应 、2响应中 、3已完成 、4已取消、 5无法进场
  int? state;

  //步骤状态 1签到,2填写检查项,3签退,4提交工单,5签字
  int? stepState;
  int? checkTotalNum;
  int? unsuitableNum;
  int? repairNum;
  int? qualifiedNum;
  int? noQualifiedNum;
  String? remark;
  String? orderImage;
  bool? assist;
  int? startTime;
  int? endTime;
  bool? aheadReply;
  String? signatureImage;
  List<int>? modulId;
  double? longitude;
  double? latitude;
  String? mainResponseUserCode;
  int? mainResponseUserId;
  int? mainMaintainerUserId;
  bool? isShowClientSign;
  String? safetyOfficerApprovalBy;
  String? safetyOfficerSignatureImage;
  String? clientApprovalBy;
  String? clientSignatureImage;
  String? registerCode;
  String? code96333;
  bool? isKceEquipment;

  RegularDetailEntity();

  factory RegularDetailEntity.fromJson(Map<String, dynamic> json) => $RegularDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $RegularDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  int get totalNum {
    return (unsuitableNum ?? 0) + (repairNum ?? 0) + (qualifiedNum ?? 0) + (noQualifiedNum ?? 0);
  }
}
