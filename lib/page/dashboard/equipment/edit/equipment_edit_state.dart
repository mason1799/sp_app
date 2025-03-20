import 'package:get/get.dart';
import 'package:konesp/widget/error_page.dart';

class EquipmentEditState {
  late int id;
  Map<String, dynamic>? detailEntity;
  late PageStatus pageStatus;

  EquipmentEditState() {
    id = Get.arguments['id'];
    pageStatus = PageStatus.loading;
  }
}
