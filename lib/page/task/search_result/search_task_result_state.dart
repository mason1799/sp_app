import 'package:get/get.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/widget/error_page.dart';

class SearchTaskResultState {
  List<TaskEntity>? items;
  late PageStatus pageStatus;
  late String keyword;

  SearchTaskResultState() {
    pageStatus = PageStatus.loading;
    keyword = Get.arguments['keyword'];
  }
}
