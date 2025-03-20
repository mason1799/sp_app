import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/fix_order_process_entity.g.dart';

@JsonSerializable()
class FixOrderProcessEntity {
  int? flowType;
  String? flowTypeContent;
  String? content;
  String? flowTime;
  String? imageUrl;
  String? tempUrl;

  FixOrderProcessEntity();

  factory FixOrderProcessEntity.fromJson(Map<String, dynamic> json) => $FixOrderProcessEntityFromJson(json);

  Map<String, dynamic> toJson() => $FixOrderProcessEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
