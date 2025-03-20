import 'package:konesp/entity/search_summary_entity.dart';
import 'package:konesp/widget/error_page.dart';

class SearchSummaryState {
  String? keyword;
  SearchSummaryEntity? searchSummaryEntity;
  late PageStatus pageStatus;

  SearchSummaryState() {
    pageStatus = PageStatus.loading;
  }
}
