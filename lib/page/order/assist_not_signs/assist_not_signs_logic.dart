import 'package:get/get.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/routes/app_routes.dart';

import 'assist_not_signs_state.dart';

class AssistNotSignsLogic extends GetxController {
  final AssistNotSignsState state = AssistNotSignsState();

  void toSign(MainResponseMember entity) {
    Get.toNamed(Routes.signatureBoard, arguments: {
      'employeeCode': entity.employeeCode,
      'type': state.type,
      'username': entity.username,
      'phone': entity.phone,
      'id': entity.id,
      'signatureImage': state.signatureImage,
    });
  }
}
