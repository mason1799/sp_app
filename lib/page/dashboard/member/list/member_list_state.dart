import 'package:flutter/material.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/entity/member_data_entity.dart';
import 'package:konesp/widget/error_page.dart';

class MemberListState {
  final searchController = TextEditingController();
  late List<MemberDataEntity> items;
  late PageStatus pageStatus;
  String? selectDepartmentLabel;
  DepartmentNode? rootDepartmentNode;
  DepartmentNode? selectDepartment;
  late int currentPage;
  late bool hasMore;

  MemberListState() {
    items = [];
    pageStatus = PageStatus.loading;
    currentPage = 1;
    hasMore = false;
  }
}