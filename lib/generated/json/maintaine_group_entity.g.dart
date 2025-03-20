import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/maintaine_group_entity.dart';

MaintaineGroupEntity $MaintaineGroupEntityFromJson(Map<String, dynamic> json) {
  final MaintaineGroupEntity maintaineGroupEntity = MaintaineGroupEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    maintaineGroupEntity.id = id;
  }
  final String? groupCode = jsonConvert.convert<String>(json['groupCode']);
  if (groupCode != null) {
    maintaineGroupEntity.groupCode = groupCode;
  }
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    maintaineGroupEntity.groupName = groupName;
  }
  final String? departmentId = jsonConvert.convert<String>(json['departmentId']);
  if (departmentId != null) {
    maintaineGroupEntity.departmentId = departmentId;
  }
  return maintaineGroupEntity;
}

Map<String, dynamic> $MaintaineGroupEntityToJson(MaintaineGroupEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['groupCode'] = entity.groupCode;
  data['groupName'] = entity.groupName;
  data['departmentId'] = entity.departmentId;
  return data;
}

extension MaintaineGroupEntityExtension on MaintaineGroupEntity {
  MaintaineGroupEntity copyWith({
    int? id,
    String? groupCode,
    String? groupName,
    String? departmentId,
  }) {
    return MaintaineGroupEntity()
      ..id = id ?? this.id
      ..groupCode = groupCode ?? this.groupCode
      ..groupName = groupName ?? this.groupName
      ..departmentId = departmentId ?? this.departmentId;
  }
}