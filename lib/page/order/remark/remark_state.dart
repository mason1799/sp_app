import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/upload_file_entity.dart';

class RemarkState extends GetxController {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  late List<UploadFileEntity> imageList;
  late bool enableEdit;
  String? content;
  late int id;
  String? imagePic;
  late int type; // 保养type=0 故障type=1

  RemarkState() {
    imageList = [];
    id = Get.arguments['id'];
    enableEdit = Get.arguments['enableEdit'];
    content = Get.arguments['content'];
    imagePic = Get.arguments['imagePic'];
    type = Get.arguments['type'];
  }
}
