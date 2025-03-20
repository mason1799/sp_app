import 'package:get/get.dart';
import 'package:konesp/entity/equipment_detail_entity.dart';
import 'package:konesp/entity/project_detail_entity.dart';
import 'package:konesp/widget/error_page.dart';

class ProjectDetailState {
  ProjectDetailEntity? projectDetailEntity;
  late List<EquipmentDetailEntity> items;
  late PageStatus pageStatus;
  late int currentPage;
  late bool hasMore;
  late int id;

  ProjectDetailState() {
    id = Get.arguments['id'];
    items = [];
    currentPage = 1;
    pageStatus = PageStatus.loading;
    hasMore = false;
  }
}
