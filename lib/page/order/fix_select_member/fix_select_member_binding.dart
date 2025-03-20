import 'package:get/get.dart';

import 'fix_select_member_logic.dart';

class FixSelectMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FixSelectMemberLogic());
  }
}
