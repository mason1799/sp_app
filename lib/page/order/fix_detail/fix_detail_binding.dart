import 'package:get/get.dart';

import 'fix_detail_logic.dart';

class FixDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FixDetailLogic());
  }
}
