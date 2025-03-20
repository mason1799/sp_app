import 'package:get/get.dart';
import 'package:konesp/routes/app_routes.dart';

import 'search_result_state.dart';

class SearchResultLogic extends GetxController {
  final SearchResultState state = SearchResultState();

  toSearch() {
    Get.offNamed(Routes.search, arguments: {'type': 0, 'keyword': state.keyword});
  }

  animateTo(int index) {
    if (index < 0 || index > 2) {
      return;
    }
    state.tabController?.animateTo(index);
  }
}
