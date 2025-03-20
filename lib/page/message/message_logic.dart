import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/message_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/main/main_logic.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/error_page.dart';

import 'message_state.dart';

class MessageLogic extends BaseController {
  final MessageState state = MessageState();

  Future<void> pull() async {
    await query();
  }

  query() async {
    final result = await get<List<MessageEntity>>(Api.unreadCount);
    if (result.success) {
      state.items = result.data ?? [];
      state.pageStatus = state.items.isNotEmpty ? PageStatus.success : PageStatus.empty;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void setItems(List<MessageEntity> data) {
    if (data.isNotEmpty) {
      state.items = data;
      state.pageStatus = PageStatus.success;
      update();
    }
  }

  void readAll() async {
    final result = await get(Api.readAll);
    if (result.success) {
      showToast('全部已读');
      List<MessageEntity> list = await Get.find<MainLogic>().queryUnreadCount();
      setItems(list);
    } else {
      showToast(result.msg);
    }
  }

  void toItem(int type) async {
    await Get.toNamed(Routes.messageList, arguments: {'type': type});
    List<MessageEntity> list = await Get.find<MainLogic>().queryUnreadCount();
    setItems(list);
  }
}
