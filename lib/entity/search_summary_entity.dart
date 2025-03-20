import 'dart:convert';

import 'package:konesp/entity/equipment_detail_entity.dart';
import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/search_summary_entity.g.dart';

@JsonSerializable()
class SearchSummaryEntity {
  List<ProjectEntity>? project;
  List<EquipmentDetailEntity>? equipmentInfoVoList;
  int? projectNum;
  int? equipmentInfoNum;

  SearchSummaryEntity();

  factory SearchSummaryEntity.fromJson(Map<String, dynamic> json) => $SearchSummaryEntityFromJson(json);

  Map<String, dynamic> toJson() => $SearchSummaryEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
