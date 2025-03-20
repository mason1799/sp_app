import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/project_detail_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:sprintf/sprintf.dart';

import 'project_detail_state.dart';

class ProjectDetailLogic extends BaseController {
  final ProjectDetailState state = ProjectDetailState();

  Future<void> pull() async {
    state.currentPage = 1;
    await query();
  }

  Future<void> loadMore() async {
    state.currentPage++;
    await query();
  }

  Future<void> query() async {
    final result = await post<List<ProjectDetailEntity>>(
      Api.equipmentList,
      params: {
        'projectId': state.id,
        'pageSize': 10,
        'page': state.currentPage,
      },
    );
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data!) && ObjectUtil.isNotEmpty(result.data!.first.equipmentInfoVoList)) {
        state.projectDetailEntity = result.data!.first;
        state.projectDetailEntity!.equipmentNum = result.totalPage!;
        if (state.currentPage == 1) {
          state.items.clear();
        }
        state.items.addAll(result.data!.first.equipmentInfoVoList!);
        state.hasMore = result.hasMore;
        state.pageStatus = PageStatus.success;
      } else {
        state.pageStatus = PageStatus.empty;
      }
    } else {
      state.pageStatus = PageStatus.error;
      showToast(result.msg);
    }
    update();
  }

  deleteEquipment(int id) async {
    state.items.removeWhere((element) => element.id == id);
    state.pageStatus = state.items.isNotEmpty ? PageStatus.success : PageStatus.empty;
    update();
  }

  toSearch() {
    Get.toNamed(Routes.search, arguments: {'type': 0});
  }

  toItem(int id) {
    Get.toNamed(Routes.equipmentDetail, arguments: {'id': id});
  }

  toEdit(int id) {
    Get.toNamed(Routes.equipmentEdit, arguments: {'id': id});
  }

  toDelete(int id) {
    Get.dialog(
      ConfirmDialog(
        content: '你确定要删除该设备吗?',
        onConfirm: () async {
          showProgress();
          final result = await delete(sprintf(Api.deleteEquipment, [id]));
          closeProgress();
          if (result.success) {
            deleteEquipment(id);
            showToast('删除成功');
          } else {
            showToast(result.msg);
          }
        },
      ),
    );
  }
}
