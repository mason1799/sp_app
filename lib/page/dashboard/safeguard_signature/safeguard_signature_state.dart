import 'package:konesp/widget/error_page.dart';

import '../customer_signature/widget/item_widget.dart';

class SafeguardSignatureState {
  late PageStatus pageStatus;
  late List<DateTime> selectDateRange;
  late List<ProjectSection> items;
  List<bool> checkList = List.generate(10, (index) => false);

  SafeguardSignatureState() {
    pageStatus = PageStatus.loading;
    selectDateRange = [DateTime.now().subtract(const Duration(days: 7)), DateTime.now()];
    items = [];
  }
}
