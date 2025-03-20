import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  bool? isFirstLogin;
  String? sessionId;
  String? expireRemind;

  LoginEntity();

  factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
