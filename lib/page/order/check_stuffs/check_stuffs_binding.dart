import 'package:get/get.dart';

import 'check_stuffs_logic.dart';

class CheckStuffsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckStuffsLogic());
  }
}
