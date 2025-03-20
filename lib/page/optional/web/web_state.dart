import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebState {
  late String url;
  String? title;
  late int progress;
  WebViewController? controller;

  WebState() {
    url = Get.arguments['url'];
    progress = 0;
  }
}
