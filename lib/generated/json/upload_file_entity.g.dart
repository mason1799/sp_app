import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/upload_file_entity.dart';

UploadFileEntity $UploadFileEntityFromJson(Map<String, dynamic> json) {
  final UploadFileEntity uploadFileEntity = UploadFileEntity();
  final String? ossKey = jsonConvert.convert<String>(json['ossKey']);
  if (ossKey != null) {
    uploadFileEntity.ossKey = ossKey;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    uploadFileEntity.path = path;
  }
  return uploadFileEntity;
}

Map<String, dynamic> $UploadFileEntityToJson(UploadFileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ossKey'] = entity.ossKey;
  data['path'] = entity.path;
  return data;
}

extension UploadFileEntityExtension on UploadFileEntity {
  UploadFileEntity copyWith({
    String? ossKey,
    String? path,
  }) {
    return UploadFileEntity()
      ..ossKey = ossKey ?? this.ossKey
      ..path = path ?? this.path;
  }
}