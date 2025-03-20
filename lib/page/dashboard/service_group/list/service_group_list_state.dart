import 'package:get/get.dart';
import 'package:konesp/entity/service_group_entity.dart';
import 'package:konesp/widget/error_page.dart';

class ServiceGroupListState {
  List<ServiceGroupEntity>? items;
  late PageStatus pageStatus;
  late String departmentId;

  ServiceGroupListState() {
    departmentId = Get.arguments['id'];
    pageStatus = PageStatus.loading;
  }
}
