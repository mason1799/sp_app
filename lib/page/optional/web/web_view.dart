import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/title_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_logic.dart';

class WebPage extends StatelessWidget {
  final logic = Get.put(WebLogic());
  final state = Get.find<WebLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebLogic>(builder: (_) {
      return Scaffold(
        appBar: TitleBar(
          title: state.title ?? '',
          bottomWidget: state.progress != 100
              ? LinearProgressIndicator(
                  value: state.progress / 100,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colours.primary),
                  minHeight: 1.w,
                )
              : SizedBox(),
        ),
        body: state.controller == null ? SizedBox() : WebViewWidget(controller: state.controller!),
      );
    });
  }
}
