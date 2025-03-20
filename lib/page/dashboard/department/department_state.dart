import 'package:get/get.dart';
import 'package:konesp/entity/department_node.dart';

class DepartmentState {
  DepartmentNode? selectedDepartment;

  DepartmentState() {
    selectedDepartment = Get.arguments['selectedDepartment'];
  }
}
