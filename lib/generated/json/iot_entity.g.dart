import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/iot_entity.dart';

IotEntity $IotEntityFromJson(Map<String, dynamic> json) {
  final IotEntity iotEntity = IotEntity();
  final String? currentFloor = jsonConvert.convert<String>(json['currentFloor']);
  if (currentFloor != null) {
    iotEntity.currentFloor = currentFloor;
  }
  final double? currentSpeed = jsonConvert.convert<double>(json['currentSpeed']);
  if (currentSpeed != null) {
    iotEntity.currentSpeed = currentSpeed;
  }
  final int? elevatorOperation = jsonConvert.convert<int>(json['elevatorOperation']);
  if (elevatorOperation != null) {
    iotEntity.elevatorOperation = elevatorOperation;
  }
  final int? runDirection = jsonConvert.convert<int>(json['runDirection']);
  if (runDirection != null) {
    iotEntity.runDirection = runDirection;
  }
  final int? safeCircuit = jsonConvert.convert<int>(json['safeCircuit']);
  if (safeCircuit != null) {
    iotEntity.safeCircuit = safeCircuit;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    iotEntity.status = status;
  }
  final int? temperature = jsonConvert.convert<int>(json['temperature']);
  if (temperature != null) {
    iotEntity.temperature = temperature;
  }
  return iotEntity;
}

Map<String, dynamic> $IotEntityToJson(IotEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['currentFloor'] = entity.currentFloor;
  data['currentSpeed'] = entity.currentSpeed;
  data['elevatorOperation'] = entity.elevatorOperation;
  data['runDirection'] = entity.runDirection;
  data['safeCircuit'] = entity.safeCircuit;
  data['status'] = entity.status;
  data['temperature'] = entity.temperature;
  return data;
}

extension IotEntityExtension on IotEntity {
  IotEntity copyWith({
    String? currentFloor,
    double? currentSpeed,
    int? elevatorOperation,
    int? runDirection,
    int? safeCircuit,
    int? status,
    int? temperature,
  }) {
    return IotEntity()
      ..currentFloor = currentFloor ?? this.currentFloor
      ..currentSpeed = currentSpeed ?? this.currentSpeed
      ..elevatorOperation = elevatorOperation ?? this.elevatorOperation
      ..runDirection = runDirection ?? this.runDirection
      ..safeCircuit = safeCircuit ?? this.safeCircuit
      ..status = status ?? this.status
      ..temperature = temperature ?? this.temperature;
  }
}