import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/widget/error_page.dart';

import 'fix_select_member_state.dart';

class FixSelectMemberLogic extends BaseController {
  final FixSelectMemberState state = FixSelectMemberState();

  @override
  void onReady() {
    query();
  }

  query({String? search}) async {
    final result = await post<List<MainResponseEntity>>(
      Api.mainResponseList,
      params: {'username': search, 'includeMyself': state.includeMyself},
    );
    if (result.success) {
      state.items = result.data ?? [];
      state.pageStatus = state.items!.isNotEmpty ? PageStatus.success : PageStatus.empty;
      for (MainResponseEntity group in state.items!) {
        if (group.groupCode == state.selected.selectedGroupCode && -1 == state.selected.selectedUserId) {
          state.selectedList.add(state.selected);
          break;
        }
        for (MainResponseMember child in group.memberList ?? []) {
          if (child.groupCode == state.selected.selectedGroupCode && child.id == state.selected.selectedUserId) {
            state.selectedList.add(state.selected);
            break;
          }
        }
      }
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  search() {
    Get.focusScope?.unfocus();
    String _searchText = state.searchController.text;
    query(search: _searchText);
  }

  toSelect({required int userId, required String userName, required String groupCode, required String groupName}) {
    if (state.selectedList.indexWhere((item) => item.selectedUserId == userId && item.selectedGroupCode == groupCode) > -1) {
      state.selectedList.removeWhere((item) => item.selectedUserId == userId && item.selectedGroupCode == groupCode);
    } else {
      state.selectedList.clear();
      state.selectedList.add(FixMemberSelectedEntity()
        ..selectedUserId = userId
        ..selectedUserName = userName
        ..selectedGroupCode = groupCode
        ..selectedGroupName = groupName);
    }
    update();
  }

  toSubmit() async {
    if (state.selectedList.isEmpty) {
      showToast('请选择主响应人');
      return;
    }
    Get.back(result: state.selectedList.first);
  }
}
