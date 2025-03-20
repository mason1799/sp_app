import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/widget/error_page.dart';

class SearchProjectState {
  String? keyword;
  late List<ProjectEntity> items;
  late PageStatus pageStatus;
  late int currentPage;
  late bool hasMore;

  SearchProjectState() {
    items = [];
    currentPage = 1;
    pageStatus = PageStatus.loading;
    hasMore = false;
  }
}
