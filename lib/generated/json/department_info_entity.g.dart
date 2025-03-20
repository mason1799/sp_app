import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/department_info_entity.dart';

DepartmentInfoEntity $DepartmentInfoEntityFromJson(Map<String, dynamic> json) {
  final DepartmentInfoEntity departmentInfoEntity = DepartmentInfoEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    departmentInfoEntity.id = id;
  }
  final String? parentId = jsonConvert.convert<String>(json['parentId']);
  if (parentId != null) {
    departmentInfoEntity.parentId = parentId;
  }
  final double? sort = jsonConvert.convert<double>(json['sort']);
  if (sort != null) {
    departmentInfoEntity.sort = sort;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    departmentInfoEntity.name = name;
  }
  final List<DepartmentInfoEntity>? children = (json['children'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<DepartmentInfoEntity>(e) as DepartmentInfoEntity).toList();
  if (children != null) {
    departmentInfoEntity.children = children;
  }
  final double? directorId = jsonConvert.convert<double>(json['directorId']);
  if (directorId != null) {
    departmentInfoEntity.directorId = directorId;
  }
  final String? directorName = jsonConvert.convert<String>(json['directorName']);
  if (directorName != null) {
    departmentInfoEntity.directorName = directorName;
  }
  final String? directorPhone = jsonConvert.convert<String>(json['directorPhone']);
  if (directorPhone != null) {
    departmentInfoEntity.directorPhone = directorPhone;
  }
  final double? employeeNumber = jsonConvert.convert<double>(json['employeeNumber']);
  if (employeeNumber != null) {
    departmentInfoEntity.employeeNumber = employeeNumber;
  }
  final double? level = jsonConvert.convert<double>(json['level']);
  if (level != null) {
    departmentInfoEntity.level = level;
  }
  return departmentInfoEntity;
}

Map<String, dynamic> $DepartmentInfoEntityToJson(DepartmentInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['parentId'] = entity.parentId;
  data['sort'] = entity.sort;
  data['name'] = entity.name;
  data['children'] = entity.children?.map((v) => v.toJson()).toList();
  data['directorId'] = entity.directorId;
  data['directorName'] = entity.directorName;
  data['directorPhone'] = entity.directorPhone;
  data['employeeNumber'] = entity.employeeNumber;
  data['level'] = entity.level;
  return data;
}

extension DepartmentInfoEntityExtension on DepartmentInfoEntity {
  DepartmentInfoEntity copyWith({
    String? id,
    String? parentId,
    double? sort,
    String? name,
    List<DepartmentInfoEntity>? children,
    double? directorId,
    String? directorName,
    String? directorPhone,
    double? employeeNumber,
    double? level,
  }) {
    return DepartmentInfoEntity()
      ..id = id ?? this.id
      ..parentId = parentId ?? this.parentId
      ..sort = sort ?? this.sort
      ..name = name ?? this.name
      ..children = children ?? this.children
      ..directorId = directorId ?? this.directorId
      ..directorName = directorName ?? this.directorName
      ..directorPhone = directorPhone ?? this.directorPhone
      ..employeeNumber = employeeNumber ?? this.employeeNumber
      ..level = level ?? this.level;
  }
}