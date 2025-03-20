import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentState {
  final approveOperatorController = TextEditingController();
  final approveAdviceController = TextEditingController();
  final approveOperatorFocusNode = FocusNode();
  final approveAdviceFocusNode = FocusNode();
  int? selectedLevel;
  String? signatureKey;
  late int type;
  late List<int> ids;
  late List<String> levels;
  late bool isSubmiting;

  CommentState() {
    type = Get.arguments['type'] ?? 0;
    ids = Get.arguments['ids'];
    levels = ['非常满意', '满意', '一般', '不满意'];
    isSubmiting = false;
  }
}
