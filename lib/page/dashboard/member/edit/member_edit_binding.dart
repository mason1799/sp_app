import 'package:get/get.dart';

import 'member_edit_logic.dart';

class MemberEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberEditLogic());
  }
}
