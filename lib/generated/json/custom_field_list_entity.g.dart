import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';

CustomFieldListEntity $CustomFieldListEntityFromJson(Map<String, dynamic> json) {
  final CustomFieldListEntity customFieldListEntity = CustomFieldListEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    customFieldListEntity.id = id;
  }
  final List<CustomField>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CustomField>(e) as CustomField).toList();
  if (list != null) {
    customFieldListEntity.list = list;
  }
  return customFieldListEntity;
}

Map<String, dynamic> $CustomFieldListEntityToJson(CustomFieldListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension CustomFieldListEntityExtension on CustomFieldListEntity {
  CustomFieldListEntity copyWith({
    int? id,
    List<CustomField>? list,
  }) {
    return CustomFieldListEntity()
      ..id = id ?? this.id
      ..list = list ?? this.list;
  }
}

CustomField $CustomFieldFromJson(Map<String, dynamic> json) {
  final CustomField customField = CustomField();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    customField.id = id;
  }
  final String? fieldName = jsonConvert.convert<String>(json['fieldName']);
  if (fieldName != null) {
    customField.fieldName = fieldName;
  }
  final String? component = jsonConvert.convert<String>(json['component']);
  if (component != null) {
    customField.component = component;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    customField.content = content;
  }
  final String? necessary = jsonConvert.convert<String>(json['necessary']);
  if (necessary != null) {
    customField.necessary = necessary;
  }
  final String? reflect = jsonConvert.convert<String>(json['reflect']);
  if (reflect != null) {
    customField.reflect = reflect;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    customField.value = value;
  }
  final bool? disabled = jsonConvert.convert<bool>(json['disabled']);
  if (disabled != null) {
    customField.disabled = disabled;
  }
  final int? length = jsonConvert.convert<int>(json['length']);
  if (length != null) {
    customField.length = length;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    customField.type = type;
  }
  return customField;
}

Map<String, dynamic> $CustomFieldToJson(CustomField entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['fieldName'] = entity.fieldName;
  data['component'] = entity.component;
  data['content'] = entity.content;
  data['necessary'] = entity.necessary;
  data['reflect'] = entity.reflect;
  data['value'] = entity.value;
  data['disabled'] = entity.disabled;
  data['length'] = entity.length;
  data['type'] = entity.type;
  return data;
}

extension CustomFieldExtension on CustomField {
  CustomField copyWith({
    int? id,
    String? fieldName,
    String? component,
    String? content,
    String? necessary,
    String? reflect,
    String? value,
    bool? disabled,
    int? length,
    int? type,
  }) {
    return CustomField()
      ..id = id ?? this.id
      ..fieldName = fieldName ?? this.fieldName
      ..component = component ?? this.component
      ..content = content ?? this.content
      ..necessary = necessary ?? this.necessary
      ..reflect = reflect ?? this.reflect
      ..value = value ?? this.value
      ..disabled = disabled ?? this.disabled
      ..length = length ?? this.length
      ..type = type ?? this.type;
  }
}