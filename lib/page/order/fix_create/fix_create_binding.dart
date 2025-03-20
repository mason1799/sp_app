import 'package:get/get.dart';

import 'fix_create_logic.dart';

class FixCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FixCreateLogic());
  }
}
