import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/regular_detail_entity.dart';
import 'package:konesp/entity/upload_file_entity.dart';
import 'package:konesp/widget/drag/draggable_float_widget.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CheckStuffsState {
  final scrollController = AutoScrollController(viewportBoundaryGetter: () => const Rect.fromLTRB(0, 0, 0, 0), axis: Axis.vertical);
  late List<CheckTicketSectionModel> children;
  late PageStatus pageStatus;
  late String selectGroup;
  late List<CheckTicketGroupHeaderModel> heads;
  late bool isShowHeader;
  late RegularDetailEntity orderDetail;
  late bool editMode;
  StreamSubscription<ConnectivityResult>? subscription;
  late bool isNetworkFailed;
  late bool ignoreScroll;
  GlobalKey? topKey;
  late double topHeaderHeight;
  var errorIndex = RxInt(-1);
  var errorText = RxnString();
  late StreamController<OperateEvent> eventStreamController;

  CheckStuffsState() {
    orderDetail = Get.arguments['entity'];
    editMode = Get.arguments['editMode'];
    isNetworkFailed = false;
    ignoreScroll = false;
    topHeaderHeight = 0;
    isShowHeader = false;
    children = [];
    pageStatus = PageStatus.success;
    selectGroup = '';
    heads = [];
    eventStreamController = StreamController.broadcast();
  }
}

class CheckTicketItemUIModel {
  String? title;
  String? content;
  CheckTicketItemStatus? status;
  String? groupName;
  int? id;
  CheckTicketItemStatus? defaultStatus;
  int index;
  List<UploadFileEntity> imageList = [];
  bool? isMandatory;

  CheckTicketItemUIModel({
    this.title,
    this.content,
    this.status,
    this.groupName,
    this.id,
    this.defaultStatus,
    required this.index,
    required this.imageList,
    this.isMandatory,
  });
}

class CheckTicketGroupHeaderModel {
  String? groupName;
  String? title;
  int? fromIndex;
}

class CheckTicketSectionModel {
  List<CheckTicketItemUIModel> dataList;
  String? groupName;
  int fromIndex;

  CheckTicketSectionModel({required this.dataList, this.groupName, required this.fromIndex});
}
