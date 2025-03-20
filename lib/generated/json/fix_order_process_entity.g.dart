import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/fix_order_process_entity.dart';

FixOrderProcessEntity $FixOrderProcessEntityFromJson(Map<String, dynamic> json) {
  final FixOrderProcessEntity fixOrderProcessEntity = FixOrderProcessEntity();
  final int? flowType = jsonConvert.convert<int>(json['flowType']);
  if (flowType != null) {
    fixOrderProcessEntity.flowType = flowType;
  }
  final String? flowTypeContent = jsonConvert.convert<String>(json['flowTypeContent']);
  if (flowTypeContent != null) {
    fixOrderProcessEntity.flowTypeContent = flowTypeContent;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    fixOrderProcessEntity.content = content;
  }
  final String? flowTime = jsonConvert.convert<String>(json['flowTime']);
  if (flowTime != null) {
    fixOrderProcessEntity.flowTime = flowTime;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['imageUrl']);
  if (imageUrl != null) {
    fixOrderProcessEntity.imageUrl = imageUrl;
  }
  final String? tempUrl = jsonConvert.convert<String>(json['tempUrl']);
  if (tempUrl != null) {
    fixOrderProcessEntity.tempUrl = tempUrl;
  }
  return fixOrderProcessEntity;
}

Map<String, dynamic> $FixOrderProcessEntityToJson(FixOrderProcessEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['flowType'] = entity.flowType;
  data['flowTypeContent'] = entity.flowTypeContent;
  data['content'] = entity.content;
  data['flowTime'] = entity.flowTime;
  data['imageUrl'] = entity.imageUrl;
  data['tempUrl'] = entity.tempUrl;
  return data;
}

extension FixOrderProcessEntityExtension on FixOrderProcessEntity {
  FixOrderProcessEntity copyWith({
    int? flowType,
    String? flowTypeContent,
    String? content,
    String? flowTime,
    String? imageUrl,
    String? tempUrl,
  }) {
    return FixOrderProcessEntity()
      ..flowType = flowType ?? this.flowType
      ..flowTypeContent = flowTypeContent ?? this.flowTypeContent
      ..content = content ?? this.content
      ..flowTime = flowTime ?? this.flowTime
      ..imageUrl = imageUrl ?? this.imageUrl
      ..tempUrl = tempUrl ?? this.tempUrl;
  }
}