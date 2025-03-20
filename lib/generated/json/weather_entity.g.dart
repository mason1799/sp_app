import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/weather_entity.dart';

WeatherEntity $WeatherEntityFromJson(Map<String, dynamic> json) {
  final WeatherEntity weatherEntity = WeatherEntity();
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    weatherEntity.city = city;
  }
  final String? adcode = jsonConvert.convert<String>(json['adcode']);
  if (adcode != null) {
    weatherEntity.adcode = adcode;
  }
  final String? weather = jsonConvert.convert<String>(json['weather']);
  if (weather != null) {
    weatherEntity.weather = weather;
  }
  final String? temperature = jsonConvert.convert<String>(json['temperature']);
  if (temperature != null) {
    weatherEntity.temperature = temperature;
  }
  return weatherEntity;
}

Map<String, dynamic> $WeatherEntityToJson(WeatherEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['city'] = entity.city;
  data['adcode'] = entity.adcode;
  data['weather'] = entity.weather;
  data['temperature'] = entity.temperature;
  return data;
}

extension WeatherEntityExtension on WeatherEntity {
  WeatherEntity copyWith({
    String? city,
    String? adcode,
    String? weather,
    String? temperature,
  }) {
    return WeatherEntity()
      ..city = city ?? this.city
      ..adcode = adcode ?? this.adcode
      ..weather = weather ?? this.weather
      ..temperature = temperature ?? this.temperature;
  }
}