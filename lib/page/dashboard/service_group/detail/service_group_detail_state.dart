import 'package:get/get.dart';
import 'package:konesp/entity/service_group_entity.dart';

class ServiceGroupDetailState {
  late ServiceGroupEntity entity;

  ServiceGroupDetailState() {
    entity = Get.arguments;
  }
}
