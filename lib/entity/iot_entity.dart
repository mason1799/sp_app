import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/iot_entity.g.dart';
import 'dart:convert';
export 'package:konesp/generated/json/iot_entity.g.dart';

@JsonSerializable()
class IotEntity {
	String? currentFloor;
	double? currentSpeed;
	int? elevatorOperation;
	int? runDirection;
	int? safeCircuit;
	int? status;
	int? temperature;

	IotEntity();

	factory IotEntity.fromJson(Map<String, dynamic> json) => $IotEntityFromJson(json);

	Map<String, dynamic> toJson() => $IotEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}