import 'package:get/get.dart';

import 'process_logic.dart';

class ProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProcessLogic());
  }
}
