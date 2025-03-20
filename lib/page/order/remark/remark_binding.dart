import 'package:get/get.dart';

import 'remark_logic.dart';

class RemarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemarkLogic());
  }
}
