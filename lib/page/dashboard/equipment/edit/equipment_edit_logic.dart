import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/department_info_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/entity/maintaine_group_entity.dart';
import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/entity/service_group_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/dashboard/equipment/project_list/project_list_logic.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/sheet/input_dialog.dart';
import 'package:konesp/widget/sheet/single_dialog.dart';
import 'package:konesp/widget/sheet/ymd_time_dialog.dart';
import 'package:sprintf/sprintf.dart';

import '../detail/equipment_detail_logic.dart';
import '../project_detail/project_detail_logic.dart';
import 'equipment_edit_state.dart';

class EquipmentEditLogic extends BaseController {
  final EquipmentEditState state = EquipmentEditState();

  @override
  void onReady() {
    query();
  }

  query() async {
    final result = await get<Map<String, dynamic>>(sprintf(Api.equipmentDetail, [state.id]));
    if (result.success) {
      state.detailEntity = result.data!;
      state.pageStatus = PageStatus.success;
    } else {
      showToast(result.msg);
      state.pageStatus = PageStatus.error;
    }
    update();
  }

  void toSubmit() async {
    if (_checkIfNecessary()) {
      return;
    }
    Map _map = {
      'buildingCode': state.detailEntity!['buildingCode'],
      'code96333': state.detailEntity!['code96333'],
      'custom': state.detailEntity!['custom'],
      'department': state.detailEntity!['department'],
      'departmentName': state.detailEntity!['departmentName'],
      'elevatorCode': state.detailEntity!['elevatorCode'],
      'equipmentBrand': state.detailEntity!['equipmentBrand'],
      'equipmentCheckDate': state.detailEntity!['equipmentCheckDate'],
      'equipmentCode': state.detailEntity!['equipmentCode'],
      'equipmentLocation': state.detailEntity!['equipmentLocation'],
      'equipmentType': state.detailEntity!['equipmentType'],
      'floorNum': state.detailEntity!['floorNum'],
      'id': state.detailEntity!['id'],
      'levelThreeCode': state.detailEntity!['levelThreeCode'],
      'lobbyNum': state.detailEntity!['lobbyNum'],
      'mainMaintainerEmployeeCode': state.detailEntity!['mainMaintainerEmployeeCode'],
      'mainMaintainerUserName': state.detailEntity!['mainMaintainerUserName'],
      'mainRepairerEmployeeCode': state.detailEntity!['mainRepairerEmployeeCode'],
      'mainRepairerUserName': state.detailEntity!['mainRepairerUserName'],
      'maintainerGroupCode': state.detailEntity!['maintainerGroupCode'],
      'maintainerGroupName': state.detailEntity!['maintainerGroupName'],
      'next125Date': state.detailEntity!['next125Date'],
      'nextOsgDate': state.detailEntity!['nextOsgDate'],
      'nextYearCheckDate': state.detailEntity!['nextYearCheckDate'],
      'projectCode': state.detailEntity!['projectCode'],
      'projectId': state.detailEntity!['projectId'],
      'projectLocation': state.detailEntity!['projectLocation'],
      'projectName': state.detailEntity!['projectName'],
      'projectType': state.detailEntity!['projectType'],
      'registerCode': state.detailEntity!['registerCode'],
      'iotCode': state.detailEntity!['iotCode'],
    };
    showProgress();
    final result = await post(Api.submitDevice, params: _map);
    closeProgress();
    if (result.success) {
      if (Get.isRegistered<EquipmentDetailLogic>()) {
        Get.find<EquipmentDetailLogic>().query();
      }
      if (Get.isRegistered<ProjectDetailLogic>()) {
        Get.find<ProjectDetailLogic>().query();
      }
      if (Get.isRegistered<ProjectListLogic>()) {
        Get.find<ProjectListLogic>().pull();
      }
      Get.back();
    } else {
      showToast(result.msg);
    }
  }

  bool _checkIfNecessary() {
    if (state.detailEntity == null) {
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['projectName'])) {
      showToast('请输入项目名称');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['buildingCode'])) {
      showToast('请输入楼号');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['elevatorCode'])) {
      showToast('请输入梯号');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['equipmentType'])) {
      showToast('请输入设备类型');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['equipmentBrand'])) {
      showToast('请输入设备品牌');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['department']) || ObjectUtil.isEmpty(state.detailEntity!['departmentName'])) {
      showToast('请输入部门');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['maintainerGroupCode']) || ObjectUtil.isEmpty(state.detailEntity!['maintainerGroupName'])) {
      showToast('请输入维保组');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['mainMaintainerEmployeeCode']) || ObjectUtil.isEmpty(state.detailEntity!['mainMaintainerUserName'])) {
      showToast('请输入主保养人');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['mainRepairerEmployeeCode']) || ObjectUtil.isEmpty(state.detailEntity!['mainRepairerUserName'])) {
      showToast('请输入主维修人');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['equipmentCheckDate'])) {
      showToast('请输入设备监督检查日期');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['nextYearCheckDate'])) {
      showToast('请输入下次年检日期');
      return true;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['equipmentLocation'])) {
      showToast('请输入设备地址');
      return true;
    }
    return false;
  }

  void toSelectProject() async {
    List<ProjectEntity>? projects;
    showProgress();
    final result = await post<List<ProjectEntity>>(Api.projectList, params: {});
    closeProgress();
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data)) {
        projects = result.data!;
      } else {
        showToast('没有任何项目信息');
      }
    } else {
      showToast(result.msg);
    }
    if (ObjectUtil.isEmpty(projects)) {
      return;
    }
    List<String> data = projects!.map((item) => item.projectName!).toList();
    int _index = data.indexOf(state.detailEntity!['projectName']);
    Get.bottomSheet(
      SingleDialog(
        title: '项目名称',
        initialIndex: _index > -1 ? _index : 0,
        data: data,
        resultData: (index, value) async {
          state.detailEntity!['projectCode'] = projects![index].projectCode;
          state.detailEntity!['projectName'] = projects[index].projectName;
          state.detailEntity!['projectId'] = projects[index].id;
          state.detailEntity!['projectLocation'] = projects[index].projectLocation;
          state.detailEntity!['levelThreeCode'] = projects[index].levelThreeCode;
          state.detailEntity!['province'] = projects[index].province;
          state.detailEntity!['prefectureLevelCity'] = projects[index].prefectureLevelCity;
          state.detailEntity!['countyLevelCity'] = projects[index].countyLevelCity;
          state.detailEntity!['projectType'] = projects[index].projectType;
          update();
        },
      ),
    );
  }

  void toSelectDepartment() async {
    List<DepartmentNode>? departments;
    showProgress();
    final result = await get<List<DepartmentInfoEntity>>(Api.branchDepartment);
    closeProgress();
    if (result.success) {
      departments = result.data?.map((e) => DepartmentNode.fromEntity(e)).toList();
    } else {
      showToast(result.msg);
    }
    if (ObjectUtil.isEmpty(departments)) {
      showToast('部门数据获取失败');
      return;
    }
    DepartmentNode? departmentNode;
    String? fromId = state.detailEntity!['department'];
    for (var element in departments!) {
      departmentNode = element.getDepartmentFromID(fromId);
    }
    var nodes = await Get.toNamed(Routes.department, arguments: {'selectedDepartment': departmentNode});
    if (nodes is List<DepartmentNode> && nodes.isNotEmpty) {
      state.detailEntity!['department'] = nodes.first.id;
      state.detailEntity!['departmentName'] = nodes.first.name;
      state.detailEntity!['maintainerGroupName'] = null;
      state.detailEntity!['maintainerGroupCode'] = null;
      state.detailEntity!['mainMaintainerUserName'] = null;
      state.detailEntity!['mainMaintainerEmployeeCode'] = null;
      state.detailEntity!['mainRepairerUserName'] = null;
      state.detailEntity!['mainRepairerEmployeeCode'] = null;
      update();
    }
  }

  void toSelectMaintainerGroup() async {
    List<MaintaineGroupEntity>? groups;
    showProgress();
    final result = await post<List<MaintaineGroupEntity>>(Api.maintenanceGroups, params: {
      'departmentId': state.detailEntity!['department'],
    });
    closeProgress();
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data)) {
        groups = result.data!;
      } else {
        showToast('该部门下没有任何维保组');
      }
    } else {
      showToast(result.msg);
    }
    if (ObjectUtil.isEmpty(groups)) {
      return;
    }
    List<String> data = groups!.map((item) => '${item.groupName} / ${item.groupCode}').toList();
    Get.bottomSheet(
      SingleDialog(
        title: '维保组',
        data: data,
        resultData: (index, value) async {
          state.detailEntity!['maintainerGroupCode'] = groups![index].groupCode;
          state.detailEntity!['maintainerGroupName'] = groups[index].groupName;
          state.detailEntity!['mainMaintainerUserName'] = null;
          state.detailEntity!['mainMaintainerEmployeeCode'] = null;
          state.detailEntity!['mainRepairerUserName'] = null;
          state.detailEntity!['mainRepairerEmployeeCode'] = null;
          update();
        },
      ),
    );
  }

  void toSelectMember({
    required String title,
    required String userNameReflect,
    required String employeeCodeReflect,
  }) async {
    if (state.detailEntity == null) {
      return;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['department']) || ObjectUtil.isEmpty(state.detailEntity!['departmentName'])) {
      showToast('请先选择部门');
      return;
    }
    if (ObjectUtil.isEmpty(state.detailEntity!['maintainerGroupCode']) || ObjectUtil.isEmpty(state.detailEntity!['maintainerGroupName'])) {
      showToast('请先选择维保组');
      return;
    }
    List<ServiceGroupMember>? members;
    showProgress();
    final result = await post<List<ServiceGroupEntity>>(
      Api.serviceGroups,
      params: {'groupCode': state.detailEntity!['maintainerGroupCode'], 'departmentId': state.detailEntity!['department']},
    );
    closeProgress();
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data)) {
        members = result.data!.first.members;
      } else {
        showToast('该维保组下没有任何成员');
      }
    } else {
      showToast(result.msg);
    }
    if (ObjectUtil.isEmpty(members)) {
      return;
    }
    List<String> data = members!.map((item) => '${item.username} / ${item.employeeCode} ').toList();
    Get.bottomSheet(
      SingleDialog(
        title: title,
        data: data,
        resultData: (index, value) {
          state.detailEntity![userNameReflect] = members![index].username;
          state.detailEntity![employeeCodeReflect] = members[index].employeeCode;
          update();
        },
      ),
    );
  }

  void toSelectContent({required String title, required String reflect, required List<String> jsonData}) {
    int _index = ObjectUtil.isEmpty(state.detailEntity![reflect]) ? -1 : jsonData.indexOf(state.detailEntity![reflect]);
    Get.bottomSheet(
      SingleDialog(
        title: title,
        initialIndex: _index > -1 ? _index : 0,
        data: jsonData,
        resultData: (index, value) {
          state.detailEntity![reflect] = value;
          update();
        },
      ),
    );
  }

  void toSelectDate({required String title, required String reflect}) {
    Get.bottomSheet(
      YmdTimeDialog(
        title: title,
        initialDateTime: DateUtil.getDateTime(state.detailEntity![reflect]),
        onResult: (result) {
          state.detailEntity![reflect] = DateUtil.formatDate(result, format: DateFormats.ymd);
          update();
        },
      ),
    );
  }

  void toInput({
    required String title,
    required String reflect,
    bool isNecessary = false,
    TextInputType textInputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) async {
    Get.dialog(
      InputDialog(
        title: title,
        necessary: isNecessary,
        initialValue: state.detailEntity![reflect],
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        onSave: (value) {
          state.detailEntity![reflect] = value;
          update();
        },
      ),
    );
  }
}
