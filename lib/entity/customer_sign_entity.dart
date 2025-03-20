import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/customer_sign_entity.g.dart';

@JsonSerializable()
class CustomerSignProject {
  String? projectName;
  String? projectLocation;
  int? unSignNumber;
  List<CustomerSignOrder>? orders;
  List<CustomerSignOrder>? repairs;

  CustomerSignProject();

  factory CustomerSignProject.fromJson(Map<String, dynamic> json) => $CustomerSignProjectFromJson(json);

  Map<String, dynamic> toJson() => $CustomerSignProjectToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CustomerSignOrder {
  int? id;
  String? arrangeName;
  String? buildingCode;
  String? elevatorCode;
  List<CustomerSignModule>? moduleList;

  CustomerSignOrder();

  factory CustomerSignOrder.fromJson(Map<String, dynamic> json) => $CustomerSignOrderFromJson(json);

  Map<String, dynamic> toJson() => $CustomerSignOrderToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CustomerSignModule {
  String? name;

  CustomerSignModule();

  factory CustomerSignModule.fromJson(Map<String, dynamic> json) => $CustomerSignModuleFromJson(json);

  Map<String, dynamic> toJson() => $CustomerSignModuleToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CustomerSignNumber {
  int? orderNumber;
  int? repairNumber;

  CustomerSignNumber();

  factory CustomerSignNumber.fromJson(Map<String, dynamic> json) => $CustomerSignNumberFromJson(json);

  Map<String, dynamic> toJson() => $CustomerSignNumberToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
