import 'package:get/get.dart';
import 'package:konesp/entity/custom_field_list_entity.dart';
import 'package:konesp/widget/error_page.dart';

class ContractDetailState {
  CustomFieldListEntity? customFieldListEntity;
  late PageStatus pageStatus;
  late int id;

  ContractDetailState() {
    id = Get.arguments['id'];
    pageStatus = PageStatus.loading;
  }
}
