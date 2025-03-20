import 'package:get/get.dart';

import 'service_group_parent_logic.dart';

class ServiceGroupParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceGroupParentLogic());
  }
}
