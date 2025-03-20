import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/validate_save_entity.dart';

ValidateSaveEntity $ValidateSaveEntityFromJson(Map<String, dynamic> json) {
  final ValidateSaveEntity validateSaveEntity = ValidateSaveEntity();
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    validateSaveEntity.projectName = projectName;
  }
  final String? equipmentNum = jsonConvert.convert<String>(json['equipmentNum']);
  if (equipmentNum != null) {
    validateSaveEntity.equipmentNum = equipmentNum;
  }
  final bool? deptChangeWarning = jsonConvert.convert<bool>(json['deptChangeWarning']);
  if (deptChangeWarning != null) {
    validateSaveEntity.deptChangeWarning = deptChangeWarning;
  }
  final String? deptChangeWarningMsg = jsonConvert.convert<String>(json['deptChangeWarningMsg']);
  if (deptChangeWarningMsg != null) {
    validateSaveEntity.deptChangeWarningMsg = deptChangeWarningMsg;
  }
  final bool? inRespWarning = jsonConvert.convert<bool>(json['inRespWarning']);
  if (inRespWarning != null) {
    validateSaveEntity.inRespWarning = inRespWarning;
  }
  final String? inRespWarningMsg = jsonConvert.convert<String>(json['inRespWarningMsg']);
  if (inRespWarningMsg != null) {
    validateSaveEntity.inRespWarningMsg = inRespWarningMsg;
  }
  final bool? leaveWarning = jsonConvert.convert<bool>(json['leaveWarning']);
  if (leaveWarning != null) {
    validateSaveEntity.leaveWarning = leaveWarning;
  }
  final String? leaveWarningMsg = jsonConvert.convert<String>(json['leaveWarningMsg']);
  if (leaveWarningMsg != null) {
    validateSaveEntity.leaveWarningMsg = leaveWarningMsg;
  }
  return validateSaveEntity;
}

Map<String, dynamic> $ValidateSaveEntityToJson(ValidateSaveEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['projectName'] = entity.projectName;
  data['equipmentNum'] = entity.equipmentNum;
  data['deptChangeWarning'] = entity.deptChangeWarning;
  data['deptChangeWarningMsg'] = entity.deptChangeWarningMsg;
  data['inRespWarning'] = entity.inRespWarning;
  data['inRespWarningMsg'] = entity.inRespWarningMsg;
  data['leaveWarning'] = entity.leaveWarning;
  data['leaveWarningMsg'] = entity.leaveWarningMsg;
  return data;
}

extension ValidateSaveEntityExtension on ValidateSaveEntity {
  ValidateSaveEntity copyWith({
    String? projectName,
    String? equipmentNum,
    bool? deptChangeWarning,
    String? deptChangeWarningMsg,
    bool? inRespWarning,
    String? inRespWarningMsg,
    bool? leaveWarning,
    String? leaveWarningMsg,
  }) {
    return ValidateSaveEntity()
      ..projectName = projectName ?? this.projectName
      ..equipmentNum = equipmentNum ?? this.equipmentNum
      ..deptChangeWarning = deptChangeWarning ?? this.deptChangeWarning
      ..deptChangeWarningMsg = deptChangeWarningMsg ?? this.deptChangeWarningMsg
      ..inRespWarning = inRespWarning ?? this.inRespWarning
      ..inRespWarningMsg = inRespWarningMsg ?? this.inRespWarningMsg
      ..leaveWarning = leaveWarning ?? this.leaveWarning
      ..leaveWarningMsg = leaveWarningMsg ?? this.leaveWarningMsg;
  }
}