import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/order/widget/bottom_btn.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/equipment_icon.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import '../widget/segment_btn.dart';
import 'fix_create_logic.dart';

class FixCreatePage extends StatelessWidget {
  final logic = Get.find<FixCreateLogic>();
  final state = Get.find<FixCreateLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return await logic.showExitDialog();
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.focusScope?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: TitleBar(
              title: '新建故障工单',
              onBack: logic.showExitDialog,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetBuilder<FixCreateLogic>(
                            id: 'device',
                            builder: (_) {
                              return InkWell(
                                onTap: logic.selectFixDevice,
                                child: (state.selectDevice != null)
                                    ? Container(
                                        padding: EdgeInsets.all(10.w),
                                        margin: EdgeInsets.only(bottom: 10.w),
                                        color: Colors.white,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 45.w,
                                              height: 45.w,
                                              decoration: BoxDecoration(
                                                color: Colours.bg,
                                                borderRadius: BorderRadius.circular(4.w),
                                              ),
                                              alignment: Alignment.center,
                                              child: EquipmentIcon(type: state.selectDevice!.equipmentType),
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${state.selectDevice!.projectName} ${state.selectDevice!.buildingCode} ${state.selectDevice!.elevatorCode}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colours.text_333,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 5.w),
                                                  Text(
                                                    '${state.selectDevice!.equipmentTypeName ?? ''} ${state.selectDevice!.equipmentCode ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colours.text_ccc,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                            LoadSvgImage(
                                              'arrow_right',
                                              width: 14.w,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(bottom: 10.w),
                                        height: 60.w,
                                        color: Colors.white,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                                          height: 40.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0xFFF3F6FE),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10.w),
                                                  child: LoadSvgImage(
                                                    'kone_add_circle',
                                                    width: 14.w,
                                                  ),
                                                ),
                                                Text(
                                                  '添加设备',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colours.primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              );
                            }),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(15.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '*',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                '故障报修类型',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colours.text_333,
                                ),
                              ),
                              const Spacer(),
                              GetBuilder<FixCreateLogic>(
                                id: 'segment',
                                builder: (_) => SegmentButton(
                                  isNormal: state.isNormal,
                                  onTap: (bool select) => logic.selectType(select),
                                ),
                              ),
                            ],
                          ),
                        ),
                        divider,
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                                child: Row(
                                  children: [
                                    Text(
                                      '*',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      '故障描述',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_333,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                                child: TextField(
                                  controller: state.textFaultDescController,
                                  focusNode: state.textFaultDescFocusNode,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colours.text_333,
                                  ),
                                  maxLines: 2,
                                  onEditingComplete: () => Get.focusScope?.unfocus(),
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    hintText: '请输入当前设备情况',
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colours.text_ccc,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 15.w),
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.w,
                                  children: [
                                    _TextSmallButton(
                                      title: '设备停止运行',
                                      onTap: (value) => logic.appendFixDescription('设备停止运行'),
                                    ),
                                    _TextSmallButton(
                                      title: '运行异响/抖动',
                                      onTap: (value) => logic.appendFixDescription('运行异响/抖动'),
                                    ),
                                    _TextSmallButton(
                                      title: '梯门开关故障',
                                      onTap: (value) => logic.appendFixDescription('梯门开关故障'),
                                    ),
                                    _TextSmallButton(
                                      title: '按钮失效/损坏',
                                      onTap: (value) => logic.appendFixDescription('按钮失效/损坏'),
                                    ),
                                    _TextSmallButton(
                                      title: '设备显示故障',
                                      onTap: (value) => logic.appendFixDescription('设备显示故障'),
                                    ),
                                    _TextSmallButton(
                                      title: '停电',
                                      onTap: (value) => logic.appendFixDescription('停电'),
                                    ),
                                    _TextSmallButton(
                                      title: '外部损坏',
                                      onTap: (value) => logic.appendFixDescription('外部损坏'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.w),
                        GetBuilder<FixCreateLogic>(
                            id: 'dateTime',
                            builder: (_) {
                              return InkWell(
                                onTap: logic.selectFixDate,
                                child: Container(
                                  height: 50.w,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Text(
                                        '*',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        '报修时间：',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colours.text_333,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DateUtil.formatDateStr(state.selectTime, format: DateFormats.ymdhm) ?? '请选择报修时间',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: ObjectUtil.isNotEmpty(state.selectTime) ? Colours.text_333 : Colours.text_ccc,
                                          ),
                                        ),
                                      ),
                                      LoadSvgImage(
                                        'arrow_right',
                                        width: 14.w,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        divider,
                        GetBuilder<FixCreateLogic>(
                            id: 'reportor',
                            builder: (_) {
                              return InkWell(
                                onTap: logic.inputReportor,
                                child: Container(
                                  height: 50.w,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Text(
                                        '报修人姓名：',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colours.text_333,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ObjectUtil.isNotEmpty(state.reportor) ? state.reportor! : '请输入报修人姓名',
                                          style: TextStyle(
                                            color: ObjectUtil.isNotEmpty(state.reportor) ? Colours.text_333 : Colours.text_ccc,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      LoadSvgImage(
                                        'arrow_right',
                                        width: 14.w,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        divider,
                        GetBuilder<FixCreateLogic>(
                          id: 'role',
                          builder: (_) {
                            return InkWell(
                              onTap: logic.selectFixRole,
                              child: Container(
                                height: 50.w,
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Text(
                                      '报修人角色：',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_333,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ObjectUtil.isNotEmpty(state.currentPeople) ? state.currentPeople! : '请选择报修人角色',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: ObjectUtil.isNotEmpty(state.currentPeople) ? Colours.text_333 : Colours.text_ccc,
                                        ),
                                      ),
                                    ),
                                    LoadSvgImage(
                                      'arrow_right',
                                      width: 14.w,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        divider,
                        GetBuilder<FixCreateLogic>(
                          id: 'phone',
                          builder: (_) {
                            return InkWell(
                              onTap: logic.inputPhone,
                              child: Container(
                                height: 50.w,
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Text(
                                      '报修人电话：',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_333,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ObjectUtil.isNotEmpty(state.phone) ? state.phone! : '请输入报修人电话',
                                        style: TextStyle(
                                          color: ObjectUtil.isNotEmpty(state.phone) ? Colours.text_333 : Colours.text_ccc,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    LoadSvgImage(
                                      'arrow_right',
                                      width: 14.w,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10.w),
                        GetBuilder<FixCreateLogic>(
                            id: 'employee',
                            builder: (_) {
                              return InkWell(
                                onTap: logic.selectFixEmployee,
                                child: Container(
                                  height: 50.w,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Text(
                                        '*',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        '指派员工：',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colours.text_333,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ObjectUtil.isNotEmpty(state.selectedUserId) && state.selectedUserId! > -1
                                              ? state.selectedUserName!
                                              : (ObjectUtil.isNotEmpty(state.selectedGroupName) ? state.selectedGroupName! : '请指派员工'),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: (ObjectUtil.isNotEmpty(state.selectedUserId) && state.selectedUserId! > -1) ||
                                                    ObjectUtil.isNotEmpty(state.selectedGroupCode)
                                                ? Colours.text_333
                                                : Colours.text_ccc,
                                          ),
                                        ),
                                      ),
                                      LoadSvgImage(
                                        'arrow_right',
                                        width: 14.w,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        SizedBox(height: 10.w),
                      ],
                    ),
                  ),
                ),
                BottomBtn(
                  onPressed: logic.confirm,
                  btnName: '创建工单',
                ),
              ],
            ),
          ),
        ));
  }
}

class _TextSmallButton extends StatelessWidget {
  const _TextSmallButton({
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function(String title) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(title),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          color: Color(0xffF5F5F5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colours.text_333,
          ),
        ),
      ),
    );
  }
}
