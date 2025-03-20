import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/maintaine_group_entity.g.dart';

export 'package:konesp/generated/json/maintaine_group_entity.g.dart';

@JsonSerializable()
class MaintaineGroupEntity {
  int? id;
  String? groupCode;
  String? groupName;
  String? departmentId;

  MaintaineGroupEntity();

  factory MaintaineGroupEntity.fromJson(Map<String, dynamic> json) => $MaintaineGroupEntityFromJson(json);

  Map<String, dynamic> toJson() => $MaintaineGroupEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
