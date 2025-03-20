import 'package:get/get.dart';

import 'service_group_list_logic.dart';

class ServiceGroupListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceGroupListLogic());
  }
}
