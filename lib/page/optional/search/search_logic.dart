import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';

import 'search_state.dart';

class SearchLogic extends BaseController {
  final SearchState state = SearchState();

  @override
  onInit() {
    super.onInit();
    state.historyList = List<String>.from(GetStorage().read(state.type == 0 ? Constant.keyEquipmentHistory : Constant.keyTaskHistory) ?? []);
    state.inputController.text = state.keyword ?? '';
  }

  toSearchItem(String _content) {
    if (ObjectUtil.isEmpty(_content)) {
      showToast('请输入搜索关键字');
      return;
    }
    _toSearchResult(_content);
  }

  clearHistory() async {
    Get.dialog(
      ConfirmDialog(
        content: '确定清空历史搜索？',
        onConfirm: () async {
          state.historyList.clear();
          GetStorage().remove(state.type == 0 ? Constant.keyEquipmentHistory : Constant.keyTaskHistory);
          update();
        },
      ),
    );
  }

  toSearchText() async {
    String _content = state.inputController.text.trim();
    if (ObjectUtil.isEmpty(_content)) {
      showToast('请输入搜索关键字');
      return;
    }
    _toSearchResult(_content);
  }

  _toSearchResult(String keyword) async {
    Get.focusScope?.unfocus();
    await Future.delayed(
      Duration(milliseconds: 300),
      () => Get.offNamed(state.type == 0 ? Routes.searchEquipmentResult : Routes.searchTaskResult, arguments: {'keyword': keyword}),
    );
    if (state.historyList.contains(keyword)) {
      state.historyList.remove(keyword);
    } else {
      if (state.historyList.length >= 20) {
        state.historyList.removeLast();
      }
    }
    state.historyList.insert(0, keyword);
    GetStorage().write(state.type == 0 ? Constant.keyEquipmentHistory : Constant.keyTaskHistory, state.historyList);
  }
}
