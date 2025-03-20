import 'package:get/get.dart';
import 'package:konesp/entity/over_time_entity.dart';

class OverTimeState extends GetxController {
  late int orderId;
  late OverTimeEntity entity;
  late List<OverTimeModuleInfo> selected;
  String? selectDate;

  OverTimeState() {
    orderId = Get.arguments['id'];
    entity = Get.arguments['entity'];
    selected = [];
  }
}
