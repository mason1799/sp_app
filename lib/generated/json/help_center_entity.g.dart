import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/help_center_entity.dart';

HelpCenterEntity $HelpCenterEntityFromJson(Map<String, dynamic> json) {
  final HelpCenterEntity helpCenterEntity = HelpCenterEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    helpCenterEntity.code = code;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    helpCenterEntity.name = name;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    helpCenterEntity.url = url;
  }
  return helpCenterEntity;
}

Map<String, dynamic> $HelpCenterEntityToJson(HelpCenterEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['name'] = entity.name;
  data['url'] = entity.url;
  return data;
}

extension HelpCenterEntityExtension on HelpCenterEntity {
  HelpCenterEntity copyWith({
    String? code,
    String? name,
    String? url,
  }) {
    return HelpCenterEntity()
      ..code = code ?? this.code
      ..name = name ?? this.name
      ..url = url ?? this.url;
  }
}