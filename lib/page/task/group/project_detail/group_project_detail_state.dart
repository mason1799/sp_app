import 'package:get/get.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/widget/error_page.dart';

class GroupProjectDetailState {
  late TaskProject projectModel;
  late String groupCode;
  late PageStatus pageStatus;
  late DateTime selectDate;
  GroupListRootEntity? groupListRootEntity;

  GroupProjectDetailState() {
    projectModel = Get.arguments[0];
    groupCode = Get.arguments[1];
    pageStatus = PageStatus.loading;
    selectDate = DateTime.now();
  }
}