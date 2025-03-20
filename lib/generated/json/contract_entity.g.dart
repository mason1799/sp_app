import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/contract_entity.dart';

ContractEntity $ContractEntityFromJson(Map<String, dynamic> json) {
  final ContractEntity contractEntity = ContractEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    contractEntity.id = id;
  }
  final String? contractCode = jsonConvert.convert<String>(json['contractCode']);
  if (contractCode != null) {
    contractEntity.contractCode = contractCode;
  }
  final String? contractName = jsonConvert.convert<String>(json['contractName']);
  if (contractName != null) {
    contractEntity.contractName = contractName;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    contractEntity.status = status;
  }
  final String? contractStartDate = jsonConvert.convert<String>(json['contractStartDate']);
  if (contractStartDate != null) {
    contractEntity.contractStartDate = contractStartDate;
  }
  final String? contractEndDate = jsonConvert.convert<String>(json['contractEndDate']);
  if (contractEndDate != null) {
    contractEntity.contractEndDate = contractEndDate;
  }
  final int? expiryDate = jsonConvert.convert<int>(json['expiryDate']);
  if (expiryDate != null) {
    contractEntity.expiryDate = expiryDate;
  }
  return contractEntity;
}

Map<String, dynamic> $ContractEntityToJson(ContractEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['contractCode'] = entity.contractCode;
  data['contractName'] = entity.contractName;
  data['status'] = entity.status;
  data['contractStartDate'] = entity.contractStartDate;
  data['contractEndDate'] = entity.contractEndDate;
  data['expiryDate'] = entity.expiryDate;
  return data;
}

extension ContractEntityExtension on ContractEntity {
  ContractEntity copyWith({
    int? id,
    String? contractCode,
    String? contractName,
    String? status,
    String? contractStartDate,
    String? contractEndDate,
    int? expiryDate,
  }) {
    return ContractEntity()
      ..id = id ?? this.id
      ..contractCode = contractCode ?? this.contractCode
      ..contractName = contractName ?? this.contractName
      ..status = status ?? this.status
      ..contractStartDate = contractStartDate ?? this.contractStartDate
      ..contractEndDate = contractEndDate ?? this.contractEndDate
      ..expiryDate = expiryDate ?? this.expiryDate;
  }
}