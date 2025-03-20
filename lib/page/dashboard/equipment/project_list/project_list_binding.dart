import 'package:get/get.dart';

import 'project_list_logic.dart';

class ProjectListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectListLogic());
  }
}
