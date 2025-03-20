import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/widget/error_page.dart';

class FixTaskState {
  late double previousScrollPosition;
  List<TaskEntity>? items;
  late PageStatus pageStatus;

  FixTaskState() {
    previousScrollPosition = 0;
    pageStatus = PageStatus.loading;
  }
}
