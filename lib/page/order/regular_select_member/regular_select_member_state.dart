import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/widget/error_page.dart';

class RegularSelectMemberState extends GetxController {
  final searchController = TextEditingController();
  late PageStatus pageStatus;
  List<MainResponseEntity>? items;
  late RegularMemberSelectedEntity selected;
  late List<RegularMemberSelectedEntity> selectedList;

  RegularSelectMemberState() {
    pageStatus = PageStatus.loading;
    Map _map = Get.arguments;
    String? _selectedGroupCode = _map['selectedGroupCode'];
    String? _selectedGroupName = _map['selectedGroupName'];
    int? _selectedUserId = _map['selectedUserId'];
    String? _selectedUserName = _map['selectedUserName'];
    selected = RegularMemberSelectedEntity()
      ..selectedGroupCode = _selectedGroupCode
      ..selectedGroupName = _selectedGroupName
      ..selectedUserId = _selectedUserId
      ..selectedUserName = _selectedUserName;
    selectedList = [];
  }
}

class RegularMemberSelectedEntity {
  String? selectedGroupCode;
  String? selectedGroupName;
  int? selectedUserId;
  String? selectedUserName;
}
