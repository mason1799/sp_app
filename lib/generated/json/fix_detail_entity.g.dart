import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/fix_detail_entity.dart';

FixDetailEntity $FixDetailEntityFromJson(Map<String, dynamic> json) {
  final FixDetailEntity fixDetailEntity = FixDetailEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    fixDetailEntity.id = id;
  }
  final String? orderNumber = jsonConvert.convert<String>(json['orderNumber']);
  if (orderNumber != null) {
    fixDetailEntity.orderNumber = orderNumber;
  }
  final int? orderState = jsonConvert.convert<int>(json['orderState']);
  if (orderState != null) {
    fixDetailEntity.orderState = orderState;
  }
  final int? equipmentId = jsonConvert.convert<int>(json['equipmentId']);
  if (equipmentId != null) {
    fixDetailEntity.equipmentId = equipmentId;
  }
  final String? equipmentCode = jsonConvert.convert<String>(json['equipmentCode']);
  if (equipmentCode != null) {
    fixDetailEntity.equipmentCode = equipmentCode;
  }
  final int? faultRepairType = jsonConvert.convert<int>(json['faultRepairType']);
  if (faultRepairType != null) {
    fixDetailEntity.faultRepairType = faultRepairType;
  }
  final String? faultDesc = jsonConvert.convert<String>(json['faultDesc']);
  if (faultDesc != null) {
    fixDetailEntity.faultDesc = faultDesc;
  }
  final int? mainResponseUserId = jsonConvert.convert<int>(json['mainResponseUserId']);
  if (mainResponseUserId != null) {
    fixDetailEntity.mainResponseUserId = mainResponseUserId;
  }
  final String? mainResponseUserName = jsonConvert.convert<String>(json['mainResponseUserName']);
  if (mainResponseUserName != null) {
    fixDetailEntity.mainResponseUserName = mainResponseUserName;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    fixDetailEntity.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    fixDetailEntity.groupName = groupName;
  }
  final String? repairman = jsonConvert.convert<String>(json['repairman']);
  if (repairman != null) {
    fixDetailEntity.repairman = repairman;
  }
  final int? repairRole = jsonConvert.convert<int>(json['repairRole']);
  if (repairRole != null) {
    fixDetailEntity.repairRole = repairRole;
  }
  final String? repairTime = jsonConvert.convert<String>(json['repairTime']);
  if (repairTime != null) {
    fixDetailEntity.repairTime = repairTime;
  }
  final String? assistEmployee = jsonConvert.convert<String>(json['assistEmployee']);
  if (assistEmployee != null) {
    fixDetailEntity.assistEmployee = assistEmployee;
  }
  final List<String?>? assistSignatureImage = (json['assistSignatureImage'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e)).toList();
  if (assistSignatureImage != null) {
    fixDetailEntity.assistSignatureImage = assistSignatureImage;
  }
  final List<FixDetailAssistEmployee>? assistEmployees = (json['assistEmployees'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<FixDetailAssistEmployee>(e) as FixDetailAssistEmployee).toList();
  if (assistEmployees != null) {
    fixDetailEntity.assistEmployees = assistEmployees;
  }
  final String? repairPhone = jsonConvert.convert<String>(json['repairPhone']);
  if (repairPhone != null) {
    fixDetailEntity.repairPhone = repairPhone;
  }
  final String? signInTime = jsonConvert.convert<String>(json['signInTime']);
  if (signInTime != null) {
    fixDetailEntity.signInTime = signInTime;
  }
  final String? signInLocation = jsonConvert.convert<String>(json['signInLocation']);
  if (signInLocation != null) {
    fixDetailEntity.signInLocation = signInLocation;
  }
  final double? signInDistance = jsonConvert.convert<double>(json['signInDistance']);
  if (signInDistance != null) {
    fixDetailEntity.signInDistance = signInDistance;
  }
  final String? arriveEquipmentState = jsonConvert.convert<String>(json['arriveEquipmentState']);
  if (arriveEquipmentState != null) {
    fixDetailEntity.arriveEquipmentState = arriveEquipmentState;
  }
  final String? leaveEquipmentState = jsonConvert.convert<String>(json['leaveEquipmentState']);
  if (leaveEquipmentState != null) {
    fixDetailEntity.leaveEquipmentState = leaveEquipmentState;
  }
  final String? faultCause = jsonConvert.convert<String>(json['faultCause']);
  if (faultCause != null) {
    fixDetailEntity.faultCause = faultCause;
  }
  final String? faultDisposalAction = jsonConvert.convert<String>(json['faultDisposalAction']);
  if (faultDisposalAction != null) {
    fixDetailEntity.faultDisposalAction = faultDisposalAction;
  }
  final String? faultParts = jsonConvert.convert<String>(json['faultParts']);
  if (faultParts != null) {
    fixDetailEntity.faultParts = faultParts;
  }
  final String? updateParts = jsonConvert.convert<String>(json['updateParts']);
  if (updateParts != null) {
    fixDetailEntity.updateParts = updateParts;
  }
  final int? updatePartsCount = jsonConvert.convert<int>(json['updatePartsCount']);
  if (updatePartsCount != null) {
    fixDetailEntity.updatePartsCount = updatePartsCount;
  }
  final int? trappedCount = jsonConvert.convert<int>(json['trappedCount']);
  if (trappedCount != null) {
    fixDetailEntity.trappedCount = trappedCount;
  }
  final int? trappedMinutes = jsonConvert.convert<int>(json['trappedMinutes']);
  if (trappedMinutes != null) {
    fixDetailEntity.trappedMinutes = trappedMinutes;
  }
  final String? escapeMode = jsonConvert.convert<String>(json['escapeMode']);
  if (escapeMode != null) {
    fixDetailEntity.escapeMode = escapeMode;
  }
  final String? complaintDetails = jsonConvert.convert<String>(json['complaintDetails']);
  if (complaintDetails != null) {
    fixDetailEntity.complaintDetails = complaintDetails;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    fixDetailEntity.remark = remark;
  }
  final List<String>? remarkImages = (json['remarkImages'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (remarkImages != null) {
    fixDetailEntity.remarkImages = remarkImages;
  }
  final String? signOutTime = jsonConvert.convert<String>(json['signOutTime']);
  if (signOutTime != null) {
    fixDetailEntity.signOutTime = signOutTime;
  }
  final String? signOutLocation = jsonConvert.convert<String>(json['signOutLocation']);
  if (signOutLocation != null) {
    fixDetailEntity.signOutLocation = signOutLocation;
  }
  final double? signOutDistance = jsonConvert.convert<double>(json['signOutDistance']);
  if (signOutDistance != null) {
    fixDetailEntity.signOutDistance = signOutDistance;
  }
  final String? signatureImage = jsonConvert.convert<String>(json['signatureImage']);
  if (signatureImage != null) {
    fixDetailEntity.signatureImage = signatureImage;
  }
  final String? projectCode = jsonConvert.convert<String>(json['projectCode']);
  if (projectCode != null) {
    fixDetailEntity.projectCode = projectCode;
  }
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    fixDetailEntity.projectName = projectName;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    fixDetailEntity.projectLocation = projectLocation;
  }
  final double? longitude = jsonConvert.convert<double>(json['longitude']);
  if (longitude != null) {
    fixDetailEntity.longitude = longitude;
  }
  final double? latitude = jsonConvert.convert<double>(json['latitude']);
  if (latitude != null) {
    fixDetailEntity.latitude = latitude;
  }
  final String? buildingCode = jsonConvert.convert<String>(json['buildingCode']);
  if (buildingCode != null) {
    fixDetailEntity.buildingCode = buildingCode;
  }
  final String? elevatorCode = jsonConvert.convert<String>(json['elevatorCode']);
  if (elevatorCode != null) {
    fixDetailEntity.elevatorCode = elevatorCode;
  }
  final int? equipmentType = jsonConvert.convert<int>(json['equipmentType']);
  if (equipmentType != null) {
    fixDetailEntity.equipmentType = equipmentType;
  }
  final String? equipmentTypeName = jsonConvert.convert<String>(json['equipmentTypeName']);
  if (equipmentTypeName != null) {
    fixDetailEntity.equipmentTypeName = equipmentTypeName;
  }
  final int? mainRepairerUserId = jsonConvert.convert<int>(json['mainRepairerUserId']);
  if (mainRepairerUserId != null) {
    fixDetailEntity.mainRepairerUserId = mainRepairerUserId;
  }
  final String? mainRepairerUserName = jsonConvert.convert<String>(json['mainRepairerUserName']);
  if (mainRepairerUserName != null) {
    fixDetailEntity.mainRepairerUserName = mainRepairerUserName;
  }
  final String? stopTime = jsonConvert.convert<String>(json['stopTime']);
  if (stopTime != null) {
    fixDetailEntity.stopTime = stopTime;
  }
  final int? flow = jsonConvert.convert<int>(json['flow']);
  if (flow != null) {
    fixDetailEntity.flow = flow;
  }
  final bool? isKceEquipment = jsonConvert.convert<bool>(json['isKceEquipment']);
  if (isKceEquipment != null) {
    fixDetailEntity.isKceEquipment = isKceEquipment;
  }
  return fixDetailEntity;
}

Map<String, dynamic> $FixDetailEntityToJson(FixDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['orderNumber'] = entity.orderNumber;
  data['orderState'] = entity.orderState;
  data['equipmentId'] = entity.equipmentId;
  data['equipmentCode'] = entity.equipmentCode;
  data['faultRepairType'] = entity.faultRepairType;
  data['faultDesc'] = entity.faultDesc;
  data['mainResponseUserId'] = entity.mainResponseUserId;
  data['mainResponseUserName'] = entity.mainResponseUserName;
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['repairman'] = entity.repairman;
  data['repairRole'] = entity.repairRole;
  data['repairTime'] = entity.repairTime;
  data['assistEmployee'] = entity.assistEmployee;
  data['assistSignatureImage'] = entity.assistSignatureImage;
  data['assistEmployees'] = entity.assistEmployees?.map((v) => v.toJson()).toList();
  data['repairPhone'] = entity.repairPhone;
  data['signInTime'] = entity.signInTime;
  data['signInLocation'] = entity.signInLocation;
  data['signInDistance'] = entity.signInDistance;
  data['arriveEquipmentState'] = entity.arriveEquipmentState;
  data['leaveEquipmentState'] = entity.leaveEquipmentState;
  data['faultCause'] = entity.faultCause;
  data['faultDisposalAction'] = entity.faultDisposalAction;
  data['faultParts'] = entity.faultParts;
  data['updateParts'] = entity.updateParts;
  data['updatePartsCount'] = entity.updatePartsCount;
  data['trappedCount'] = entity.trappedCount;
  data['trappedMinutes'] = entity.trappedMinutes;
  data['escapeMode'] = entity.escapeMode;
  data['complaintDetails'] = entity.complaintDetails;
  data['remark'] = entity.remark;
  data['remarkImages'] = entity.remarkImages;
  data['signOutTime'] = entity.signOutTime;
  data['signOutLocation'] = entity.signOutLocation;
  data['signOutDistance'] = entity.signOutDistance;
  data['signatureImage'] = entity.signatureImage;
  data['projectCode'] = entity.projectCode;
  data['projectName'] = entity.projectName;
  data['projectLocation'] = entity.projectLocation;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['buildingCode'] = entity.buildingCode;
  data['elevatorCode'] = entity.elevatorCode;
  data['equipmentType'] = entity.equipmentType;
  data['equipmentTypeName'] = entity.equipmentTypeName;
  data['mainRepairerUserId'] = entity.mainRepairerUserId;
  data['mainRepairerUserName'] = entity.mainRepairerUserName;
  data['stopTime'] = entity.stopTime;
  data['flow'] = entity.flow;
  data['isKceEquipment'] = entity.isKceEquipment;
  return data;
}

extension FixDetailEntityExtension on FixDetailEntity {
  FixDetailEntity copyWith({
    int? id,
    String? orderNumber,
    int? orderState,
    int? equipmentId,
    String? equipmentCode,
    int? faultRepairType,
    String? faultDesc,
    int? mainResponseUserId,
    String? mainResponseUserName,
    String? groupCode,
    String? groupName,
    String? repairman,
    int? repairRole,
    String? repairTime,
    String? assistEmployee,
    List<String?>? assistSignatureImage,
    List<FixDetailAssistEmployee>? assistEmployees,
    String? repairPhone,
    String? signInTime,
    String? signInLocation,
    double? signInDistance,
    String? arriveEquipmentState,
    String? leaveEquipmentState,
    String? faultCause,
    String? faultDisposalAction,
    String? faultParts,
    String? updateParts,
    int? updatePartsCount,
    int? trappedCount,
    int? trappedMinutes,
    String? escapeMode,
    String? complaintDetails,
    String? remark,
    List<String>? remarkImages,
    String? signOutTime,
    String? signOutLocation,
    double? signOutDistance,
    String? signatureImage,
    String? projectCode,
    String? projectName,
    String? projectLocation,
    double? longitude,
    double? latitude,
    String? buildingCode,
    String? elevatorCode,
    int? equipmentType,
    String? equipmentTypeName,
    int? mainRepairerUserId,
    String? mainRepairerUserName,
    String? stopTime,
    int? flow,
    bool? isKceEquipment,
  }) {
    return FixDetailEntity()
      ..id = id ?? this.id
      ..orderNumber = orderNumber ?? this.orderNumber
      ..orderState = orderState ?? this.orderState
      ..equipmentId = equipmentId ?? this.equipmentId
      ..equipmentCode = equipmentCode ?? this.equipmentCode
      ..faultRepairType = faultRepairType ?? this.faultRepairType
      ..faultDesc = faultDesc ?? this.faultDesc
      ..mainResponseUserId = mainResponseUserId ?? this.mainResponseUserId
      ..mainResponseUserName = mainResponseUserName ?? this.mainResponseUserName
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..repairman = repairman ?? this.repairman
      ..repairRole = repairRole ?? this.repairRole
      ..repairTime = repairTime ?? this.repairTime
      ..assistEmployee = assistEmployee ?? this.assistEmployee
      ..assistSignatureImage = assistSignatureImage ?? this.assistSignatureImage
      ..assistEmployees = assistEmployees ?? this.assistEmployees
      ..repairPhone = repairPhone ?? this.repairPhone
      ..signInTime = signInTime ?? this.signInTime
      ..signInLocation = signInLocation ?? this.signInLocation
      ..signInDistance = signInDistance ?? this.signInDistance
      ..arriveEquipmentState = arriveEquipmentState ?? this.arriveEquipmentState
      ..leaveEquipmentState = leaveEquipmentState ?? this.leaveEquipmentState
      ..faultCause = faultCause ?? this.faultCause
      ..faultDisposalAction = faultDisposalAction ?? this.faultDisposalAction
      ..faultParts = faultParts ?? this.faultParts
      ..updateParts = updateParts ?? this.updateParts
      ..updatePartsCount = updatePartsCount ?? this.updatePartsCount
      ..trappedCount = trappedCount ?? this.trappedCount
      ..trappedMinutes = trappedMinutes ?? this.trappedMinutes
      ..escapeMode = escapeMode ?? this.escapeMode
      ..complaintDetails = complaintDetails ?? this.complaintDetails
      ..remark = remark ?? this.remark
      ..remarkImages = remarkImages ?? this.remarkImages
      ..signOutTime = signOutTime ?? this.signOutTime
      ..signOutLocation = signOutLocation ?? this.signOutLocation
      ..signOutDistance = signOutDistance ?? this.signOutDistance
      ..signatureImage = signatureImage ?? this.signatureImage
      ..projectCode = projectCode ?? this.projectCode
      ..projectName = projectName ?? this.projectName
      ..projectLocation = projectLocation ?? this.projectLocation
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..buildingCode = buildingCode ?? this.buildingCode
      ..elevatorCode = elevatorCode ?? this.elevatorCode
      ..equipmentType = equipmentType ?? this.equipmentType
      ..equipmentTypeName = equipmentTypeName ?? this.equipmentTypeName
      ..mainRepairerUserId = mainRepairerUserId ?? this.mainRepairerUserId
      ..mainRepairerUserName = mainRepairerUserName ?? this.mainRepairerUserName
      ..stopTime = stopTime ?? this.stopTime
      ..flow = flow ?? this.flow
      ..isKceEquipment = isKceEquipment ?? this.isKceEquipment;
  }
}

FixDetailAssistEmployee $FixDetailAssistEmployeeFromJson(Map<String, dynamic> json) {
  final FixDetailAssistEmployee fixDetailAssistEmployee = FixDetailAssistEmployee();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    fixDetailAssistEmployee.userId = userId;
  }
  final String? employeeCode = jsonConvert.convert<String>(json['employeeCode']);
  if (employeeCode != null) {
    fixDetailAssistEmployee.employeeCode = employeeCode;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    fixDetailAssistEmployee.username = username;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    fixDetailAssistEmployee.phone = phone;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    fixDetailAssistEmployee.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    fixDetailAssistEmployee.groupName = groupName;
  }
  final String? signatureImage = jsonConvert.convert<String>(json['signatureImage']);
  if (signatureImage != null) {
    fixDetailAssistEmployee.signatureImage = signatureImage;
  }
  return fixDetailAssistEmployee;
}

Map<String, dynamic> $FixDetailAssistEmployeeToJson(FixDetailAssistEmployee entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['employeeCode'] = entity.employeeCode;
  data['username'] = entity.username;
  data['phone'] = entity.phone;
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['signatureImage'] = entity.signatureImage;
  return data;
}

extension FixDetailAssistEmployeeExtension on FixDetailAssistEmployee {
  FixDetailAssistEmployee copyWith({
    int? userId,
    String? employeeCode,
    String? username,
    String? phone,
    String? groupCode,
    String? groupName,
    String? signatureImage,
  }) {
    return FixDetailAssistEmployee()
      ..userId = userId ?? this.userId
      ..employeeCode = employeeCode ?? this.employeeCode
      ..username = username ?? this.username
      ..phone = phone ?? this.phone
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..signatureImage = signatureImage ?? this.signatureImage;
  }
}