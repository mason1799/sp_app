import 'package:konesp/entity/message_entity.dart';
import 'package:konesp/widget/error_page.dart';

class MessageState {
  late List<MessageEntity> items;
  late PageStatus pageStatus;

  MessageState() {
    items = [];
    pageStatus = PageStatus.loading;
  }
}
