import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/validate_save_entity.g.dart';

@JsonSerializable()
class ValidateSaveEntity {
  String? projectName;
  String? equipmentNum;
  bool? deptChangeWarning;
  String? deptChangeWarningMsg;
  bool? inRespWarning;
  String? inRespWarningMsg;
  bool? leaveWarning;
  String? leaveWarningMsg;

  ValidateSaveEntity();

  factory ValidateSaveEntity.fromJson(Map<String, dynamic> json) => $ValidateSaveEntityFromJson(json);

  Map<String, dynamic> toJson() => $ValidateSaveEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
