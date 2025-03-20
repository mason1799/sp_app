import 'dart:async';

import 'package:get/get.dart';
import 'package:konesp/entity/equipment_detail_entity.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EquipmentDetailState {
  late int id;
  EquipmentDetailEntity? detailEntity;
  late PageStatus pageStatus;
  WebSocketChannel? channel;
  Timer? timer;

  EquipmentDetailState() {
    id = Get.arguments['id'];
    pageStatus = PageStatus.loading;
  }
}
