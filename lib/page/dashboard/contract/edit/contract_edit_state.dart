import 'package:get/get.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/widget/error_page.dart';

class ContractEditState {
  late int id;
  CustomFieldListEntity? customFieldListEntity;
  late PageStatus pageStatus;

  ContractEditState() {
    id = Get.arguments['id'];
    pageStatus = PageStatus.loading;
  }
}
