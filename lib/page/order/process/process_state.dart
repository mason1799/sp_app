import 'package:get/get.dart';
import 'package:konesp/entity/fix_order_process_entity.dart';
import 'package:konesp/entity/regular_order_process_entity.dart';
import 'package:konesp/widget/error_page.dart';

class ProcessState {
  late int type; //保养type=0 故障type=1
  late int id;
  late PageStatus pageStatus;
  List<FixOrderProcessEntity>? fixRecords;
  List<RegularOrderProcessEntity>? regularRecords;

  ProcessState() {
    type = Get.arguments['type'];
    id = Get.arguments['id'];
    pageStatus = PageStatus.loading;
  }
}
