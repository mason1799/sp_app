import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchState {
  final TextEditingController inputController = TextEditingController();
  late List<String> historyList;
  late int type; // type=0 设备搜索；type=1 工单搜索
  String? keyword;

  SearchState() {
    historyList = [];
    Map _map = Get.arguments;
    type = _map['type'];
    if (_map.containsKey('keyword')) {
      keyword = _map['keyword'];
    }
  }
}
