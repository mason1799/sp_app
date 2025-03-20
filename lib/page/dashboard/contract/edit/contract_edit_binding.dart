import 'package:get/get.dart';

import 'contract_edit_logic.dart';

class ContractEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContractEditLogic());
  }
}
