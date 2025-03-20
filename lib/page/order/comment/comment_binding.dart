import 'package:get/get.dart';

import 'comment_logic.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommentLogic());
  }
}
