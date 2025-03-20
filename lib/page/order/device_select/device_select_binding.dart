import 'package:get/get.dart';

import 'device_select_logic.dart';

class DeviceSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeviceSelectLogic());
  }
}
