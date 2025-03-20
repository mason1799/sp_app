import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/help_center_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/oss_util.dart';
import 'package:konesp/widget/error_page.dart';

import 'help_center_state.dart';
import 'widget/video_screen.dart';

class HelpCenterLogic extends BaseController {
  final HelpCenterState state = HelpCenterState();

  @override
  void onReady() {
    query();
  }

  void query() async {
    final result = await get<List<HelpCenterEntity>>(
      Api.helpCenter,
      params: {'osType': 'app'},
    );
    if (result.success) {
      state.list = result.data ?? [];
      state.pageStatus = state.list!.isEmpty ? PageStatus.empty : PageStatus.success;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void toVideo(String? url) async {
    if (ObjectUtil.isEmpty(url)) {
      return;
    }
    showProgress();
    final result = await OssUtil().download(url!);
    closeProgress();
    if (result.success) {
      Get.to(() => VideoScreen(url: result.data!));
    } else {
      showToast(result.msg);
    }
  }
}
