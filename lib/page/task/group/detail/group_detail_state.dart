import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/widget/error_page.dart';

class GroupDetailState {
  var pageStatus = PageStatus.loading.obs;
  var selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var groupModel = Rxn<TaskGroup>();
  var dataList = <TaskEntity>[].obs;
  DateTime currentSelectTime = DateTime.now();
  late GroupDetailEntity entity;

  GroupDetailState() {
    entity = Get.arguments['entity'];
  }
}