import 'package:get/get.dart';

import 'customer_signature_logic.dart';

class CustomerSignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerSignatureLogic());
  }
}
