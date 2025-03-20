import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/message_list_entity.g.dart';

@JsonSerializable()
class MessageListEntity {
  int? time;
  String? content;
  String? title;
  int? bizId;

  MessageListEntity();

  factory MessageListEntity.fromJson(Map<String, dynamic> json) => $MessageListEntityFromJson(json);

  Map<String, dynamic> toJson() => $MessageListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
