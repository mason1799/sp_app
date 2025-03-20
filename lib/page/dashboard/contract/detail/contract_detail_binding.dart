import 'package:get/get.dart';

import 'contract_detail_logic.dart';

class ContractDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContractDetailLogic());
  }
}
