import 'package:get/get.dart';

import 'assist_not_signs_logic.dart';

class AssistNotSignsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssistNotSignsLogic());
  }
}
