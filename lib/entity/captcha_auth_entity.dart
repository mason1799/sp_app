import 'dart:convert';

import 'package:konesp/generated/json/base/json_field.dart';
import 'package:konesp/generated/json/captcha_auth_entity.g.dart';

export 'package:konesp/generated/json/captcha_auth_entity.g.dart';

@JsonSerializable()
class CaptchaAuthEntity {
	String? originalImageBase64;
	String? secretKey;
	String? jigsawImageBase64;
	String? token;

	CaptchaAuthEntity();

	factory CaptchaAuthEntity.fromJson(Map<String, dynamic> json) => $CaptchaAuthEntityFromJson(json);

	Map<String, dynamic> toJson() => $CaptchaAuthEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}