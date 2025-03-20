import 'package:get/get.dart';

import 'equipment_edit_logic.dart';

class EquipmentEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EquipmentEditLogic());
  }
}
