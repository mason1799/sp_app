import 'package:get/get.dart';

import 'safeguard_signature_logic.dart';

class SafeguardSignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SafeguardSignatureLogic());
  }
}
