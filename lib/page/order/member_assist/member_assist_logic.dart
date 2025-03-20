import 'package:konesp/config/api.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/order/member_assist/member_assist_state.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';

class MemberAssistLogic extends BaseController {
  final MemberAssistState state = MemberAssistState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await post<List<MainResponseEntity>>(Api.mainResponseList, params: {});
    if (result.success) {
      List<MainResponseEntity>? members = result.data;
      if (state.removeUserId != null) {
        members?.map((e) {
          e.memberList?.removeWhere((element) => element.id == state.removeUserId);
        }).toList();
      }

      List<MainResponseEntity>? other = [];
      if (members != null) {
        //给组员赋值所在组code和name
        for (var v in members) {
          if (v.memberList != null) {
            for (var element in v.memberList!) {
              element.groupName = v.groupName;
              element.groupCode = v.groupCode;
            }
          }
        }

        MainResponseEntity? entity;
        if (state.groupCode.value != '') {
          for (var element in members) {
            if (element.groupCode == state.groupCode.value) {
              entity = element;
            } else {
              other.add(element);
            }
          }
        } else {
          other.addAll(members);
        }
        if (entity != null) {
          state.groupList.clear();
          state.groupList.add(entity);
          state.currentMembers.clear();
          state.currentMembers.add(entity);
        }

        if (members.length <= 1) {
          state.showMore.value = false;
        }
        state.pageStatus.value = PageStatus.success;
      } else {
        state.pageStatus.value = PageStatus.empty;
      }
      state.otherGroupList.addAll(other);
      state.groupList.refresh();
      state.otherGroupList.refresh();
      state.allMembers.addAll(state.currentMembers);
      state.allMembers.addAll(state.otherGroupList);
    } else {
      showToast(result.msg);
      state.pageStatus.value = PageStatus.error;
    }
  }

  filterData() {
    String _search = state.searchController.text;
    if (ObjectUtil.isEmpty(_search)) {
      state.groupList.value = state.showMore.value ? [...state.currentMembers] : [...state.allMembers];
      state.groupList.refresh();
      return;
    }
    List<MainResponseEntity> list = getNewList();
    List<MainResponseEntity> tempList = [];
    for (var element in list) {
      if (ObjectUtil.isNotEmpty(_search) && element.memberList != null) {
        List<MainResponseMember>? memberList = [];
        for (var e in element.memberList!) {
          if ((e.username != null && e.username!.contains(_search)) || (e.phone != null && e.phone!.contains(_search))) {
            memberList.add(e);
          }
        }
        if (memberList.isNotEmpty) {
          element.memberList = memberList;
          tempList.add(element);
        }
      }
    }
    state.groupList.value = [...tempList];
  }

  setAllData() {
    state.groupList.clear();
    state.groupList.addAll(state.allMembers);
    state.groupList.refresh();
  }

  getNewList() {
    List<MainResponseEntity> list = [];
    MainResponseEntity entity;
    for (var element in state.groupList) {
      entity = MainResponseEntity();
      entity.groupName = element.groupName;
      entity.groupCode = element.groupCode;
      entity.id = element.id;
      List<MainResponseMember>? memberList = [];
      memberList.addAll(element.memberList ?? []);
      entity.memberList = memberList;
      list.add(entity);
    }
    return list;
  }

  bool isSelect(MainResponseMember e) {
    bool flag = false;
    if (state.currentSelects.isNotEmpty) {
      for (var element in state.currentSelects) {
        if (element.employeeCode == e.employeeCode) {
          flag = true;
        }
      }
    }
    return flag;
  }

  bool isDeviceBelong(MainResponseEntity? entity) {
    bool flag = false;
    if (entity != null && entity.groupCode != null) {
      return entity.groupCode == state.groupCode.value;
    }
    return flag;
  }

  operateSelectData(MainResponseMember? entity) {
    if (entity != null && state.currentSelects.isNotEmpty) {
      MainResponseMember? temp;
      for (var element in state.currentSelects) {
        if (element.employeeCode == entity.employeeCode) {
          temp = element;
          state.currentSelects.remove(element);
          break;
        }
      }
      if (temp == null) {
        state.currentSelects.add(entity);
      }
    } else {
      state.currentSelects.add(entity!);
    }

    state.currentSelects.refresh();
  }

  void showMore() {
    if (state.otherGroupList.isNotEmpty) {
      state.showMore.value = false;
      setAllData();
    } else {
      showToast('其他维保组成员为空');
    }
  }
}
