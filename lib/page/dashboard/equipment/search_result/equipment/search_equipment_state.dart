import 'package:konesp/entity/equipment_detail_entity.dart';
import 'package:konesp/entity/project_detail_entity.dart';
import 'package:konesp/widget/error_page.dart';

class SearchEquipmentState {
  String? keyword;
  ProjectDetailEntity? projectDetailEntity;
  late List<EquipmentDetailEntity> items;
  late PageStatus pageStatus;
  late int currentPage;
  late bool hasMore;

  SearchEquipmentState() {
    items = [];
    currentPage = 1;
    pageStatus = PageStatus.loading;
    hasMore = false;
  }
}
