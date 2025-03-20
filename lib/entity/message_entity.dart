import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/message_entity.g.dart';

@JsonSerializable()
class MessageEntity {
  int? type;
  String? title;
  int? time;
  int? count;

  MessageEntity();

  factory MessageEntity.fromJson(Map<String, dynamic> json) => $MessageEntityFromJson(json);

  Map<String, dynamic> toJson() => $MessageEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
