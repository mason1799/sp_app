import 'package:get/get.dart';

import 'search_task_result_logic.dart';

class SearchTaskResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchTaskResultLogic());
  }
}
