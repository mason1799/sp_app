/*
 * 白名单（不需要传token）
 */
import 'package:konesp/config/api.dart';

List<String> whiteList = [
  Api.login,
  Api.getCaptcha,
  Api.checkCaptcha,
  Api.sendValidateCode,
  Api.checkValidateCode,
  Api.checkUpdate,
];