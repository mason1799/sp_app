import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/check_stuffs_entity.dart';

CheckStuffsEntity $CheckStuffsEntityFromJson(Map<String, dynamic> json) {
  final CheckStuffsEntity checkStuffsEntity = CheckStuffsEntity();
  final String? groupName = jsonConvert.convert<String>(json['groupName']);
  if (groupName != null) {
    checkStuffsEntity.groupName = groupName;
  }
  final List<CheckStuffsChild>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CheckStuffsChild>(e) as CheckStuffsChild).toList();
  if (list != null) {
    checkStuffsEntity.list = list;
  }
  return checkStuffsEntity;
}

Map<String, dynamic> $CheckStuffsEntityToJson(CheckStuffsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['groupName'] = entity.groupName;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension CheckStuffsEntityExtension on CheckStuffsEntity {
  CheckStuffsEntity copyWith({
    String? groupName,
    List<CheckStuffsChild>? list,
  }) {
    return CheckStuffsEntity()
      ..groupName = groupName ?? this.groupName
      ..list = list ?? this.list;
  }
}

CheckStuffsChild $CheckStuffsChildFromJson(Map<String, dynamic> json) {
  final CheckStuffsChild checkStuffsChild = CheckStuffsChild();
  final int? checkId = jsonConvert.convert<int>(json['checkId']);
  if (checkId != null) {
    checkStuffsChild.checkId = checkId;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    checkStuffsChild.content = content;
  }
  final String? required = jsonConvert.convert<String>(json['required']);
  if (required != null) {
    checkStuffsChild.required = required;
  }
  final int? conclusion = jsonConvert.convert<int>(json['conclusion']);
  if (conclusion != null) {
    checkStuffsChild.conclusion = conclusion;
  }
  final int? selectDefault = jsonConvert.convert<int>(json['selectDefault']);
  if (selectDefault != null) {
    checkStuffsChild.selectDefault = selectDefault;
  }
  final String? picture = jsonConvert.convert<String>(json['picture']);
  if (picture != null) {
    checkStuffsChild.picture = picture;
  }
  final bool? isMandatory = jsonConvert.convert<bool>(json['isMandatory']);
  if (isMandatory != null) {
    checkStuffsChild.isMandatory = isMandatory;
  }
  return checkStuffsChild;
}

Map<String, dynamic> $CheckStuffsChildToJson(CheckStuffsChild entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['checkId'] = entity.checkId;
  data['content'] = entity.content;
  data['required'] = entity.required;
  data['conclusion'] = entity.conclusion;
  data['selectDefault'] = entity.selectDefault;
  data['picture'] = entity.picture;
  data['isMandatory'] = entity.isMandatory;
  return data;
}

extension CheckStuffsChildExtension on CheckStuffsChild {
  CheckStuffsChild copyWith({
    int? checkId,
    String? content,
    String? required,
    int? conclusion,
    int? selectDefault,
    String? picture,
    bool? isMandatory,
  }) {
    return CheckStuffsChild()
      ..checkId = checkId ?? this.checkId
      ..content = content ?? this.content
      ..required = required ?? this.required
      ..conclusion = conclusion ?? this.conclusion
      ..selectDefault = selectDefault ?? this.selectDefault
      ..picture = picture ?? this.picture
      ..isMandatory = isMandatory ?? this.isMandatory;
  }
}