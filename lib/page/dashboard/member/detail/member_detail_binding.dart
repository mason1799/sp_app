import 'package:get/get.dart';

import 'member_detail_logic.dart';

class MemberDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberDetailLogic());
  }
}
