import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/order_rule_entity.g.dart';

@JsonSerializable()
class OrderRuleEntity {
  int? orderType;
  String? ruleKey;
  int? ruleValue;
  int? enabled;

  OrderRuleEntity();

  factory OrderRuleEntity.fromJson(Map<String, dynamic> json) => $OrderRuleEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderRuleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
