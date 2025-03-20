import 'package:get/get.dart';

import 'regular_detail_logic.dart';

class RegularDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegularDetailLogic());
  }
}
