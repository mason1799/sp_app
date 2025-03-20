import 'package:get/get.dart';

import 'department_logic.dart';

class DepartmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DepartmentLogic());
  }
}
