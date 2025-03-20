import 'package:get/get.dart';

import 'check_code_logic.dart';

class CheckCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckCodeLogic());
  }
}
