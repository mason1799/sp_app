import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/upload_file_entity.g.dart';

@JsonSerializable()
class UploadFileEntity {
  String? ossKey;
  String? path;

  UploadFileEntity();

  factory UploadFileEntity.fromJson(Map<String, dynamic> json) => $UploadFileEntityFromJson(json);

  Map<String, dynamic> toJson() => $UploadFileEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
