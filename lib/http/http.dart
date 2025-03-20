import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/http/base_entity.dart';
import 'package:konesp/http/error_handle.dart';
import 'package:konesp/http/white_list.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/object_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Http {
  factory Http() => _singleton;

  Http._() {
    final BaseOptions _options = BaseOptions(
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      sendTimeout: Duration(seconds: 15),
      baseUrl: Get.find<BuildEnvironment>().baseUrl,
      validateStatus: (status) {
        return true;
      },
    );
    _dio = Dio(_options);
    if (kDebugMode) {
      dio.interceptors.add(HttpFormatter());
    }
    if (Get.find<BuildEnvironment>().flavor != BuildFlavor.prod) {
      enableProxy();
    }
  }

  static final Http _singleton = Http._();

  static Http get instance => Http();

  static late Dio _dio;

  Dio get dio => _dio;

  Future<BaseEntity<T>> get<T>(String url, {Map<String, dynamic>? params, CancelToken? cancelToken}) {
    return asyncQuery(url, method: Method.get, queryParameters: params, cancelToken: cancelToken);
  }

  Future<BaseEntity<T>> post<T>(String url, {Object? params, CancelToken? cancelToken}) {
    return asyncQuery(url, method: Method.post, params: params, cancelToken: cancelToken);
  }

  void enableProxy() {
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return null;
    };
  }

  //callback形式的请求 默认post形式
  void callbackQuery<T>(
    String url, {
    Method method = Method.post,
    NetSuccessCallback<T?>? onSuccess,
    NetSuccessPageCallback<T?>? onPageSuccess,
    NetErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    Stream.fromFuture(_request<T>(
      method,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    )).asBroadcastStream().listen((result) async {
      if (result.code == 401) {
        await StoreLogic.to.whenSignOut();
        _callbackError(result.code, result.msg, onError);
      } else if (result.code == 20000) {
        if (onPageSuccess != null) {
          onPageSuccess.call(result.data, result.hasMore);
        } else {
          onSuccess?.call(result.data);
        }
      } else {
        _callbackError(result.code, result.msg, onError);
      }
    }, onError: (dynamic e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _callbackError(error.code, error.msg, onError);
    });
  }

  //async形式的请求 默认post形式
  Future<BaseEntity<T>> asyncQuery<T>(
    String url, {
    Method method = Method.post,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final _response = await _dio.request(
        url,
        data: params,
        queryParameters: queryParameters,
        options: await _checkOptions(method.value, options, url),
        cancelToken: cancelToken,
      );
      BaseEntity<T> _result = BaseEntity<T>.fromJson(_response.data);
      if (_result.code == 401) {
        await StoreLogic.to.whenSignOut();
        return _onError(_result.code, _result.msg);
      }
      return _result;
    } catch (e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      return _onError(error.code, error.msg);
    }
  }

  //用于滑动验证码相关接口获取，数据返回格式需要重新组装。
  Future<BaseEntity<T>> captchaQuery<T>(
    String url, {
    Method method = Method.post,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final _response = await _dio.request(
        url,
        data: params,
        queryParameters: queryParameters,
        options: await _checkOptions(method.value, options, url),
        cancelToken: cancelToken,
      );
      if (_response.statusCode == 200) {
        Map<String, dynamic> _map = _response.data;
        if (_map.containsKey('repCode') && _map['repCode'] == '0000' && _map.containsKey('repData')) {
          return BaseEntity<T>.fromJson({'code': 20000, 'msg': 'success', 'data': _map['repData']});
        }
      }
      return _onError(99999, '解析失败');
    } catch (e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      return _onError(error.code, error.msg);
    }
  }

  //用于高德sdk天气相关接口获取，数据返回格式需要重新组装。
  Future<BaseEntity<T>> weatherQuery<T>(
    String url, {
    Method method = Method.get,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final _response = await _dio.request(
        url,
        options: Options()..method = method.value,
        cancelToken: cancelToken,
      );
      if (_response.statusCode == 200) {
        Map<String, dynamic> _map = _response.data;
        if (_map.containsKey('status') && _map['status'] == '1' && _map.containsKey('lives')) {
          return BaseEntity<T>.fromJson({'code': 20000, 'msg': 'success', 'data': _map['lives']});
        }
      }
      return _onError(99999, '解析失败');
    } catch (e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      return _onError(error.code, error.msg);
    }
  }

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(
    Method method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final _response = await _dio.request(
      url,
      data: data,
      queryParameters: queryParameters,
      options: await _checkOptions(method.value, options, url),
      cancelToken: cancelToken,
    );
    try {
      return BaseEntity<T>.fromJson(_response.data);
    } catch (e) {
      debugPrint(e.toString());
      return BaseEntity<T>(ExceptionHandle.parse_error, '数据解析错误！', null);
    }
  }

  Future<Options> _checkOptions(String method, Options? options, String path) async {
    final _platformInfo = await PackageInfo.fromPlatform();
    options ??= Options();
    options.method = method;
    final _token = GetStorage().read<String>(Constant.keyToken);
    final _map = {
      'EquipmentType': Platform.isAndroid ? 'android' : 'iOS',
      'Version': _platformInfo.version,
    };
    if (!whiteList.contains(path) && ObjectUtil.isNotEmpty(_token)) {
      _map['SessionId'] = _token!;
    }
    return options.copyWith(headers: _map);
  }

  BaseEntity<T> _onError<T>(int? code, String msg) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    } else if (code == ExceptionHandle.cancel_error) {
      msg = '';
    }
    debugPrint('接口请求异常： code: $code, msg: $msg');
    return BaseEntity(code, msg, null);
  }

  void _callbackError(int? code, String msg, NetErrorCallback? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    } else if (code == ExceptionHandle.cancel_error) {
      msg = '';
    }
    debugPrint('接口请求异常： code: $code, msg: $msg');
    onError?.call(code, msg);
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioException && CancelToken.isCancel(e)) {
      debugPrint('取消请求接口： $url');
    }
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

enum Method { get, post, delete }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'DELETE'][index];
}

typedef NetSuccessCallback<T> = void Function(T data);
typedef NetSuccessPageCallback<T> = void Function(T data, bool hasMore);
typedef NetErrorCallback = void Function(int code, String msg);
