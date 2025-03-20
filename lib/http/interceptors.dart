import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/http/error_handle.dart';
import 'package:konesp/http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 刷新token机制，搁置使用
class TokenInterceptor extends QueuedInterceptor {
  Dio? _tokenDio;

  Future<String?> getToken() async {
    final Map<String, String> params = <String, String>{};
    params['refresh_token'] = GetStorage().read<String>(Constant.keyToken)!;
    try {
      _tokenDio ??= Dio();
      _tokenDio!.options = Http().dio.options;
      final Response<dynamic> response = await _tokenDio!.post<dynamic>('auth/refreshToken', data: params);
      if (response.statusCode == ExceptionHandle.success) {
        return (json.decode(response.data.toString()) as Map<String, dynamic>)['access_token'] as String;
      }
    } catch (e) {
    }
    return null;
  }

  @override
  Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    //401代表token过期
    if (response.statusCode == ExceptionHandle.unauthorized) {
      final String? accessToken = await getToken(); // 获取新的accessToken
      GetStorage().write(Constant.keyToken, accessToken);

      if (accessToken != null) {
        // 重新请求失败接口
        final RequestOptions request = response.requestOptions;
        final _platformInfo = await PackageInfo.fromPlatform();
        request.headers['Cookie'] = 'KONE-SP=$accessToken;equipmentType=${Platform.isAndroid ? 'android' : 'iOS'};version=${_platformInfo.version}';
        final Options options = Options(
          headers: request.headers,
          method: request.method,
        );

        try {
          /// 避免重复执行拦截器，使用tokenDio
          final Response<dynamic> response = await _tokenDio!.request<dynamic>(
            request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: options,
            onReceiveProgress: request.onReceiveProgress,
          );
          return handler.next(response);
        } on DioException catch (e) {
          return handler.reject(e);
        }
      }
    }
    super.onResponse(response, handler);
  }
}
