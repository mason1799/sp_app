import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/help_center_entity.g.dart';

@JsonSerializable()
class HelpCenterEntity {
  String? code;
  String? name;
  String? url;

  HelpCenterEntity();

  factory HelpCenterEntity.fromJson(Map<String, dynamic> json) => $HelpCenterEntityFromJson(json);

  Map<String, dynamic> toJson() => $HelpCenterEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
