import 'package:konesp/entity/help_center_entity.dart';
import 'package:konesp/widget/error_page.dart';

class HelpCenterState {
  List<HelpCenterEntity>? list;
  late PageStatus pageStatus;

  HelpCenterState() {
    pageStatus = PageStatus.loading;
  }
}
