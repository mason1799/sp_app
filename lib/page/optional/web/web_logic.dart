import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_state.dart';

class WebLogic extends GetxController {
  final WebState state = WebState();

  @override
  void onInit() {
    super.onInit();
    state.controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            state.progress = progress;
            update();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            if (state.controller == null) {
              return;
            }
            final _title = await state.controller!.runJavaScriptReturningResult('window.document.title');
            state.title = Platform.isIOS ? _title.toString() : _title.toString().substring(1, _title.toString().length - 1);
            update();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) => NavigationDecision.navigate,
        ),
      );
    if (state.url.startsWith('assets')) {
      state.controller!.loadFlutterAsset(state.url);
    } else {
      state.controller!.loadRequest(Uri.parse(state.url));
    }
    update();
  }
}
