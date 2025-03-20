import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/project_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/search_placehold.dart';
import 'package:konesp/widget/title_bar.dart';

import '../widget/equipment_item.dart';
import '../widget/project_item.dart';
import 'project_detail_logic.dart';

class ProjectDetailPage extends StatelessWidget {
  final logic = Get.find<ProjectDetailLogic>();
  final state = Get.find<ProjectDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDetailLogic>(builder: (_) {
      return Scaffold(
        appBar: TitleBar(
          title: state.pageStatus == PageStatus.success ? (state.projectDetailEntity!.projectName!) : '',
        ),
        body: _Body(logic: logic),
      );
    });
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.logic,
  });

  final ProjectDetailLogic logic;

  @override
  Widget build(BuildContext context) {
    final state = logic.state;
    return SlidableAutoCloseBehavior(
      child: AdvanceRefreshListView(
        pageStatus: state.pageStatus,
        itemCount: state.items.length + 1,
        onRefresh: () => logic.pull(),
        onLoadMore: () => logic.loadMore(),
        hasMore: state.hasMore,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                  child: SearchPlacehold(
                    onSearch: logic.toSearch,
                    hintText: '搜索项目/设备',
                  ),
                ),
                SizedBox(height: 10.w),
                ProjectItem(
                  projectEntity: ProjectEntity()
                    ..projectName = state.projectDetailEntity!.projectName
                    ..projectLocation = state.projectDetailEntity!.projectLocation
                    ..equipmentNum = state.projectDetailEntity!.equipmentNum
                    ..iotNum = state.projectDetailEntity!.iotNum,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 15.w, bottom: 15.w),
                  child: Text(
                    '设备列表',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            );
          }
          final equipmentEntity = state.items[index - 1];
          return Padding(
            padding: EdgeInsets.only(top: index > 1 ? 10.w : 0),
            child: EquipmentItem(
              entity: equipmentEntity,
              onTap: () => logic.toItem(equipmentEntity.id!),
              onEdit: () => logic.toEdit(equipmentEntity.id!),
              onDelete: () => logic.toDelete(equipmentEntity.id!),
            ),
          );
        },
      ),
    );
  }
}
