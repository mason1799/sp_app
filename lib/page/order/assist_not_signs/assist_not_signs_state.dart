import 'package:get/get.dart';
import 'package:konesp/entity/main_response_entity.dart';

class AssistNotSignsState extends GetxController {
  late List<MainResponseMember> list;
  late String signatureImage;
  late int type;

  AssistNotSignsState() {
    list = Get.arguments['list'] ?? [];
    signatureImage = Get.arguments['signatureImage'] ?? '';
    type = Get.arguments['type'];
  }
}
