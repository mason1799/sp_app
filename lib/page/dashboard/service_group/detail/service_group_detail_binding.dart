import 'package:get/get.dart';

import 'service_group_detail_logic.dart';

class ServiceGroupDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceGroupDetailLogic());
  }
}
