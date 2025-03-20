import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/custom_field_list_entity.g.dart';

@JsonSerializable()
class CustomFieldListEntity {
  int? id;
  List<CustomField>? list;

  CustomFieldListEntity();

  factory CustomFieldListEntity.fromJson(Map<String, dynamic> json) => $CustomFieldListEntityFromJson(json);

  Map<String, dynamic> toJson() => $CustomFieldListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CustomField {
  int? id;
  String? fieldName;
  String? component;
  String? content;
  String? necessary;
  String? reflect;
  String? value;
  bool? disabled;
  int? length;
  int? type;

  CustomField();

  factory CustomField.fromJson(Map<String, dynamic> json) => $CustomFieldFromJson(json);

  Map<String, dynamic> toJson() => $CustomFieldToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
