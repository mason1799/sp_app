import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/widget/error_page.dart';

class MemberAssistState extends GetxController {
  var searchController = TextEditingController();
  var pageStatus = PageStatus.loading.obs;
  var showMore = true.obs;

  var groupList = <MainResponseEntity>[].obs;
  var otherGroupList = <MainResponseEntity>[].obs;

  //记录当前组
  var currentMembers = <MainResponseEntity>[].obs;

  //记录所有组
  var allMembers = <MainResponseEntity>[].obs;

  //单选
  var groupCode = ''.obs;

  //多选
  var currentSelects = <MainResponseMember>[].obs;

  int? removeUserId;

  MemberAssistState() {
    currentSelects.value = Get.arguments['members'] ?? [];
    groupCode.value = Get.arguments['groupCode'] ?? '';
    removeUserId = Get.arguments['removeUserId'] ?? 0;
  }
}
