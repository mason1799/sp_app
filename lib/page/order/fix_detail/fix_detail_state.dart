import 'dart:async';

import 'package:get/get.dart';
import 'package:konesp/entity/fix_detail_entity.dart';
import 'package:konesp/entity/order_rule_entity.dart';
import 'package:konesp/widget/drag/draggable_float_widget.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';

class FixDetailState {
  late StreamController<OperateEvent> eventStreamController;
  late int id;
  late PageStatus pageStatus;
  late bool loading;
  FixDetailEntity? orderDetail;
  FixOrderRole? role;
  FixOrderStatus? fixOrderStatus;
  List<OrderRuleEntity>? orderRules;
  int? checkOutDeviation;
  int? checkInDeviation;

  FixDetailState() {
    eventStreamController = StreamController.broadcast();
    id = Get.arguments['id'];
    loading = false;
    pageStatus = PageStatus.loading;
  }
}
