import 'package:get/get.dart';

import 'equipment_detail_logic.dart';

class EquipmentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EquipmentDetailLogic());
  }
}
