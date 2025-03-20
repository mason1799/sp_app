import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/message_list_entity.dart';

MessageListEntity $MessageListEntityFromJson(Map<String, dynamic> json) {
  final MessageListEntity messageListEntity = MessageListEntity();
  final int? time = jsonConvert.convert<int>(json['time']);
  if (time != null) {
    messageListEntity.time = time;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    messageListEntity.content = content;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    messageListEntity.title = title;
  }
  final int? bizId = jsonConvert.convert<int>(json['bizId']);
  if (bizId != null) {
    messageListEntity.bizId = bizId;
  }
  return messageListEntity;
}

Map<String, dynamic> $MessageListEntityToJson(MessageListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['time'] = entity.time;
  data['content'] = entity.content;
  data['title'] = entity.title;
  data['bizId'] = entity.bizId;
  return data;
}

extension MessageListEntityExtension on MessageListEntity {
  MessageListEntity copyWith({
    int? time,
    String? content,
    String? title,
    int? bizId,
  }) {
    return MessageListEntity()
      ..time = time ?? this.time
      ..content = content ?? this.content
      ..title = title ?? this.title
      ..bizId = bizId ?? this.bizId;
  }
}