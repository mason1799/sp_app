import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/oss_token_entity.dart';

OssTokenEntity $OssTokenEntityFromJson(Map<String, dynamic> json) {
  final OssTokenEntity ossTokenEntity = OssTokenEntity();
  final String? securityToken = jsonConvert.convert<String>(json['SecurityToken']);
  if (securityToken != null) {
    ossTokenEntity.securityToken = securityToken;
  }
  final String? bucketName = jsonConvert.convert<String>(json['bucketName']);
  if (bucketName != null) {
    ossTokenEntity.bucketName = bucketName;
  }
  final String? endpoint = jsonConvert.convert<String>(json['endpoint']);
  if (endpoint != null) {
    ossTokenEntity.endpoint = endpoint;
  }
  final String? regionId = jsonConvert.convert<String>(json['regionId']);
  if (regionId != null) {
    ossTokenEntity.regionId = regionId;
  }
  final String? accessKeyId = jsonConvert.convert<String>(json['AccessKeyId']);
  if (accessKeyId != null) {
    ossTokenEntity.accessKeyId = accessKeyId;
  }
  final String? accessKeySecret = jsonConvert.convert<String>(json['AccessKeySecret']);
  if (accessKeySecret != null) {
    ossTokenEntity.accessKeySecret = accessKeySecret;
  }
  final String? expiration = jsonConvert.convert<String>(json['Expiration']);
  if (expiration != null) {
    ossTokenEntity.expiration = expiration;
  }
  return ossTokenEntity;
}

Map<String, dynamic> $OssTokenEntityToJson(OssTokenEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['SecurityToken'] = entity.securityToken;
  data['bucketName'] = entity.bucketName;
  data['endpoint'] = entity.endpoint;
  data['regionId'] = entity.regionId;
  data['AccessKeyId'] = entity.accessKeyId;
  data['AccessKeySecret'] = entity.accessKeySecret;
  data['Expiration'] = entity.expiration;
  return data;
}

extension OssTokenEntityExtension on OssTokenEntity {
  OssTokenEntity copyWith({
    String? securityToken,
    String? bucketName,
    String? endpoint,
    String? regionId,
    String? accessKeyId,
    String? accessKeySecret,
    String? expiration,
  }) {
    return OssTokenEntity()
      ..securityToken = securityToken ?? this.securityToken
      ..bucketName = bucketName ?? this.bucketName
      ..endpoint = endpoint ?? this.endpoint
      ..regionId = regionId ?? this.regionId
      ..accessKeyId = accessKeyId ?? this.accessKeyId
      ..accessKeySecret = accessKeySecret ?? this.accessKeySecret
      ..expiration = expiration ?? this.expiration;
  }
}