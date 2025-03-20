import 'package:get/get.dart';

import 'member_assist_logic.dart';

class MemberAssistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberAssistLogic());
  }
}
