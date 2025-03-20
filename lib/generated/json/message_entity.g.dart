import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/message_entity.dart';

MessageEntity $MessageEntityFromJson(Map<String, dynamic> json) {
  final MessageEntity messageEntity = MessageEntity();
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    messageEntity.type = type;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    messageEntity.title = title;
  }
  final int? time = jsonConvert.convert<int>(json['time']);
  if (time != null) {
    messageEntity.time = time;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    messageEntity.count = count;
  }
  return messageEntity;
}

Map<String, dynamic> $MessageEntityToJson(MessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['title'] = entity.title;
  data['time'] = entity.time;
  data['count'] = entity.count;
  return data;
}

extension MessageEntityExtension on MessageEntity {
  MessageEntity copyWith({
    int? type,
    String? title,
    int? time,
    int? count,
  }) {
    return MessageEntity()
      ..type = type ?? this.type
      ..title = title ?? this.title
      ..time = time ?? this.time
      ..count = count ?? this.count;
  }
}