import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/widget/error_page.dart';

import 'regular_select_member_state.dart';

class RegularSelectMemberLogic extends BaseController {
  final RegularSelectMemberState state = RegularSelectMemberState();

  @override
  void onReady() {
    query();
  }

  query({String? search}) async {
    final result = await post<List<MainResponseEntity>>(
      Api.mainResponseList,
      params: {'username': search, 'includeMyself': false},
    );
    if (result.success) {
      state.items = result.data ?? [];
      state.pageStatus = state.items!.isNotEmpty ? PageStatus.success : PageStatus.empty;
      for (MainResponseEntity group in state.items!) {
        for (MainResponseMember child in group.memberList ?? []) {
          if (child.id == state.selected.selectedUserId) {
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
    if (state.selectedList.indexWhere((item) => item.selectedUserId == userId) > -1) {
      state.selectedList.removeWhere((item) => item.selectedUserId == userId);
    } else {
      state.selectedList.clear();
      state.selectedList.add(
        RegularMemberSelectedEntity()
          ..selectedUserId = userId
          ..selectedUserName = userName
          ..selectedGroupName = groupName
          ..selectedGroupCode = groupCode,
      );
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
