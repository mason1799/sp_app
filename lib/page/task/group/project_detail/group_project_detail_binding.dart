import 'package:get/get.dart';

import 'group_project_detail_logic.dart';

class GroupProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupProjectDetailLogic());
  }
}
