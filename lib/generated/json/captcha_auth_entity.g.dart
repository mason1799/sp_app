import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/captcha_auth_entity.dart';

CaptchaAuthEntity $CaptchaAuthEntityFromJson(Map<String, dynamic> json) {
  final CaptchaAuthEntity captchaAuthEntity = CaptchaAuthEntity();
  final String? originalImageBase64 = jsonConvert.convert<String>(json['originalImageBase64']);
  if (originalImageBase64 != null) {
    captchaAuthEntity.originalImageBase64 = originalImageBase64;
  }
  final String? secretKey = jsonConvert.convert<String>(json['secretKey']);
  if (secretKey != null) {
    captchaAuthEntity.secretKey = secretKey;
  }
  final String? jigsawImageBase64 = jsonConvert.convert<String>(json['jigsawImageBase64']);
  if (jigsawImageBase64 != null) {
    captchaAuthEntity.jigsawImageBase64 = jigsawImageBase64;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    captchaAuthEntity.token = token;
  }
  return captchaAuthEntity;
}

Map<String, dynamic> $CaptchaAuthEntityToJson(CaptchaAuthEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['originalImageBase64'] = entity.originalImageBase64;
  data['secretKey'] = entity.secretKey;
  data['jigsawImageBase64'] = entity.jigsawImageBase64;
  data['token'] = entity.token;
  return data;
}

extension CaptchaAuthEntityExtension on CaptchaAuthEntity {
  CaptchaAuthEntity copyWith({
    String? originalImageBase64,
    String? secretKey,
    String? jigsawImageBase64,
    String? token,
  }) {
    return CaptchaAuthEntity()
      ..originalImageBase64 = originalImageBase64 ?? this.originalImageBase64
      ..secretKey = secretKey ?? this.secretKey
      ..jigsawImageBase64 = jigsawImageBase64 ?? this.jigsawImageBase64
      ..token = token ?? this.token;
  }
}