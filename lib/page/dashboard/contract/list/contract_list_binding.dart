import 'package:get/get.dart';

import 'contract_list_logic.dart';

class ContractListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContractListLogic());
  }
}
