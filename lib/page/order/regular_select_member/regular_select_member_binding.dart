import 'package:get/get.dart';

import 'regular_select_member_logic.dart';

class RegularSelectMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegularSelectMemberLogic());
  }
}
