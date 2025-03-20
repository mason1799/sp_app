import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/weather_entity.g.dart';
import 'dart:convert';
export 'package:konesp/generated/json/weather_entity.g.dart';

@JsonSerializable()
class WeatherEntity {
	String? city;
	String? adcode;
	String? weather;
	String? temperature;

	WeatherEntity();

	factory WeatherEntity.fromJson(Map<String, dynamic> json) => $WeatherEntityFromJson(json);

	Map<String, dynamic> toJson() => $WeatherEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}