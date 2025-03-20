import 'dart:async';

import 'package:get/get.dart';
import 'package:konesp/entity/order_rule_entity.dart';
import 'package:konesp/entity/regular_detail_entity.dart';
import 'package:konesp/widget/drag/draggable_float_widget.dart';
import 'package:konesp/widget/error_page.dart';

class RegularDetailState extends GetxController {
  late StreamController<OperateEvent> eventStreamController;
  late int id;
  late bool loading;
  late PageStatus pageStatus;
  RegularDetailEntity? orderDetail;
  List<OrderRuleEntity>? orderRules;
  int? checkInDeviation;
  int? checkOutDeviation;
  String? startLocation;
  double? startDistance;
  String? startCoordinates;
  String? endLocation;
  double? endDistance;
  String? endCoordinates;

  RegularDetailState() {
    eventStreamController = StreamController.broadcast();
    id = Get.arguments['id'];
    loading = false;
    pageStatus = PageStatus.loading;
  }
}
