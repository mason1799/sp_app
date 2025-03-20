import 'package:get/get.dart';

import 'message_list_logic.dart';

class MessageListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageListLogic());
  }
}
