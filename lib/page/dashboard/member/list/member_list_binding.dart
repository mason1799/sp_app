import 'package:get/get.dart';

import 'member_list_logic.dart';

class MemberListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberListLogic());
  }
}
