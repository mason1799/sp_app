import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/contract_entity.g.dart';

@JsonSerializable()
class ContractEntity {
  int? id;
  String? contractCode;
  String? contractName;
  String? status;
  String? contractStartDate;
  String? contractEndDate;
  int? expiryDate;

  ContractEntity();

  factory ContractEntity.fromJson(Map<String, dynamic> json) => $ContractEntityFromJson(json);

  Map<String, dynamic> toJson() => $ContractEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
