import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/regular_order_process_entity.dart';

RegularOrderProcessEntity $RegularOrderProcessEntityFromJson(Map<String, dynamic> json) {
  final RegularOrderProcessEntity regularOrderProcessEntity = RegularOrderProcessEntity();
  final int? orderId = jsonConvert.convert<int>(json['orderId']);
  if (orderId != null) {
    regularOrderProcessEntity.orderId = orderId;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    regularOrderProcessEntity.type = type;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    regularOrderProcessEntity.username = username;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    regularOrderProcessEntity.phone = phone;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    regularOrderProcessEntity.location = location;
  }
  final String? startImage = jsonConvert.convert<String>(json['startImage']);
  if (startImage != null) {
    regularOrderProcessEntity.startImage = startImage;
  }
  final String? endImage = jsonConvert.convert<String>(json['endImage']);
  if (endImage != null) {
    regularOrderProcessEntity.endImage = endImage;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    regularOrderProcessEntity.createTime = createTime;
  }
  final String? approvalReason = jsonConvert.convert<String>(json['approvalReason']);
  if (approvalReason != null) {
    regularOrderProcessEntity.approvalReason = approvalReason;
  }
  return regularOrderProcessEntity;
}

Map<String, dynamic> $RegularOrderProcessEntityToJson(RegularOrderProcessEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderId'] = entity.orderId;
  data['type'] = entity.type;
  data['username'] = entity.username;
  data['phone'] = entity.phone;
  data['location'] = entity.location;
  data['startImage'] = entity.startImage;
  data['endImage'] = entity.endImage;
  data['createTime'] = entity.createTime;
  data['approvalReason'] = entity.approvalReason;
  return data;
}

extension RegularOrderProcessEntityExtension on RegularOrderProcessEntity {
  RegularOrderProcessEntity copyWith({
    int? orderId,
    int? type,
    String? username,
    String? phone,
    String? location,
    String? startImage,
    String? endImage,
    String? createTime,
    String? approvalReason,
  }) {
    return RegularOrderProcessEntity()
      ..orderId = orderId ?? this.orderId
      ..type = type ?? this.type
      ..username = username ?? this.username
      ..phone = phone ?? this.phone
      ..location = location ?? this.location
      ..startImage = startImage ?? this.startImage
      ..endImage = endImage ?? this.endImage
      ..createTime = createTime ?? this.createTime
      ..approvalReason = approvalReason ?? this.approvalReason;
  }
}