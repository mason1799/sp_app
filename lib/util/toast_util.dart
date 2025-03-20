import 'package:konesp/util/object_util.dart';
import 'package:oktoast/oktoast.dart';

class Toast {
  static void show(String? msg, {int duration = 1500}) {
    if (ObjectUtil.isEmpty(msg)) {
      return;
    }
    showToast(msg!, duration: Duration(milliseconds: duration), dismissOtherToast: true);
  }

  static void cancelToast() {
    dismissAllToast();
  }
}
