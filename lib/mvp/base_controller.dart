import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/http/base_entity.dart';
import 'package:konesp/http/http.dart';
import 'package:konesp/mvp/imvp.dart';
import 'package:konesp/util/toast_util.dart';
import 'package:konesp/widget/progress_dialog.dart';

class BaseController extends GetxController implements IMvpView {
  BaseController() {
    _cancelToken = CancelToken();
  }

  late CancelToken _cancelToken;
  bool _isShowDialog = false;

  @override
  void onClose() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
    super.onClose();
  }

  @override
  void closeProgress() {
    if (_isShowDialog) {
      _isShowDialog = false;
      Get.back();
    }
  }

  @override
  void showProgress() {
    /// 避免重复弹出
    if (!_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog<void>(
          context: Get.context!,
          barrierDismissible: false,
          barrierColor: const Color(0x00FFFFFF), // 默认dialog背景色为半透明黑色，这里修改为透明（1.20添加属性）
          builder: (_) {
            return WillPopScope(
              onWillPop: () async {
                // 拦截到返回键，证明dialog被手动关闭
                _isShowDialog = false;
                return Future.value(true);
              },
              child: const ProgressDialog(),
            );
          },
        );
      } catch (e) {
        /// 异常原因主要是页面没有build完成就调用Progress。
        debugPrint(e.toString());
      }
    }
  }

  @override
  void showToast(String? string) {
    closeProgress();
    Toast.show(string);
  }

  Future<BaseEntity<T>> get<T>(String url, {Map<String, dynamic>? params, CancelToken? cancelToken}) {
    return Http().asyncQuery(url, method: Method.get, queryParameters: params, cancelToken: cancelToken ?? _cancelToken);
  }

  Future<BaseEntity<T>> post<T>(String url, {Object? params, CancelToken? cancelToken}) {
    return Http().asyncQuery(url, method: Method.post, params: params, cancelToken: cancelToken ?? _cancelToken);
  }

  Future<BaseEntity<T>> delete<T>(String url, {Map<String, dynamic>? params, CancelToken? cancelToken}) {
    return Http().asyncQuery(url, method: Method.delete, queryParameters: params, cancelToken: cancelToken ?? _cancelToken);
  }
}
