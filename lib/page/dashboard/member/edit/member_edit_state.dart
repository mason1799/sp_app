import 'package:get/get.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/widget/error_page.dart';

class MemberEditState {
  late int id;
  late PageStatus pageStatus;
  late List<DepartmentNode> departmentNodes;
  CustomFieldListEntity? customFieldListEntity;

  MemberEditState() {
    id = Get.arguments['id'];
    pageStatus = PageStatus.loading;
    departmentNodes = [];
  }
}
