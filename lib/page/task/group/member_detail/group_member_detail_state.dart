import 'package:get/get.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/widget/error_page.dart';

class GroupMemberDetailState {
  late PageStatus pageStatus;
  late DateTime selectDate;
  GroupListRootEntity? groupListRootEntity;
  late TaskMember memberModel;
  String? groupName;

  GroupMemberDetailState() {
    memberModel = Get.arguments[0];
    groupName = Get.arguments[1];
    pageStatus = PageStatus.loading;
    selectDate = DateTime.now();
  }
}