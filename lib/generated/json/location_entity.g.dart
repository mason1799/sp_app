import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/location_entity.dart';

LocationEntity $LocationEntityFromJson(Map<String, dynamic> json) {
  final LocationEntity locationEntity = LocationEntity();
  final double? longitude = jsonConvert.convert<double>(json['longitude']);
  if (longitude != null) {
    locationEntity.longitude = longitude;
  }
  final double? latitude = jsonConvert.convert<double>(json['latitude']);
  if (latitude != null) {
    locationEntity.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    locationEntity.address = address;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    locationEntity.city = city;
  }
  final String? adCode = jsonConvert.convert<String>(json['adCode']);
  if (adCode != null) {
    locationEntity.adCode = adCode;
  }
  return locationEntity;
}

Map<String, dynamic> $LocationEntityToJson(LocationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  data['city'] = entity.city;
  data['adCode'] = entity.adCode;
  return data;
}

extension LocationEntityExtension on LocationEntity {
  LocationEntity copyWith({
    double? longitude,
    double? latitude,
    String? address,
    String? city,
    String? adCode,
  }) {
    return LocationEntity()
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address
      ..city = city ?? this.city
      ..adCode = adCode ?? this.adCode;
  }
}