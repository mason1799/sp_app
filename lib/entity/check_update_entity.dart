import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/check_update_entity.g.dart';

@JsonSerializable()
class CheckUpdateEntity {
  String? versionNumber;
  String? url;
  bool? forceUpdate;
  String? remark;

  CheckUpdateEntity();

  factory CheckUpdateEntity.fromJson(Map<String, dynamic> json) => $CheckUpdateEntityFromJson(json);

  Map<String, dynamic> toJson() => $CheckUpdateEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
