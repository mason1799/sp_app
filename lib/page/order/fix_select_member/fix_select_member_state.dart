import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/widget/error_page.dart';

class FixSelectMemberState extends GetxController {
  final searchController = TextEditingController();
  late PageStatus pageStatus;
  List<MainResponseEntity>? items;
  late FixMemberSelectedEntity selected;
  late List<FixMemberSelectedEntity> selectedList;
  late bool includeMyself;

  FixSelectMemberState() {
    pageStatus = PageStatus.loading;
    Map _map = Get.arguments;
    String? _selectedGroupCode = _map['selectedGroupCode'];
    String? _selectedGroupName = _map['selectedGroupName'];
    int? _selectedUserId = _map['selectedUserId'];
    String? _selectedUserName = _map['selectedUserName'];
    if (_map.containsKey('includeMyself')) {
      includeMyself = _map['includeMyself'];
    } else {
      includeMyself = false;
    }
    selected = FixMemberSelectedEntity()
      ..selectedGroupCode = _selectedGroupCode
      ..selectedGroupName = _selectedGroupName
      ..selectedUserId = _selectedUserId
      ..selectedUserName = _selectedUserName;
    selectedList = [];
  }
}

class FixMemberSelectedEntity {
  String? selectedGroupCode;
  String? selectedGroupName;
  int? selectedUserId;
  String? selectedUserName;
}
