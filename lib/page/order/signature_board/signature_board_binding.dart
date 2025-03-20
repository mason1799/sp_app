import 'package:get/get.dart';

import 'signature_board_logic.dart';

class SignatureBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignatureBoardLogic());
  }
}
