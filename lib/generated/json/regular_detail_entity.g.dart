import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/regular_detail_entity.dart';
import 'package:konesp/entity/main_response_entity.dart';


RegularDetailEntity $RegularDetailEntityFromJson(Map<String, dynamic> json) {
  final RegularDetailEntity regularDetailEntity = RegularDetailEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    regularDetailEntity.id = id;
  }
  final String? orderNumber = jsonConvert.convert<String>(json['orderNumber']);
  if (orderNumber != null) {
    regularDetailEntity.orderNumber = orderNumber;
  }
  final String? orderType = jsonConvert.convert<String>(json['orderType']);
  if (orderType != null) {
    regularDetailEntity.orderType = orderType;
  }
  final String? projectCode = jsonConvert.convert<String>(json['projectCode']);
  if (projectCode != null) {
    regularDetailEntity.projectCode = projectCode;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    regularDetailEntity.projectName = projectName;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    regularDetailEntity.projectLocation = projectLocation;
  }
  final String? arrangeName = jsonConvert.convert<String>(json['arrangeName']);
  if (arrangeName != null) {
    regularDetailEntity.arrangeName = arrangeName;
  }
  final String? assistEmployee = jsonConvert.convert<String>(json['assistEmployee']);
  if (assistEmployee != null) {
    regularDetailEntity.assistEmployee = assistEmployee;
  }
  final List<MainResponseMember>? assistEmployeeArr = (json['assistEmployeeArr'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<MainResponseMember>(e) as MainResponseMember).toList();
  if (assistEmployeeArr != null) {
    regularDetailEntity.assistEmployeeArr = assistEmployeeArr;
  }
  final String? mainResponseUserName = jsonConvert.convert<String>(json['mainResponseUserName']);
  if (mainResponseUserName != null) {
    regularDetailEntity.mainResponseUserName = mainResponseUserName;
  }
  final String? mainMaintainerUserName = jsonConvert.convert<String>(json['mainMaintainerUserName']);
  if (mainMaintainerUserName != null) {
    regularDetailEntity.mainMaintainerUserName = mainMaintainerUserName;
  }
  final String? startLocation = jsonConvert.convert<String>(json['startLocation']);
  if (startLocation != null) {
    regularDetailEntity.startLocation = startLocation;
  }
  final int? startDistance = jsonConvert.convert<int>(json['startDistance']);
  if (startDistance != null) {
    regularDetailEntity.startDistance = startDistance;
  }
  final String? endLocation = jsonConvert.convert<String>(json['endLocation']);
  if (endLocation != null) {
    regularDetailEntity.endLocation = endLocation;
  }
  final int? endDistance = jsonConvert.convert<int>(json['endDistance']);
  if (endDistance != null) {
    regularDetailEntity.endDistance = endDistance;
  }
  final String? buildingCode = jsonConvert.convert<String>(json['buildingCode']);
  if (buildingCode != null) {
    regularDetailEntity.buildingCode = buildingCode;
  }
  final String? elevatorCode = jsonConvert.convert<String>(json['elevatorCode']);
  if (elevatorCode != null) {
    regularDetailEntity.elevatorCode = elevatorCode;
  }
  final String? equipmentTypeName = jsonConvert.convert<String>(json['equipmentTypeName']);
  if (equipmentTypeName != null) {
    regularDetailEntity.equipmentTypeName = equipmentTypeName;
  }
  final String? equipmentCode = jsonConvert.convert<String>(json['equipmentCode']);
  if (equipmentCode != null) {
    regularDetailEntity.equipmentCode = equipmentCode;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    regularDetailEntity.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    regularDetailEntity.groupName = groupName;
  }
  final String? orderModul = jsonConvert.convert<String>(json['orderModul']);
  if (orderModul != null) {
    regularDetailEntity.orderModul = orderModul;
  }
  final int? state = jsonConvert.convert<int>(json['state']);
  if (state != null) {
    regularDetailEntity.state = state;
  }
  final int? stepState = jsonConvert.convert<int>(json['stepState']);
  if (stepState != null) {
    regularDetailEntity.stepState = stepState;
  }
  final int? checkTotalNum = jsonConvert.convert<int>(json['checkTotalNum']);
  if (checkTotalNum != null) {
    regularDetailEntity.checkTotalNum = checkTotalNum;
  }
  final int? unsuitableNum = jsonConvert.convert<int>(json['unsuitableNum']);
  if (unsuitableNum != null) {
    regularDetailEntity.unsuitableNum = unsuitableNum;
  }
  final int? repairNum = jsonConvert.convert<int>(json['repairNum']);
  if (repairNum != null) {
    regularDetailEntity.repairNum = repairNum;
  }
  final int? qualifiedNum = jsonConvert.convert<int>(json['qualifiedNum']);
  if (qualifiedNum != null) {
    regularDetailEntity.qualifiedNum = qualifiedNum;
  }
  final int? noQualifiedNum = jsonConvert.convert<int>(json['noQualifiedNum']);
  if (noQualifiedNum != null) {
    regularDetailEntity.noQualifiedNum = noQualifiedNum;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    regularDetailEntity.remark = remark;
  }
  final String? orderImage = jsonConvert.convert<String>(json['orderImage']);
  if (orderImage != null) {
    regularDetailEntity.orderImage = orderImage;
  }
  final bool? assist = jsonConvert.convert<bool>(json['assist']);
  if (assist != null) {
    regularDetailEntity.assist = assist;
  }
  final int? startTime = jsonConvert.convert<int>(json['startTime']);
  if (startTime != null) {
    regularDetailEntity.startTime = startTime;
  }
  final int? endTime = jsonConvert.convert<int>(json['endTime']);
  if (endTime != null) {
    regularDetailEntity.endTime = endTime;
  }
  final bool? aheadReply = jsonConvert.convert<bool>(json['aheadReply']);
  if (aheadReply != null) {
    regularDetailEntity.aheadReply = aheadReply;
  }
  final String? signatureImage = jsonConvert.convert<String>(json['signatureImage']);
  if (signatureImage != null) {
    regularDetailEntity.signatureImage = signatureImage;
  }
  final List<int>? modulId = (json['modulId'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<int>(e) as int).toList();
  if (modulId != null) {
    regularDetailEntity.modulId = modulId;
  }
  final double? longitude = jsonConvert.convert<double>(json['longitude']);
  if (longitude != null) {
    regularDetailEntity.longitude = longitude;
  }
  final double? latitude = jsonConvert.convert<double>(json['latitude']);
  if (latitude != null) {
    regularDetailEntity.latitude = latitude;
  }
  final String? mainResponseUserCode = jsonConvert.convert<String>(json['mainResponseUserCode']);
  if (mainResponseUserCode != null) {
    regularDetailEntity.mainResponseUserCode = mainResponseUserCode;
  }
  final int? mainResponseUserId = jsonConvert.convert<int>(json['mainResponseUserId']);
  if (mainResponseUserId != null) {
    regularDetailEntity.mainResponseUserId = mainResponseUserId;
  }
  final int? mainMaintainerUserId = jsonConvert.convert<int>(json['mainMaintainerUserId']);
  if (mainMaintainerUserId != null) {
    regularDetailEntity.mainMaintainerUserId = mainMaintainerUserId;
  }
  final bool? isShowClientSign = jsonConvert.convert<bool>(json['isShowClientSign']);
  if (isShowClientSign != null) {
    regularDetailEntity.isShowClientSign = isShowClientSign;
  }
  final String? safetyOfficerApprovalBy = jsonConvert.convert<String>(json['safetyOfficerApprovalBy']);
  if (safetyOfficerApprovalBy != null) {
    regularDetailEntity.safetyOfficerApprovalBy = safetyOfficerApprovalBy;
  }
  final String? safetyOfficerSignatureImage = jsonConvert.convert<String>(json['safetyOfficerSignatureImage']);
  if (safetyOfficerSignatureImage != null) {
    regularDetailEntity.safetyOfficerSignatureImage = safetyOfficerSignatureImage;
  }
  final String? clientApprovalBy = jsonConvert.convert<String>(json['clientApprovalBy']);
  if (clientApprovalBy != null) {
    regularDetailEntity.clientApprovalBy = clientApprovalBy;
  }
  final String? clientSignatureImage = jsonConvert.convert<String>(json['clientSignatureImage']);
  if (clientSignatureImage != null) {
    regularDetailEntity.clientSignatureImage = clientSignatureImage;
  }
  final String? registerCode = jsonConvert.convert<String>(json['registerCode']);
  if (registerCode != null) {
    regularDetailEntity.registerCode = registerCode;
  }
  final String? code96333 = jsonConvert.convert<String>(json['code96333']);
  if (code96333 != null) {
    regularDetailEntity.code96333 = code96333;
  }
  final bool? isKceEquipment = jsonConvert.convert<bool>(json['isKceEquipment']);
  if (isKceEquipment != null) {
    regularDetailEntity.isKceEquipment = isKceEquipment;
  }
  return regularDetailEntity;
}

Map<String, dynamic> $RegularDetailEntityToJson(RegularDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['orderNumber'] = entity.orderNumber;
  data['orderType'] = entity.orderType;
  data['projectCode'] = entity.projectCode;
  data['projectName'] = entity.projectName;
  data['projectLocation'] = entity.projectLocation;
  data['arrangeName'] = entity.arrangeName;
  data['assistEmployee'] = entity.assistEmployee;
  data['assistEmployeeArr'] = entity.assistEmployeeArr?.map((v) => v.toJson()).toList();
  data['mainResponseUserName'] = entity.mainResponseUserName;
  data['mainMaintainerUserName'] = entity.mainMaintainerUserName;
  data['startLocation'] = entity.startLocation;
  data['startDistance'] = entity.startDistance;
  data['endLocation'] = entity.endLocation;
  data['endDistance'] = entity.endDistance;
  data['buildingCode'] = entity.buildingCode;
  data['elevatorCode'] = entity.elevatorCode;
  data['equipmentTypeName'] = entity.equipmentTypeName;
  data['equipmentCode'] = entity.equipmentCode;
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['orderModul'] = entity.orderModul;
  data['state'] = entity.state;
  data['stepState'] = entity.stepState;
  data['checkTotalNum'] = entity.checkTotalNum;
  data['unsuitableNum'] = entity.unsuitableNum;
  data['repairNum'] = entity.repairNum;
  data['qualifiedNum'] = entity.qualifiedNum;
  data['noQualifiedNum'] = entity.noQualifiedNum;
  data['remark'] = entity.remark;
  data['orderImage'] = entity.orderImage;
  data['assist'] = entity.assist;
  data['startTime'] = entity.startTime;
  data['endTime'] = entity.endTime;
  data['aheadReply'] = entity.aheadReply;
  data['signatureImage'] = entity.signatureImage;
  data['modulId'] = entity.modulId;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['mainResponseUserCode'] = entity.mainResponseUserCode;
  data['mainResponseUserId'] = entity.mainResponseUserId;
  data['mainMaintainerUserId'] = entity.mainMaintainerUserId;
  data['isShowClientSign'] = entity.isShowClientSign;
  data['safetyOfficerApprovalBy'] = entity.safetyOfficerApprovalBy;
  data['safetyOfficerSignatureImage'] = entity.safetyOfficerSignatureImage;
  data['clientApprovalBy'] = entity.clientApprovalBy;
  data['clientSignatureImage'] = entity.clientSignatureImage;
  data['registerCode'] = entity.registerCode;
  data['code96333'] = entity.code96333;
  data['isKceEquipment'] = entity.isKceEquipment;
  return data;
}

extension RegularDetailEntityExtension on RegularDetailEntity {
  RegularDetailEntity copyWith({
    int? id,
    String? orderNumber,
    String? orderType,
    String? projectCode,
    String? projectName,
    String? projectLocation,
    String? arrangeName,
    String? assistEmployee,
    List<MainResponseMember>? assistEmployeeArr,
    String? mainResponseUserName,
    String? mainMaintainerUserName,
    String? startLocation,
    int? startDistance,
    String? endLocation,
    int? endDistance,
    String? buildingCode,
    String? elevatorCode,
    String? equipmentTypeName,
    String? equipmentCode,
    String? groupCode,
    String? groupName,
    String? orderModul,
    int? state,
    int? stepState,
    int? checkTotalNum,
    int? unsuitableNum,
    int? repairNum,
    int? qualifiedNum,
    int? noQualifiedNum,
    String? remark,
    String? orderImage,
    bool? assist,
    int? startTime,
    int? endTime,
    bool? aheadReply,
    String? signatureImage,
    List<int>? modulId,
    double? longitude,
    double? latitude,
    String? mainResponseUserCode,
    int? mainResponseUserId,
    int? mainMaintainerUserId,
    bool? isShowClientSign,
    String? safetyOfficerApprovalBy,
    String? safetyOfficerSignatureImage,
    String? clientApprovalBy,
    String? clientSignatureImage,
    String? registerCode,
    String? code96333,
    bool? isKceEquipment,
  }) {
    return RegularDetailEntity()
      ..id = id ?? this.id
      ..orderNumber = orderNumber ?? this.orderNumber
      ..orderType = orderType ?? this.orderType
      ..projectCode = projectCode ?? this.projectCode
      ..projectName = projectName ?? this.projectName
      ..projectLocation = projectLocation ?? this.projectLocation
      ..arrangeName = arrangeName ?? this.arrangeName
      ..assistEmployee = assistEmployee ?? this.assistEmployee
      ..assistEmployeeArr = assistEmployeeArr ?? this.assistEmployeeArr
      ..mainResponseUserName = mainResponseUserName ?? this.mainResponseUserName
      ..mainMaintainerUserName = mainMaintainerUserName ?? this.mainMaintainerUserName
      ..startLocation = startLocation ?? this.startLocation
      ..startDistance = startDistance ?? this.startDistance
      ..endLocation = endLocation ?? this.endLocation
      ..endDistance = endDistance ?? this.endDistance
      ..buildingCode = buildingCode ?? this.buildingCode
      ..elevatorCode = elevatorCode ?? this.elevatorCode
      ..equipmentTypeName = equipmentTypeName ?? this.equipmentTypeName
      ..equipmentCode = equipmentCode ?? this.equipmentCode
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..orderModul = orderModul ?? this.orderModul
      ..state = state ?? this.state
      ..stepState = stepState ?? this.stepState
      ..checkTotalNum = checkTotalNum ?? this.checkTotalNum
      ..unsuitableNum = unsuitableNum ?? this.unsuitableNum
      ..repairNum = repairNum ?? this.repairNum
      ..qualifiedNum = qualifiedNum ?? this.qualifiedNum
      ..noQualifiedNum = noQualifiedNum ?? this.noQualifiedNum
      ..remark = remark ?? this.remark
      ..orderImage = orderImage ?? this.orderImage
      ..assist = assist ?? this.assist
      ..startTime = startTime ?? this.startTime
      ..endTime = endTime ?? this.endTime
      ..aheadReply = aheadReply ?? this.aheadReply
      ..signatureImage = signatureImage ?? this.signatureImage
      ..modulId = modulId ?? this.modulId
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..mainResponseUserCode = mainResponseUserCode ?? this.mainResponseUserCode
      ..mainResponseUserId = mainResponseUserId ?? this.mainResponseUserId
      ..mainMaintainerUserId = mainMaintainerUserId ?? this.mainMaintainerUserId
      ..isShowClientSign = isShowClientSign ?? this.isShowClientSign
      ..safetyOfficerApprovalBy = safetyOfficerApprovalBy ?? this.safetyOfficerApprovalBy
      ..safetyOfficerSignatureImage = safetyOfficerSignatureImage ?? this.safetyOfficerSignatureImage
      ..clientApprovalBy = clientApprovalBy ?? this.clientApprovalBy
      ..clientSignatureImage = clientSignatureImage ?? this.clientSignatureImage
      ..registerCode = registerCode ?? this.registerCode
      ..code96333 = code96333 ?? this.code96333
      ..isKceEquipment = isKceEquipment ?? this.isKceEquipment;
  }
}