import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/check_update_entity.dart';

CheckUpdateEntity $CheckUpdateEntityFromJson(Map<String, dynamic> json) {
  final CheckUpdateEntity checkUpdateEntity = CheckUpdateEntity();
  final String? versionNumber = jsonConvert.convert<String>(json['versionNumber']);
  if (versionNumber != null) {
    checkUpdateEntity.versionNumber = versionNumber;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    checkUpdateEntity.url = url;
  }
  final bool? forceUpdate = jsonConvert.convert<bool>(json['forceUpdate']);
  if (forceUpdate != null) {
    checkUpdateEntity.forceUpdate = forceUpdate;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    checkUpdateEntity.remark = remark;
  }
  return checkUpdateEntity;
}

Map<String, dynamic> $CheckUpdateEntityToJson(CheckUpdateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['versionNumber'] = entity.versionNumber;
  data['url'] = entity.url;
  data['forceUpdate'] = entity.forceUpdate;
  data['remark'] = entity.remark;
  return data;
}

extension CheckUpdateEntityExtension on CheckUpdateEntity {
  CheckUpdateEntity copyWith({
    String? versionNumber,
    String? url,
    bool? forceUpdate,
    String? remark,
  }) {
    return CheckUpdateEntity()
      ..versionNumber = versionNumber ?? this.versionNumber
      ..url = url ?? this.url
      ..forceUpdate = forceUpdate ?? this.forceUpdate
      ..remark = remark ?? this.remark;
  }
}