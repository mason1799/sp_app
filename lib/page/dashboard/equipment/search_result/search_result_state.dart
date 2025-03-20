import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultState {
  late List<Tab> tabs;
  List<Widget>? tabPage;
  late String keyword;
  TabController? tabController;

  SearchResultState() {
    tabs = [
      Tab(text: '综合'),
      Tab(text: '项目'),
      Tab(text: '设备'),
    ];
    keyword = Get.arguments['keyword'];
  }
}
