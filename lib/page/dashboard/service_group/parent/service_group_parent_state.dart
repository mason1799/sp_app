import 'package:konesp/entity/user_department_entity.dart';
import 'package:konesp/widget/error_page.dart';

class ServiceGroupParentState {
  List<UserDepartmentEntity>? items;
  late PageStatus pageStatus;

  ServiceGroupParentState() {
    pageStatus = PageStatus.loading;
  }
}
