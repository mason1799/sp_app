import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_field_item.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/equipment_icon.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'equipment_detail_logic.dart';

class EquipmentDetailPage extends StatelessWidget {
  final logic = Get.find<EquipmentDetailLogic>();
  final state = Get.find<EquipmentDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '设备详情',
        actionWidget: GetBuilder<EquipmentDetailLogic>(builder: (_) => _ActionWidget()),
      ),
      body: GetBuilder<EquipmentDetailLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.w),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: Colours.bg,
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              alignment: Alignment.center,
                              child: EquipmentIcon(type: state.detailEntity!.equipmentTypeCode),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      if ([1, 2].contains(state.detailEntity!.iotOnline))
                                        Container(
                                          width: 10.w,
                                          height: 10.w,
                                          margin: EdgeInsets.only(right: 5.w),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: state.detailEntity!.iotOnline! == 2 ? Colors.green : Colours.text_ccc,
                                          ),
                                        ),
                                      Expanded(
                                        child: Text(
                                          '${state.detailEntity!.buildingCode ?? ''} ${state.detailEntity!.elevatorCode ?? ''} | ${state.detailEntity!.equipmentCode}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colours.text_333,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.w),
                                  Text(
                                    state.detailEntity!.projectName ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colours.text_333,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        Row(
                          children: [
                            LoadSvgImage(
                              'project_house',
                              width: 15.w,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                state.detailEntity!.projectName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        Row(
                          children: [
                            LoadSvgImage(
                              'project_location',
                              width: 15.w,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                state.detailEntity!.projectLocation ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (state.detailEntity!.iotOnline == 2)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.w),
                      margin: EdgeInsets.only(top: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '实时数据',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15.w),
                          GetBuilder<EquipmentDetailLogic>(
                            id: 'iot',
                            builder: (_) => MasonryGridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 15.w,
                              crossAxisSpacing: 15.w,
                              itemBuilder: (context, index) {
                                List list = [
                                  DataItem(title: '当前楼层', icon: 'floor', value: state.detailEntity!.currentFloor),
                                  DataItem(
                                      title: '运行方向',
                                      icon: _getDirectionIcon(state.detailEntity!.runDirection),
                                      value: _getDirectionName(state.detailEntity!.runDirection)),
                                  NumberItem(
                                    title: '运行速度',
                                    icon: 'speed',
                                    unit: 'M/S',
                                    value: (state.detailEntity!.currentSpeed ?? 0) / 100,
                                  ),
                                  DataItem(
                                    title: '电梯状态',
                                    icon: state.detailEntity!.status == 1 ? 'status_normal' : 'status_fix',
                                    value: state.detailEntity!.status == 1 ? '正常' : '检修',
                                  ),
                                  DataItem(
                                    title: '轿厢运行',
                                    icon: state.detailEntity!.elevatorOperation == 1 ? 'elevator_operation_running' : 'elevator_operation_stop',
                                    value: state.detailEntity!.elevatorOperation == 1 ? '运行' : '停止',
                                  ),
                                  DataItem(
                                    title: '安全回路',
                                    icon: state.detailEntity!.safeCircuit == 1 ? 'safe_circuit_disconnected' : 'safe_circuit_connected',
                                    value: state.detailEntity!.safeCircuit == 1 ? '断开' : '导通',
                                  ),
                                  DataItem(
                                    title: '环境温度',
                                    icon: 'temperature',
                                    value: '未知',
                                    // value: '°C',
                                  ),
                                ];
                                return list[index];
                              },
                              itemCount: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w, bottom: 5.w),
                          child: Text(
                            '电梯信息',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        CustomFieldItem(title: '设备出厂编号', value: state.detailEntity!.equipmentCode),
                        CustomFieldItem(title: '楼号', value: state.detailEntity!.buildingCode),
                        CustomFieldItem(title: '梯号', value: state.detailEntity!.elevatorCode),
                        CustomFieldItem(title: '设备类型', value: state.detailEntity!.equipmentType),
                        CustomFieldItem(title: '设备品牌', value: state.detailEntity!.equipmentBrand),
                        CustomFieldItem(title: '部门', value: state.detailEntity!.departmentName),
                        CustomFieldItem(title: '维保组', value: state.detailEntity!.maintainerGroupName),
                        CustomFieldItem(title: '主保养人', value: state.detailEntity!.mainMaintainerUserName),
                        CustomFieldItem(title: '主维修人', value: state.detailEntity!.mainRepairerUserName),
                        CustomFieldItem(title: '设备监督检查日期', value: state.detailEntity!.equipmentCheckDate),
                        CustomFieldItem(title: '下次年检日期', value: state.detailEntity!.nextYearCheckDate),
                        CustomFieldItem(title: '设备地址', value: state.detailEntity!.equipmentLocation),
                        CustomFieldItem(title: '下次osg测试日期', value: state.detailEntity!.nextOsgDate),
                        CustomFieldItem(title: '下次125%测试日期', value: state.detailEntity!.next125Date),
                        CustomFieldItem(title: '设备注册代码', value: state.detailEntity!.registerCode),
                        CustomFieldItem(title: '96333编号', value: state.detailEntity!.code96333),
                        CustomFieldItem(title: '层数', value: (state.detailEntity!.floorNum ?? '').toString()),
                        CustomFieldItem(title: '门厅数', value: (state.detailEntity!.lobbyNum ?? '').toString()),
                        CustomFieldItem(title: 'IoT设备编号', value: state.detailEntity!.iotCode, bottomLine: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.pageStatus == PageStatus.error) {
          return ErrorPage();
        } else if (state.pageStatus == PageStatus.loading) {
          return CenterLoading();
        } else {
          return EmptyPage();
        }
      }),
    );
  }

  String _getDirectionName(int? value) {
    switch (value) {
      case 0:
        return '停梯';
      case 17:
      case 33:
        return '上行';
      case 18:
      case 34:
        return '下行';
      default:
        return '未知状态';
    }
  }

  String _getDirectionIcon(int? value) {
    switch (value) {
      case 0:
        return 'run_direction_stop';
      case 17:
      case 33:
        return 'run_direction_up';
      case 18:
      case 34:
        return 'run_direction_down';
      default:
        return 'run_direction_none';
    }
  }
}

class _ActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<EquipmentDetailLogic>();
    return StoreLogic.to.permissions.intersection({UserPermission.editEquipment, UserPermission.deleteEquipment}).isNotEmpty
        ? InkWell(
            onTap: logic.moreAction,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              child: LoadAssetImage(
                'more_icon',
                width: 16.w,
                color: Colours.text_333,
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
