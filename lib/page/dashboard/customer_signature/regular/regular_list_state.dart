import 'package:konesp/page/dashboard/customer_signature/widget/item_widget.dart';
import 'package:konesp/widget/error_page.dart';

class RegularListState {
  late PageStatus pageStatus;
  List<ProjectSection>? items;

  RegularListState() {
    pageStatus = PageStatus.loading;
  }
}
