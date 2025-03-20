import 'package:konesp/generated/json/base/json_convert_content.dart';
import 'package:konesp/entity/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final bool? isFirstLogin = jsonConvert.convert<bool>(json['isFirstLogin']);
  if (isFirstLogin != null) {
    loginEntity.isFirstLogin = isFirstLogin;
  }
  final String? sessionId = jsonConvert.convert<String>(json['sessionId']);
  if (sessionId != null) {
    loginEntity.sessionId = sessionId;
  }
  final String? expireRemind = jsonConvert.convert<String>(json['expireRemind']);
  if (expireRemind != null) {
    loginEntity.expireRemind = expireRemind;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isFirstLogin'] = entity.isFirstLogin;
  data['sessionId'] = entity.sessionId;
  data['expireRemind'] = entity.expireRemind;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    bool? isFirstLogin,
    String? sessionId,
    String? expireRemind,
  }) {
    return LoginEntity()
      ..isFirstLogin = isFirstLogin ?? this.isFirstLogin
      ..sessionId = sessionId ?? this.sessionId
      ..expireRemind = expireRemind ?? this.expireRemind;
  }
}