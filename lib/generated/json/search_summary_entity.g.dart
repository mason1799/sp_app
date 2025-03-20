import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/search_summary_entity.dart';
import 'package:konesp/entity/equipment_detail_entity.dart';

import 'package:konesp/entity/project_entity.dart';


SearchSummaryEntity $SearchSummaryEntityFromJson(Map<String, dynamic> json) {
  final SearchSummaryEntity searchSummaryEntity = SearchSummaryEntity();
  final List<ProjectEntity>? project = (json['project'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ProjectEntity>(e) as ProjectEntity).toList();
  if (project != null) {
    searchSummaryEntity.project = project;
  }
  final List<EquipmentDetailEntity>? equipmentInfoVoList = (json['equipmentInfoVoList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<EquipmentDetailEntity>(e) as EquipmentDetailEntity).toList();
  if (equipmentInfoVoList != null) {
    searchSummaryEntity.equipmentInfoVoList = equipmentInfoVoList;
  }
  final int? projectNum = jsonConvert.convert<int>(json['projectNum']);
  if (projectNum != null) {
    searchSummaryEntity.projectNum = projectNum;
  }
  final int? equipmentInfoNum = jsonConvert.convert<int>(json['equipmentInfoNum']);
  if (equipmentInfoNum != null) {
    searchSummaryEntity.equipmentInfoNum = equipmentInfoNum;
  }
  return searchSummaryEntity;
}

Map<String, dynamic> $SearchSummaryEntityToJson(SearchSummaryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['project'] = entity.project?.map((v) => v.toJson()).toList();
  data['equipmentInfoVoList'] = entity.equipmentInfoVoList?.map((v) => v.toJson()).toList();
  data['projectNum'] = entity.projectNum;
  data['equipmentInfoNum'] = entity.equipmentInfoNum;
  return data;
}

extension SearchSummaryEntityExtension on SearchSummaryEntity {
  SearchSummaryEntity copyWith({
    List<ProjectEntity>? project,
    List<EquipmentDetailEntity>? equipmentInfoVoList,
    int? projectNum,
    int? equipmentInfoNum,
  }) {
    return SearchSummaryEntity()
      ..project = project ?? this.project
      ..equipmentInfoVoList = equipmentInfoVoList ?? this.equipmentInfoVoList
      ..projectNum = projectNum ?? this.projectNum
      ..equipmentInfoNum = equipmentInfoNum ?? this.equipmentInfoNum;
  }
}