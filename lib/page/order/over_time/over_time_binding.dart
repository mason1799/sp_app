import 'package:get/get.dart';

import 'over_time_logic.dart';

class OverTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OverTimeLogic());
  }
}
