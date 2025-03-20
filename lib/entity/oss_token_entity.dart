import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/oss_token_entity.g.dart';

@JsonSerializable()
class OssTokenEntity {
  @JSONField(name: "SecurityToken")
  String? securityToken;
  String? bucketName;
  String? endpoint;
  String? regionId;
  @JSONField(name: "AccessKeyId")
  String? accessKeyId;
  @JSONField(name: "AccessKeySecret")
  String? accessKeySecret;
  @JSONField(name: "Expiration")
  String? expiration;

  OssTokenEntity();

  factory OssTokenEntity.fromJson(Map<String, dynamic> json) => $OssTokenEntityFromJson(json);

  Map<String, dynamic> toJson() => $OssTokenEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
