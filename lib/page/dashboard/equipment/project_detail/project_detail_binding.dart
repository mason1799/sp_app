import 'package:get/get.dart';

import 'project_detail_logic.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectDetailLogic());
  }
}
