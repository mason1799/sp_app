import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/customer_sign_entity.dart';

CustomerSignProject $CustomerSignProjectFromJson(Map<String, dynamic> json) {
  final CustomerSignProject customerSignProject = CustomerSignProject();
  final String? projectName = jsonConvert.convert<String>(json['projectName']);
  if (projectName != null) {
    customerSignProject.projectName = projectName;
  }
  final String? projectLocation = jsonConvert.convert<String>(json['projectLocation']);
  if (projectLocation != null) {
    customerSignProject.projectLocation = projectLocation;
  }
  final int? unSignNumber = jsonConvert.convert<int>(json['unSignNumber']);
  if (unSignNumber != null) {
    customerSignProject.unSignNumber = unSignNumber;
  }
  final List<CustomerSignOrder>? orders = (json['orders'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CustomerSignOrder>(e) as CustomerSignOrder).toList();
  if (orders != null) {
    customerSignProject.orders = orders;
  }
  final List<CustomerSignOrder>? repairs = (json['repairs'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CustomerSignOrder>(e) as CustomerSignOrder).toList();
  if (repairs != null) {
    customerSignProject.repairs = repairs;
  }
  return customerSignProject;
}

Map<String, dynamic> $CustomerSignProjectToJson(CustomerSignProject entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['projectName'] = entity.projectName;
  data['projectLocation'] = entity.projectLocation;
  data['unSignNumber'] = entity.unSignNumber;
  data['orders'] = entity.orders?.map((v) => v.toJson()).toList();
  data['repairs'] = entity.repairs?.map((v) => v.toJson()).toList();
  return data;
}

extension CustomerSignProjectExtension on CustomerSignProject {
  CustomerSignProject copyWith({
    String? projectName,
    String? projectLocation,
    int? unSignNumber,
    List<CustomerSignOrder>? orders,
    List<CustomerSignOrder>? repairs,
  }) {
    return CustomerSignProject()
      ..projectName = projectName ?? this.projectName
      ..projectLocation = projectLocation ?? this.projectLocation
      ..unSignNumber = unSignNumber ?? this.unSignNumber
      ..orders = orders ?? this.orders
      ..repairs = repairs ?? this.repairs;
  }
}

CustomerSignOrder $CustomerSignOrderFromJson(Map<String, dynamic> json) {
  final CustomerSignOrder customerSignOrder = CustomerSignOrder();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    customerSignOrder.id = id;
  }
  final String? arrangeName = jsonConvert.convert<String>(json['arrangeName']);
  if (arrangeName != null) {
    customerSignOrder.arrangeName = arrangeName;
  }
  final String? buildingCode = jsonConvert.convert<String>(json['buildingCode']);
  if (buildingCode != null) {
    customerSignOrder.buildingCode = buildingCode;
  }
  final String? elevatorCode = jsonConvert.convert<String>(json['elevatorCode']);
  if (elevatorCode != null) {
    customerSignOrder.elevatorCode = elevatorCode;
  }
  final List<CustomerSignModule>? moduleList = (json['moduleList'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CustomerSignModule>(e) as CustomerSignModule).toList();
  if (moduleList != null) {
    customerSignOrder.moduleList = moduleList;
  }
  return customerSignOrder;
}

Map<String, dynamic> $CustomerSignOrderToJson(CustomerSignOrder entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['arrangeName'] = entity.arrangeName;
  data['buildingCode'] = entity.buildingCode;
  data['elevatorCode'] = entity.elevatorCode;
  data['moduleList'] = entity.moduleList?.map((v) => v.toJson()).toList();
  return data;
}

extension CustomerSignOrderExtension on CustomerSignOrder {
  CustomerSignOrder copyWith({
    int? id,
    String? arrangeName,
    String? buildingCode,
    String? elevatorCode,
    List<CustomerSignModule>? moduleList,
  }) {
    return CustomerSignOrder()
      ..id = id ?? this.id
      ..arrangeName = arrangeName ?? this.arrangeName
      ..buildingCode = buildingCode ?? this.buildingCode
      ..elevatorCode = elevatorCode ?? this.elevatorCode
      ..moduleList = moduleList ?? this.moduleList;
  }
}

CustomerSignModule $CustomerSignModuleFromJson(Map<String, dynamic> json) {
  final CustomerSignModule customerSignModule = CustomerSignModule();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    customerSignModule.name = name;
  }
  return customerSignModule;
}

Map<String, dynamic> $CustomerSignModuleToJson(CustomerSignModule entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  return data;
}

extension CustomerSignModuleExtension on CustomerSignModule {
  CustomerSignModule copyWith({
    String? name,
  }) {
    return CustomerSignModule()
      ..name = name ?? this.name;
  }
}

CustomerSignNumber $CustomerSignNumberFromJson(Map<String, dynamic> json) {
  final CustomerSignNumber customerSignNumber = CustomerSignNumber();
  final int? orderNumber = jsonConvert.convert<int>(json['orderNumber']);
  if (orderNumber != null) {
    customerSignNumber.orderNumber = orderNumber;
  }
  final int? repairNumber = jsonConvert.convert<int>(json['repairNumber']);
  if (repairNumber != null) {
    customerSignNumber.repairNumber = repairNumber;
  }
  return customerSignNumber;
}

Map<String, dynamic> $CustomerSignNumberToJson(CustomerSignNumber entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderNumber'] = entity.orderNumber;
  data['repairNumber'] = entity.repairNumber;
  return data;
}

extension CustomerSignNumberExtension on CustomerSignNumber {
  CustomerSignNumber copyWith({
    int? orderNumber,
    int? repairNumber,
  }) {
    return CustomerSignNumber()
      ..orderNumber = orderNumber ?? this.orderNumber
      ..repairNumber = repairNumber ?? this.repairNumber;
  }
}