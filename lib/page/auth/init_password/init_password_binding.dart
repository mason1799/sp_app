import 'package:get/get.dart';

import 'init_password_logic.dart';

class InitPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitPasswordLogic());
  }
}
