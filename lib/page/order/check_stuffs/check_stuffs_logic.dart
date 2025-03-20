import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/entity/check_stuffs_entity.dart';
import 'package:konesp/entity/upload_file_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/util/kfps_util.dart';
import 'package:konesp/util/location_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/oss_util.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sprintf/sprintf.dart';

import '../regular_detail/regular_detail_logic.dart';
import 'check_stuffs_state.dart';
import 'widget/check_icon.dart';

class CheckStuffsLogic extends BaseController {
  final CheckStuffsState state = CheckStuffsState();

  @override
  void onInit() {
    super.onInit();
    state.scrollController.addListener(scrollListener);
    state.subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if ([ConnectivityResult.mobile, ConnectivityResult.wifi].contains(result)) {
        if (state.isNetworkFailed) {
          state.isNetworkFailed = false;
          update(['net']);
          quietUpload();
        }
      } else {
        if (!state.isNetworkFailed) {
          state.isNetworkFailed = true;
          update(['net']);
        }
      }
    });
  }

  @override
  void onClose() {
    state.scrollController.removeListener(scrollListener);
    state.subscription?.cancel();
    state.eventStreamController.close();
    super.onClose();
  }

  @override
  void onReady() {
    initData();
    KfpsUtil.initPageLicense();
  }

  void putInHive() async {
    if (state.editMode) {
      var params = <Map<String, dynamic>>[];
      for (var element in state.children) {
        Map<String, dynamic> _father = {};
        _father['groupName'] = element.groupName!;
        var _childList = <Map<String, dynamic>>[];
        for (var value in element.dataList) {
          List<Map<String, dynamic>> _toPictures = [];
          for (UploadFileEntity uploadFile in value.imageList) {
            if (ObjectUtil.isEmpty(uploadFile.path) && ObjectUtil.isEmpty(uploadFile.ossKey)) {
              continue;
            }
            _toPictures.add({
              'key': uploadFile.ossKey,
              'path': uploadFile.path,
            });
          }
          Map<String, dynamic> _child = {
            'checkId': value.id,
            'orderId': state.orderDetail.id,
            'conclusion': (value.status?.index ?? -1) + 1, //没填
            'selectDefault': (value.defaultStatus?.index ?? -1) + 1, //默认
            'content': value.title,
            'required': value.content,
            'picture': jsonEncode(_toPictures),
            'isMandatory': value.isMandatory,
          };
          _childList.add(_child);
        }
        _father['list'] = _childList;
        params.add(_father);
      }
      final stuffsBox = await Hive.openBox(Constant.stuffsBox);
      await stuffsBox.put('${state.orderDetail.id}', {'params': params});
    }
  }

  void scrollListener() {
    if (state.scrollController.offset > state.topHeaderHeight) {
      state.isShowHeader = true;
    } else {
      state.isShowHeader = false;
    }
    update(['show']);
  }

  void updateTopHeaderHeight() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      var box = state.topKey?.currentContext?.findRenderObject() as RenderBox?;
      state.topHeaderHeight = box?.size.height ?? 0;
      if (state.topHeaderHeight > 56) {
        state.topHeaderHeight -= 56;
      }
    });
  }

  int getListLength() {
    var length = state.children.fold(0, (previousValue, element) => previousValue + element.dataList.length + 1);
    length += 1;
    return length;
  }

  Future<void> initData() async {
    Map? _map;
    if (await Hive.boxExists(Constant.stuffsBox)) {
      final stuffsBox = await Hive.openBox(Constant.stuffsBox);
      _map = await stuffsBox.get('${state.orderDetail.id!}');
    }
    if (_map != null && state.editMode) {
      List<dynamic> _result = _map['params'];
      if (ObjectUtil.isNotEmpty(_result)) {
        int fromIndex = 1;
        state.heads = [];
        var sections = <CheckTicketSectionModel>[];
        for (Map<dynamic, dynamic> _entry in _result) {
          var group = CheckTicketGroupHeaderModel();
          group.title = _entry['groupName'];
          group.fromIndex = fromIndex;
          group.groupName = _entry['groupName'];
          state.heads.add(group);
          List<dynamic> _list = _entry['list'];
          if (ObjectUtil.isNotEmpty(_list)) {
            var subList = <CheckTicketItemUIModel>[];
            for (int subIndex = 0; subIndex < _list.length; subIndex++) {
              var subModel = _list[subIndex];
              CheckTicketItemStatus? status;
              switch (subModel['conclusion']) {
                case 1:
                  status = CheckTicketItemStatus.qualified;
                  break;
                case 2:
                  status = CheckTicketItemStatus.unqualified;
                  break;
                case 3:
                  status = CheckTicketItemStatus.fixed;
                  break;
                case 4:
                  status = CheckTicketItemStatus.notApply;
                  break;
              }
              CheckTicketItemStatus? defaultStatus = CheckTicketItemStatus.qualified;
              switch (subModel['selectDefault']) {
                case 1:
                  defaultStatus = CheckTicketItemStatus.qualified;
                  break;
                case 2:
                  defaultStatus = CheckTicketItemStatus.unqualified;
                  break;
                case 3:
                  defaultStatus = CheckTicketItemStatus.fixed;
                  break;
                case 4:
                  defaultStatus = CheckTicketItemStatus.notApply;
                  break;
              }
              List<dynamic> _pictures = jsonDecode(subModel['picture']);
              subList.add(
                CheckTicketItemUIModel(
                  title: subModel['content'],
                  content: subModel['required'],
                  groupName: _entry['groupName'],
                  index: fromIndex + subIndex + 1,
                  status: status,
                  defaultStatus: defaultStatus,
                  id: subModel['checkId'],
                  imageList: convertImageListByCache(_pictures),
                  isMandatory: subModel['isMandatory'],
                ),
              );
            }
            sections.add(
              CheckTicketSectionModel(dataList: subList, fromIndex: fromIndex, groupName: _entry['groupName']),
            );
            fromIndex += _list.length + 1;
          }
        }
        state.children.assignAll(sections);
      }
      state.pageStatus = PageStatus.success;
      update();
      //之前因为断网没上传成功的,现在判断一下有没网络，有网的话开始默默上传到oss
      final ConnectivityResult _connectivityResult = await (Connectivity().checkConnectivity());
      if ([ConnectivityResult.mobile, ConnectivityResult.wifi].contains(_connectivityResult)) {
        for (int i = 0; i < state.children.length; i++) {
          for (int j = 0; j < state.children[i].dataList.length; j++) {
            for (int z = 0; z < state.children[i].dataList[j].imageList.length; z++) {
              UploadFileEntity uploadFile = state.children[i].dataList[j].imageList[z];
              if (ObjectUtil.isNotEmpty(uploadFile.path) && ObjectUtil.isEmpty(uploadFile.ossKey)) {
                final uploadResult = await OssUtil.instance.upload(
                  uploadFile.path!,
                  timeTag: TimeTagFormat.checkStuffs,
                  dict: 'detail',
                  isDecorateMark: true,
                );
                if (uploadResult.success) {
                  state.children[i].dataList[j].imageList[z] = uploadResult.data!;
                  update(['imageList']);
                }
              }
            }
          }
        }
      } else {
        state.isNetworkFailed = true;
        update(['net']);
      }
    } else {
      //没有缓存和满足相关的条件则请求服务器端拉取数据
      final result = await get<List<CheckStuffsEntity>>(sprintf(Api.checkStuffsDetail, [state.orderDetail.id!]));
      if (result.success) {
        if (ObjectUtil.isNotEmpty(result.data)) {
          int fromIndex = 1;
          state.heads = [];
          var sections = <CheckTicketSectionModel>[];
          for (int i = 0; i < result.data!.length; i++) {
            var element = result.data![i];
            var group = CheckTicketGroupHeaderModel();
            group.title = element.groupName;
            group.fromIndex = fromIndex;
            group.groupName = element.groupName;
            state.heads.add(group);
            if (element.list?.isNotEmpty == true) {
              var subList = <CheckTicketItemUIModel>[];
              for (int subIndex = 0; subIndex < element.list!.length; subIndex++) {
                var subModel = element.list![subIndex];
                CheckTicketItemStatus? status;
                switch (subModel.conclusion) {
                  case 1:
                    status = CheckTicketItemStatus.qualified;
                    break;
                  case 2:
                    status = CheckTicketItemStatus.unqualified;
                    break;
                  case 3:
                    status = CheckTicketItemStatus.fixed;
                    break;
                  case 4:
                    status = CheckTicketItemStatus.notApply;
                    break;
                }
                CheckTicketItemStatus? defaultStatus = CheckTicketItemStatus.qualified;
                switch (subModel.selectDefault) {
                  case 1:
                    defaultStatus = CheckTicketItemStatus.qualified;
                    break;
                  case 2:
                    defaultStatus = CheckTicketItemStatus.unqualified;
                    break;
                  case 3:
                    defaultStatus = CheckTicketItemStatus.fixed;
                    break;
                  case 4:
                    defaultStatus = CheckTicketItemStatus.notApply;
                    break;
                }
                subList.add(
                  CheckTicketItemUIModel(
                    title: subModel.content,
                    content: subModel.required,
                    groupName: element.groupName,
                    index: fromIndex + subIndex + 1,
                    status: status,
                    defaultStatus: defaultStatus,
                    id: subModel.checkId,
                    imageList: convertImageList(subModel.picture),
                    isMandatory: subModel.isMandatory,
                  ),
                );
              }
              sections.add(
                CheckTicketSectionModel(dataList: subList, fromIndex: fromIndex, groupName: element.groupName),
              );
              fromIndex += (element.list!.length + 1);
            }
          }
          state.children.assignAll(sections);
        }
        state.pageStatus = PageStatus.success;
        update();
        quietUpload();
        putInHive();
      } else {
        showToast(result.msg);
        state.pageStatus = PageStatus.error;
        update();
      }
    }
    if (state.editMode) {
      LocationUtil().startLocation(
        onResult: (entity) {},
      );
    }
  }

  List<UploadFileEntity> convertImageList(String? picture) {
    List<UploadFileEntity> imageList = [];
    if (ObjectUtil.isNotEmpty(picture)) {
      List<String> list = picture!.split(',');
      for (int i = 0; i < list.length; i++) {
        imageList.add(UploadFileEntity()..ossKey = list[i]);
      }
    }
    return imageList;
  }

  List<UploadFileEntity> convertImageListByCache(List<dynamic> list) {
    List<UploadFileEntity> imageList = [];
    if (ObjectUtil.isNotEmpty(list)) {
      for (Map<String, dynamic> _map in list) {
        imageList.add(UploadFileEntity()
          ..ossKey = _map['key']
          ..path = _map['path']);
      }
    }
    return imageList;
  }

  void selectHeader(CheckTicketGroupHeaderModel groupHeaderModel) {
    state.selectGroup = groupHeaderModel.groupName ?? '';
    state.ignoreScroll = true;
    state.scrollController.scrollToIndex(groupHeaderModel.fromIndex ?? 1, preferPosition: AutoScrollPosition.begin).then((value) {
      state.ignoreScroll = false;
    });
    update(['group']);
  }

  void batchConfirm() {
    for (var element in state.children) {
      for (var value in element.dataList) {
        if (value.status == null) {
          if (value.defaultStatus != null) {
            value.status = value.defaultStatus!;
          }
        }
      }
    }
    update();
    putInHive();
  }

  void toCommit() async {
    var params = <Map<String, dynamic>>[];
    for (var element in state.children) {
      for (var value in element.dataList) {
        if (value.status == null) {
          await state.scrollController.scrollToIndex(value.index, preferPosition: AutoScrollPosition.middle, duration: Duration(milliseconds: 100));
          state.errorIndex.value = value.index;
          state.errorText.value = '请完成检查项';
          Future.delayed(const Duration(milliseconds: 1500), () => state.errorIndex.value = -1);
          return;
        }
        if (ObjectUtil.isEmpty(value.imageList) && value.isMandatory == true) {
          await state.scrollController.scrollToIndex(value.index, preferPosition: AutoScrollPosition.middle, duration: Duration(milliseconds: 100));
          state.errorIndex.value = value.index;
          state.errorText.value = '请上传图片';
          Future.delayed(const Duration(milliseconds: 1500), () => state.errorIndex.value = -1);
          return;
        }
        if (value.imageList.indexWhere((element) => (ObjectUtil.isEmpty(element.ossKey) && ObjectUtil.isNotEmpty(element.path))) > -1) {
          await state.scrollController.scrollToIndex(value.index, preferPosition: AutoScrollPosition.middle, duration: Duration(milliseconds: 100));
          state.errorIndex.value = value.index;
          state.errorText.value = '请等待图片上传';
          Future.delayed(const Duration(milliseconds: 1500), () => state.errorIndex.value = -1);
          return;
        }
        params.add({
          'checkId': value.id,
          'orderId': state.orderDetail.id,
          'conclusion': (value.status?.index ?? 0) + 1,
          'picture': value.imageList.map((e) => e.ossKey).toList().join(','),
        });
      }
    }
    showProgress();
    final result = await post(Api.submitCheckStuffs, params: params);
    closeProgress();
    if (result.success) {
      putInHive();
      Get.back();
      if (Get.isRegistered<RegularDetailLogic>()) {
        Get.find<RegularDetailLogic>().query();
      }
    } else {
      showToast(result.msg);
    }
  }

  void visibilitySection(int index) {
    if (state.ignoreScroll) return;
    List<int> indexList = [];
    for (var element in state.children) {
      indexList.add(element.fromIndex);
    }
    for (int i = 0; i < indexList.length; i++) {
      if (index == indexList[i]) {
        state.selectGroup = state.children[i].groupName ?? '';
        break;
      } else if (index < indexList[i]) {
        state.selectGroup = state.children[i].groupName ?? '';
        break;
      }
    }
    update(['group']);
  }

  void checkRadio(CheckTicketItemUIModel itemUIModel) async {
    if (!state.editMode) {
      return;
    }
    Get.bottomSheet(
      _CheckBottomSheet(
        uiModel: itemUIModel,
        onResult: (current) {
          itemUIModel.status = current;
          update(['radio']);
          putInHive();
        },
      ),
    );
  }

  void onAddImages(List<String> newItems, CheckTicketItemUIModel itemUIModel) async {
    var list = newItems.map((item) => UploadFileEntity()..path = item).toList();
    itemUIModel.imageList.addAll(list);
    update(['imageList']);
    final ConnectivityResult _connectivityResult = await (Connectivity().checkConnectivity());
    if ([ConnectivityResult.mobile, ConnectivityResult.wifi].contains(_connectivityResult)) {
      for (int i = 0; i < itemUIModel.imageList.length; i++) {
        UploadFileEntity uploadFile = itemUIModel.imageList[i];
        if (ObjectUtil.isEmpty(uploadFile.ossKey) && ObjectUtil.isNotEmpty(uploadFile.path)) {
          final uploadResult = await OssUtil.instance.upload(
            uploadFile.path!,
            timeTag: TimeTagFormat.checkStuffs,
            dict: 'detail',
            isDecorateMark: true,
          );
          if (uploadResult.success) {
            itemUIModel.imageList[i] = uploadResult.data!;
            update(['imageList']);
          }
        }
      }
    }
    putInHive();
  }

  void onDeleteImages(List<UploadFileEntity> newItems, CheckTicketItemUIModel itemUIModel) {
    itemUIModel.imageList = newItems;
    update(['imageList']);
    putInHive();
  }

  void quietUpload() async {
    for (int i = 0; i < state.children.length; i++) {
      for (int j = 0; j < state.children[i].dataList.length; j++) {
        for (int z = 0; z < state.children[i].dataList[j].imageList.length; z++) {
          UploadFileEntity uploadFile = state.children[i].dataList[j].imageList[z];
          if (ObjectUtil.isEmpty(uploadFile.ossKey) && ObjectUtil.isNotEmpty(uploadFile.path)) {
            final uploadResult = await OssUtil.instance.upload(
              uploadFile.path!,
              timeTag: TimeTagFormat.checkStuffs,
              dict: 'detail',
              isDecorateMark: true,
            );
            if (uploadResult.success) {
              state.children[i].dataList[j].imageList[z] = uploadResult.data!;
              update(['imageList']);
            }
          }
        }
      }
    }
  }

  void toKfps() {
    KfpsUtil.jumpPage(
      orderNumber: state.orderDetail.orderNumber!,
      equipmentCode: state.orderDetail.equipmentCode!,
      projectName: state.orderDetail.projectName,
    );
  }
}

class _CheckBottomSheet extends StatefulWidget {
  const _CheckBottomSheet({
    Key? key,
    required this.uiModel,
    required this.onResult,
  }) : super(key: key);
  final CheckTicketItemUIModel uiModel;
  final Function(CheckTicketItemStatus current) onResult;

  @override
  State<_CheckBottomSheet> createState() => _CheckBottomSheetState();
}

class _CheckBottomSheetState extends State<_CheckBottomSheet> {
  CheckTicketItemStatus? selected;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    selected = widget.uiModel.status;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8.w),
            ),
          ),
          padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.w, bottom: 14.w),
                child: Text(
                  '检查项详情',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colours.text_333,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.uiModel.title ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_333,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.uiModel.content ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colours.text_333,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CheckIcon(
                    selected: selected == CheckTicketItemStatus.qualified,
                    selectImageAsset: 'ticket_detail_select_qualified',
                    unselectImageAsset: 'ticket_detail_unselect_qualified',
                    title: '合格',
                    onTap: () {
                      setState(() {
                        selected = CheckTicketItemStatus.qualified;
                      });
                    },
                  ),
                  CheckIcon(
                    selected: selected == CheckTicketItemStatus.unqualified,
                    selectImageAsset: 'ticket_detail_select_unqualified',
                    unselectImageAsset: 'ticket_detail_unselect_unqualified',
                    title: '不合格',
                    onTap: () {
                      setState(() {
                        selected = CheckTicketItemStatus.unqualified;
                      });
                    },
                  ),
                  CheckIcon(
                    selected: selected == CheckTicketItemStatus.fixed,
                    selectImageAsset: 'ticket_detail_select_fix',
                    unselectImageAsset: 'ticket_detail_unselect_fix',
                    title: '已修复',
                    onTap: () {
                      setState(() {
                        selected = CheckTicketItemStatus.fixed;
                      });
                    },
                  ),
                  CheckIcon(
                    selected: selected == CheckTicketItemStatus.notApply,
                    selectImageAsset: 'ticket_detail_select_not_apply',
                    unselectImageAsset: 'ticket_detail_unselect_not_apply',
                    title: '不适用',
                    onTap: () {
                      setState(() {
                        selected = CheckTicketItemStatus.notApply;
                      });
                    },
                  ),
                ],
              ),
              TextBtn(
                backgroundColor: Colors.transparent,
                onPressed: () {
                  if (selected != null) {
                    widget.onResult(selected!);
                  }
                  Get.back();
                },
                text: '确认',
                size: Size(double.infinity, 44.w),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colours.text_333,
                ),
              ),
              divider,
              TextBtn(
                backgroundColor: Colors.transparent,
                onPressed: Get.back,
                text: '取消',
                size: Size(double.infinity, 44.w),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colours.text_333,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
