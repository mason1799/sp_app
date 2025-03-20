import 'package:flutter/material.dart';
import 'package:konesp/entity/contract_entity.dart';
import 'package:konesp/widget/error_page.dart';

class ContractListState {
  late List<ContractEntity> items;
  late PageStatus pageStatus;
  late int currentPage;
  final searchController = TextEditingController();
  late bool hasMore;

  ContractListState() {
    items = [];
    pageStatus = PageStatus.loading;
    currentPage = 1;
    hasMore = false;
  }
}
