import 'package:get/get.dart';
import 'package:konesp/entity/message_list_entity.dart';
import 'package:konesp/widget/error_page.dart';

class MessageListState {
  late int type;
  late List<MessageListEntity> items;
  late PageStatus pageStatus;
  late int currentPage;
  late bool hasMore;

  MessageListState() {
    type = Get.arguments['type'];
    items = [];
    pageStatus = PageStatus.loading;
    currentPage = 1;
    hasMore = false;
  }
}
