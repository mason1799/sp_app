import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';

class GroupListState {
  late PageStatus pageStatus;
  late WordOrderFixButtonStatus selectFixStatus;
  late List<TaskEntity> dataList;
  TaskGroup? groupModel;
  late List<GroupDetailEntity> items;
  late String belongGroupName;

  GroupListState() {
    selectFixStatus = WordOrderFixButtonStatus.belong;
    dataList = [];
    pageStatus = PageStatus.loading;
    belongGroupName = '';
    items = [];
  }
}
