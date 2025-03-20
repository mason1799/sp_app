import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/regular_order_process_entity.g.dart';

@JsonSerializable()
class RegularOrderProcessEntity {
  int? orderId;

  //步骤类型 1签到,2填写检查项,3签退,4提交工单,5响应人或辅助人员签字 6安全员签字 9客户签字
  int? type;
  String? username;
  String? phone;
  String? location;
  String? startImage;
  String? endImage;
  String? createTime;
  String? approvalReason;

  RegularOrderProcessEntity();

  factory RegularOrderProcessEntity.fromJson(Map<String, dynamic> json) => $RegularOrderProcessEntityFromJson(json);

  Map<String, dynamic> toJson() => $RegularOrderProcessEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
