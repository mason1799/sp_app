import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/check_stuffs_entity.g.dart';

@JsonSerializable()
class CheckStuffsEntity {
  String? groupName;
  List<CheckStuffsChild>? list;

  CheckStuffsEntity();

  factory CheckStuffsEntity.fromJson(Map<String, dynamic> json) => $CheckStuffsEntityFromJson(json);

  Map<String, dynamic> toJson() => $CheckStuffsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CheckStuffsChild {
  int? checkId;
  String? content;
  String? required;
  int? conclusion;
  int? selectDefault;
  String? picture;
  bool? isMandatory;

  CheckStuffsChild();

  factory CheckStuffsChild.fromJson(Map<String, dynamic> json) => $CheckStuffsChildFromJson(json);

  Map<String, dynamic> toJson() => $CheckStuffsChildToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}