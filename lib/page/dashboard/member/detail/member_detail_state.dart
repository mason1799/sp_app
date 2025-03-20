import 'package:get/get.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/widget/error_page.dart';

class MemberDetailState {
  late int id;
  CustomFieldListEntity? customFieldListEntity;
  late List<DepartmentNode> departments;
  late PageStatus pageStatus;

  MemberDetailState() {
    id = Get.arguments['id'];
    pageStatus = PageStatus.loading;
    departments = [];
  }
}
