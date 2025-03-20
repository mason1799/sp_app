import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/device_project_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_expand_icon.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/equipment_icon.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/search_widget.dart';
import 'package:konesp/widget/title_bar.dart';

import 'device_select_logic.dart';

class DeviceSelectPage extends StatelessWidget {
  final logic = Get.find<DeviceSelectLogic>();
  final state = Get.find<DeviceSelectLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(title: '选择设备'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            child: SearchWidget(
              controller: state.searchController,
              onSearch: logic.search,
              hintText: '搜索项目名称、楼号、梯号或设备出厂编号',
            ),
          ),
          Obx(() {
            if (state.pageStatus.value == PageStatus.success) {
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    DeviceProjectEntity? data = state.devices[index];
                    return Container(
                      color: Colors.white,
                      child: DeviceListWidget(data: data, list: data.equipmentInfoList ?? [], index: index),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.w),
                  itemCount: state.devices.length,
                ),
              );
            } else if (state.pageStatus.value == PageStatus.error) {
              return Expanded(child: ErrorPage());
            } else if (state.pageStatus.value == PageStatus.loading) {
              return Expanded(child: CenterLoading());
            } else {
              return Expanded(child: EmptyPage());
            }
          }),
        ],
      ),
    );
  }
}

class DeviceItemWidget extends StatelessWidget {
  final DeviceProjectEquipmentInfoList? entity;

  DeviceItemWidget({super.key, this.entity});

  @override
  Widget build(BuildContext context) {
    final state = Get.find<DeviceSelectLogic>().state;
    return Obx(() {
      return InkWell(
        onTap: () {
          state.currentSelect.value = entity;
          state.currentSelect.refresh();
          Get.back(result: state.currentSelect.value);
        },
        child: Container(
          color: Colors.white,
          height: 70.w,
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            children: [
              LoadAssetImage(
                state.currentSelect.value?.id != null && state.currentSelect.value?.id == entity?.id ? 'check_box_checked_icon' : 'check_box_icon',
                width: 20.w,
              ),
              SizedBox(width: 10.w),
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: Colours.bg,
                  borderRadius: BorderRadius.circular(4.w),
                ),
                alignment: Alignment.center,
                child: EquipmentIcon(type: entity?.equipmentType),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${entity?.buildingCode} ${entity?.elevatorCode}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colours.text_333,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.w),
                    Text(
                      '${entity?.equipmentTypeName} | ${entity?.equipmentCode}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colours.text_999,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class DeviceListWidget extends StatefulWidget {
  DeviceListWidget({
    Key? key,
    this.data,
    this.list,
    this.index = 0,
  }) : super(key: key);
  final DeviceProjectEntity? data;
  final List<DeviceProjectEquipmentInfoList>? list;
  final int index;

  @override
  State<DeviceListWidget> createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  final state = Get.find<DeviceSelectLogic>().state;
  late ExpandableController controller;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    controller = ExpandableController(initialExpanded: state.indexExpand[widget.index]);
    controller.addListener(() {
      state.indexExpand[widget.index] = controller.expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        controller: controller,
        child: ScrollOnExpand(
          scrollOnExpand: false,
          scrollOnCollapse: false,
          child: ExpandablePanel(
            theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                alignment: Alignment.topCenter,
                tapBodyToCollapse: false,
                iconPadding: EdgeInsets.only(right: 28.w),
                hasIcon: false),
            header: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.data?.projectName ?? '',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colours.text_333,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.w),
                          Row(
                            children: [
                              LoadAssetImage('location_icon', width: 10.w),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  widget.data?.projectLocation ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colours.text_999,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CustomExpandableIcon(downPath: 'down_icon', upPath: 'up_icon', width: 10.w, height: 6.w),
                  ],
                )),
            collapsed: Container(),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < widget.list!.length; i++)
                  Column(
                    children: [
                      DeviceItemWidget(entity: widget.list![i]),
                      Divider(
                        height: 0.5.w,
                        color: Colours.bg,
                      ),
                    ],
                  )
              ],
            ),
            builder: (_, collapsed, expanded) {
              return Padding(
                padding: EdgeInsets.zero,
                child: Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                ),
              );
            },
          ),
        ));
  }
}

class DeviceDefaultItemWidget extends StatelessWidget {
  final Function click;

  DeviceDefaultItemWidget(this.click, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 36, right: 36, bottom: 10, top: 10),
      child: InkWell(
        onTap: () => click.call(),
        child: Container(
          color: const Color(0xffF3F6FE),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadAssetImage(
                'add_circle_icon',
                width: 14,
                height: 14,
              ),
              SizedBox(width: 10.w),
              Text(
                '添加设备',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colours.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
