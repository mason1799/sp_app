import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_field_item.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/json_data.dart';
import 'package:konesp/widget/title_bar.dart';

import 'equipment_edit_logic.dart';

class EquipmentEditPage extends StatelessWidget {
  final logic = Get.find<EquipmentEditLogic>();
  final state = Get.find<EquipmentEditLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title: '编辑设备',
        actionName: '保存',
        onActionPressed: logic.toSubmit,
      ),
      body: GetBuilder<EquipmentEditLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomFieldItem(
                  isNecessary: true,
                  title: '项目名称',
                  value: state.detailEntity!['projectName'],
                  onTap: () => logic.toSelectProject(),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '选择地区',
                  value:
                      '${state.detailEntity!['province']} / ${state.detailEntity!['prefectureLevelCity']} / ${state.detailEntity!['countyLevelCity']}',
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '项目地址',
                  value: state.detailEntity!['projectLocation'],
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '项目类型',
                  value: _getProjectType(state.detailEntity!['projectType']),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '设备出厂编号',
                  value: state.detailEntity!['equipmentCode'],
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '楼号',
                  value: state.detailEntity!['buildingCode'],
                  onTap: () => logic.toInput(
                    title: '楼号',
                    reflect: 'buildingCode',
                    isNecessary: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp(r'[\\/:*?"<>|]')),
                    ],
                  ),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '梯号',
                  value: state.detailEntity!['elevatorCode'],
                  onTap: () => logic.toInput(
                    title: '梯号',
                    reflect: 'elevatorCode',
                    isNecessary: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp(r'[\\/:*?"<>|]')),
                    ],
                  ),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '设备类型',
                  value: state.detailEntity!['equipmentType'],
                  onTap: () => logic.toSelectContent(
                    title: '设备类型',
                    reflect: 'equipmentType',
                    jsonData: equipmentTypeJsonData,
                  ),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '设备品牌',
                  value: state.detailEntity!['equipmentBrand'],
                  onTap: () => logic.toSelectContent(
                    title: '设备品牌',
                    reflect: 'equipmentBrand',
                    jsonData: equipmentBrandJsonData,
                  ),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '部门',
                  value: state.detailEntity!['departmentName'],
                  onTap: () => logic.toSelectDepartment(),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '维保组',
                  value: state.detailEntity!['maintainerGroupName'],
                  onTap: () => logic.toSelectMaintainerGroup(),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '主保养人',
                  value: state.detailEntity!['mainMaintainerUserName'],
                  onTap: () => logic.toSelectMember(
                    title: '主保养人',
                    userNameReflect: 'mainMaintainerUserName',
                    employeeCodeReflect: 'mainMaintainerEmployeeCode',
                  ),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '主维修人',
                  value: state.detailEntity!['mainRepairerUserName'],
                  onTap: () => logic.toSelectMember(
                    title: '主维修人',
                    userNameReflect: 'mainRepairerUserName',
                    employeeCodeReflect: 'mainRepairerEmployeeCode',
                  ),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '设备监督检查日期',
                  value: state.detailEntity!['equipmentCheckDate'],
                  onTap: () => logic.toSelectDate(title: '设备监督检查日期', reflect: 'equipmentCheckDate'),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '下次年检日期',
                  value: state.detailEntity!['nextYearCheckDate'],
                  onTap: () => logic.toSelectDate(title: '下次年检日期', reflect: 'nextYearCheckDate'),
                ),
                CustomFieldItem(
                  isNecessary: true,
                  title: '设备地址',
                  value: state.detailEntity!['equipmentLocation'],
                  onTap: () => logic.toInput(title: '设备地址', reflect: 'equipmentLocation', isNecessary: true),
                ),
                CustomFieldItem(
                  title: '下次osg测试日期',
                  value: state.detailEntity!['nextOsgDate'],
                  onTap: () => logic.toSelectDate(title: '下次osg测试日期', reflect: 'nextOsgDate'),
                ),
                CustomFieldItem(
                  title: '下次125%测试日期',
                  value: state.detailEntity!['next125Date'],
                  onTap: () => logic.toSelectDate(title: '下次125%测试日期', reflect: 'next125Date'),
                ),
                CustomFieldItem(
                  title: '设备注册代码',
                  value: state.detailEntity!['registerCode'],
                  onTap: () => logic.toInput(title: '设备注册代码', reflect: 'registerCode'),
                ),
                CustomFieldItem(
                  title: '96333编号',
                  value: state.detailEntity!['code96333'],
                  onTap: () => logic.toInput(title: '96333编号', reflect: 'code96333'),
                ),
                CustomFieldItem(
                  title: '层数',
                  value: (state.detailEntity!['floorNum'] ?? '').toString(),
                  onTap: () => logic.toInput(
                    title: '层数',
                    reflect: 'floorNum',
                    textInputType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                CustomFieldItem(
                  title: '门厅数',
                  value: (state.detailEntity!['lobbyNum'] ?? '').toString(),
                  onTap: () => logic.toInput(
                    title: '门厅数',
                    reflect: 'lobbyNum',
                    textInputType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                CustomFieldItem(
                  title: 'IoT设备编码',
                  value: state.detailEntity!['iotCode'],
                  onTap: () => logic.toInput(
                    title: 'IoT设备编码',
                    reflect: 'iotCode',
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]')),
                    ],
                  ),
                  bottomLine: false,
                ),
              ],
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

  String _getProjectType(String? value) {
    switch (value) {
      case 'R':
        return '住宅';
      case 'S':
        return '学校';
      case 'H':
        return '医院';
      case 'V':
        return '别墅';
      case 'G':
        return '政府机关';
      case 'O':
        return '办公商业';
      case 'E':
        return '酒店娱乐';
      case 'T':
        return '公共交通';
      case 'IS':
        return '服务中';
      default:
        return '停止服务';
    }
  }
}
