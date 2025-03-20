import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/location_entity.g.dart';

@JsonSerializable()
class LocationEntity {
  double? longitude;
  double? latitude;
  String? address;
  String? city;
  String? adCode;

  LocationEntity();

  factory LocationEntity.fromJson(Map<String, dynamic> json) => $LocationEntityFromJson(json);

  Map<String, dynamic> toJson() => $LocationEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
