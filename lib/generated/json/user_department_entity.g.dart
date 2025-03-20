import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/user_department_entity.dart';

UserDepartmentEntity $UserDepartmentEntityFromJson(Map<String, dynamic> json) {
  final UserDepartmentEntity userDepartmentEntity = UserDepartmentEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userDepartmentEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userDepartmentEntity.name = name;
  }
  return userDepartmentEntity;
}

Map<String, dynamic> $UserDepartmentEntityToJson(UserDepartmentEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  return data;
}

extension UserDepartmentEntityExtension on UserDepartmentEntity {
  UserDepartmentEntity copyWith({
    String? id,
    String? name,
  }) {
    return UserDepartmentEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name;
  }
}