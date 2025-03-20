import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/drag/draggable_float_widget.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/gradient_btn.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/nine_grid.dart';
import 'package:konesp/widget/outlined_btn.dart';
import 'package:konesp/widget/scroll_visibility_index.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'check_stuffs_logic.dart';
import 'check_stuffs_state.dart';

// 检查项清单
class CheckStuffsPage extends StatelessWidget {
  final logic = Get.find<CheckStuffsLogic>();
  final state = Get.find<CheckStuffsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '检查项清单'),
      body: GetBuilder<CheckStuffsLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return Stack(
            children: [
              Column(
                children: [
                  GetBuilder<CheckStuffsLogic>(
                    id: 'net',
                    builder: (_) {
                      if (state.isNetworkFailed && state.editMode) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '您现在网络不稳定，图片已经先保存在手机里了。等网络好了之后，图片会自动上传。',
                            style: TextStyle(
                              color: Colours.text_999,
                              fontSize: 12.sp,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        ScrollVisibilityIndexWidget(
                          callback: (first) {
                            logic.visibilitySection(first);
                          },
                          scrollStart: () {
                            state.eventStreamController.add(OperateEvent.OPERATE_HIDE);
                          },
                          scrollEnd: () {
                            state.eventStreamController.add(OperateEvent.OPERATE_SHOW);
                          },
                          child: ListView.builder(
                            controller: state.scrollController,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                var key = GlobalKey();
                                state.topKey = key;
                                logic.updateTopHeaderHeight();
                                return AutoScrollTag(
                                  key: key,
                                  controller: state.scrollController,
                                  index: index,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 14.w, bottom: 14.w, left: 16.w),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '项目详情：',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colours.text_666,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${state.orderDetail.projectName ?? ''} ${state.orderDetail.buildingCode ?? ''}${state.orderDetail.elevatorCode ?? ''}",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colours.text_333,
                                                  ),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 0.5.w, indent: 12.w),
                                      Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 14.w, bottom: 14.w, left: 16.w),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '设备详情：',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colours.text_666,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${state.orderDetail.equipmentTypeName ?? ''} ${state.orderDetail.equipmentCode ?? ''}",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colours.text_333,
                                                  ),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 16.w),
                                        width: double.infinity,
                                        color: Colours.bg,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: GetBuilder<CheckStuffsLogic>(
                                              id: 'group',
                                              builder: (logic) {
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: state.heads.map<Widget>((e) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(right: 10.w, top: 12.w, bottom: 12.w),
                                                      child: GradientBtn(
                                                        onPressed: () => logic.selectHeader(e),
                                                        select: state.selectGroup == e.groupName,
                                                        height: 32.w,
                                                        borderRadius: BorderRadius.circular(16.w),
                                                        child: Text(
                                                          e.title ?? '',
                                                          style: state.selectGroup == e.groupName
                                                              ? TextStyle(
                                                                  fontSize: 14.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Colors.white,
                                                                )
                                                              : TextStyle(
                                                                  fontSize: 14.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Colours.text_333,
                                                                ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (index == logic.getListLength()) {
                                return SizedBox();
                              }
                              List<int> indexList = [];
                              for (var element in state.children) {
                                indexList.add(element.fromIndex);
                              }
                              CheckTicketSectionModel? sectionModel;
                              CheckTicketItemUIModel? itemUIModel;

                              for (int i = 0; i < indexList.length; i++) {
                                if (index == indexList[i]) {
                                  /// 组头 header
                                  sectionModel = state.children[i];
                                  break;
                                } else if (index < indexList[i]) {
                                  itemUIModel = state.children[i - 1].dataList[index - indexList[i - 1] - 1];
                                  break;
                                }
                              }
                              if (index > indexList.last) {
                                itemUIModel = state.children.last.dataList[index - indexList.last - 1];
                              }
                              if (sectionModel != null) {
                                return AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: state.scrollController,
                                  index: index,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 16.w, top: 5.w, bottom: 5.w),
                                    child: Text(
                                      sectionModel.groupName ?? '',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colours.text_666,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (itemUIModel != null) {
                                return AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: state.scrollController,
                                  index: index,
                                  child: Obx(() {
                                    return AnimatedContainer(
                                      margin: EdgeInsets.only(top: 5.w, bottom: 5.w),
                                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.fastOutSlowIn,
                                      decoration: BoxDecoration(
                                        color: state.errorIndex.value == index ? Color(0xFFFFCCCC).withOpacity(0.5) : Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        itemUIModel?.title ?? '',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colours.text_333,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.w),
                                                      Text(
                                                        itemUIModel?.content ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colours.text_333,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GetBuilder<CheckStuffsLogic>(
                                                    id: 'radio',
                                                    builder: (logic) {
                                                      return InkWell(
                                                        onTap: () => logic.checkRadio(itemUIModel!),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 20.w),
                                                          child: LoadSvgImage(
                                                            getIcon(itemUIModel!),
                                                            width: 24,
                                                            height: 24,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.w, bottom: 11.w),
                                                child: GetBuilder<CheckStuffsLogic>(
                                                    id: 'imageList',
                                                    builder: (logic) {
                                                      return RichText(
                                                        text: TextSpan(
                                                          text: '上传图片',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: Colours.text_333,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: '(${itemUIModel!.imageList.length}/3)',
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Colours.text_333,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Stack(
                                                  children: [
                                                    !state.editMode && ObjectUtil.isEmpty(itemUIModel?.imageList)
                                                        ? Text(
                                                            '无',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Colours.text_333,
                                                            ),
                                                          )
                                                        : GetBuilder<CheckStuffsLogic>(
                                                            id: 'imageList',
                                                            builder: (_) {
                                                              return NineGrid(
                                                                itemUIModel!.imageList,
                                                                enableEdit: logic.state.editMode,
                                                                onAdd: (newItems) => logic.onAddImages(newItems, itemUIModel!),
                                                                onDelete: (newItems) => logic.onDeleteImages(newItems, itemUIModel!),
                                                              );
                                                            },
                                                          ),
                                                    if (state.errorIndex.value == index && state.editMode)
                                                      Positioned(
                                                        right: 0,
                                                        bottom: 0,
                                                        child: AnimatedOpacity(
                                                          curve: Curves.fastOutSlowIn,
                                                          opacity: state.errorIndex.value == index ? 1 : 0,
                                                          duration: Duration(seconds: 1),
                                                          child: Text(
                                                            state.errorText.value ?? '请上传图片',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              }
                              return SizedBox.shrink();
                            },
                            itemCount: logic.getListLength() + 1,
                          ),
                        ),
                        GetBuilder<CheckStuffsLogic>(
                          id: 'show',
                          builder: (logic) {
                            return state.isShowHeader
                                ? Container(
                                    padding: EdgeInsets.only(left: 16.w),
                                    width: 1.sw,
                                    color: Colours.bg,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: GetBuilder<CheckStuffsLogic>(
                                          id: 'group',
                                          builder: (logic) {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: state.heads.map<Widget>((e) {
                                                return Padding(
                                                  padding: EdgeInsets.only(right: 10.w, top: 12.w, bottom: 12.w),
                                                  child: GradientBtn(
                                                    onPressed: () => logic.selectHeader(e),
                                                    select: state.selectGroup == e.groupName,
                                                    height: 32.w,
                                                    borderRadius: BorderRadius.circular(16.w),
                                                    child: Text(
                                                      e.title ?? '',
                                                      style: state.selectGroup == e.groupName
                                                          ? TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.white,
                                                            )
                                                          : TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colours.text_333,
                                                            ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }),
                                    ),
                                  )
                                : SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  if (state.editMode)
                    Container(
                      padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 12.w, bottom: 12.w + ScreenUtil().bottomBarHeight),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedBtn(
                              onPressed: logic.batchConfirm,
                              text: '批量确认',
                              borderWidth: 1.w,
                              borderColor: Colours.primary,
                              backgroundColor: Colors.transparent,
                              size: Size(double.infinity, 44.w),
                              radius: 7.w,
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colours.primary,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextBtn(
                              onPressed: logic.toCommit,
                              text: '提交',
                              backgroundColor: Colours.primary,
                              size: Size(double.infinity, 44.w),
                              radius: 7.w,
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (state.orderDetail.isKceEquipment == true)
                DraggableFloatWidget(
                  width: 60.w,
                  height: 60.w,
                  child: LoadAssetImage(
                    'kfps_entrance',
                    width: 60.w,
                  ),
                  eventStreamController: state.eventStreamController,
                  config: DraggableFloatWidgetBaseConfig(
                    isFullScreen: false,
                    initPositionXInLeft: false,
                    initPositionYInTop: false,
                    initPositionYMarginBorder: 120.w,
                    borderRight: 10.w,
                    borderLeft: 10.w,
                    exposedPartWidthWhenHidden: 15.w,
                  ),
                  onTap: logic.toKfps,
                ),
            ],
          );
        } else if (state.pageStatus == PageStatus.error) {
          return ErrorPage();
        } else {
          return EmptyPage();
        }
      }),
    );
  }

  String getIcon(CheckTicketItemUIModel itemUIModel) {
    String icon = 'ticket_list_fix';
    switch (itemUIModel.status) {
      case CheckTicketItemStatus.qualified:
        icon = 'ticket_list_qualified';
        break;
      case CheckTicketItemStatus.unqualified:
        icon = 'ticket_list_unqualified';
        break;
      case CheckTicketItemStatus.fixed:
        icon = 'ticket_list_fix';
        break;
      case CheckTicketItemStatus.notApply:
        icon = 'ticket_list_not_apply';
        break;
      default:
        icon = 'ticket_list_unseclect';
        break;
    }
    return icon;
  }
}
