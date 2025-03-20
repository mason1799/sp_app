import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/order_rule_entity.dart';

OrderRuleEntity $OrderRuleEntityFromJson(Map<String, dynamic> json) {
  final OrderRuleEntity orderRuleEntity = OrderRuleEntity();
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    orderRuleEntity.orderType = orderType;
  }
  final String? ruleKey = jsonConvert.convert<String>(json['ruleKey']);
  if (ruleKey != null) {
    orderRuleEntity.ruleKey = ruleKey;
  }
  final int? ruleValue = jsonConvert.convert<int>(json['ruleValue']);
  if (ruleValue != null) {
    orderRuleEntity.ruleValue = ruleValue;
  }
  final int? enabled = jsonConvert.convert<int>(json['enabled']);
  if (enabled != null) {
    orderRuleEntity.enabled = enabled;
  }
  return orderRuleEntity;
}

Map<String, dynamic> $OrderRuleEntityToJson(OrderRuleEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderType'] = entity.orderType;
  data['ruleKey'] = entity.ruleKey;
  data['ruleValue'] = entity.ruleValue;
  data['enabled'] = entity.enabled;
  return data;
}

extension OrderRuleEntityExtension on OrderRuleEntity {
  OrderRuleEntity copyWith({
    int? orderType,
    String? ruleKey,
    int? ruleValue,
    int? enabled,
  }) {
    return OrderRuleEntity()
      ..orderType = orderType ?? this.orderType
      ..ruleKey = ruleKey ?? this.ruleKey
      ..ruleValue = ruleValue ?? this.ruleValue
      ..enabled = enabled ?? this.enabled;
  }
}