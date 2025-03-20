import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/task_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/gradient_btn.dart';
import 'package:konesp/widget/keep_alive_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../widget/group_page.dart';
import 'group_list_logic.dart';

/// 所属维保组
class GroupListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(GroupListLogic());
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 1) {
          logic.query();
        }
      },
      key: const Key('GroupListPage'),
      child: GetBuilder<GroupListLogic>(builder: (_) {
        if (logic.state.pageStatus == PageStatus.success) {
          return Column(
            children: [
              if (StoreLogic.to.getUser()!.leader == true && StoreLogic.to.getUser()!.group == true)
                Container(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, top: 10.w, bottom: 10.w),
                            child: GradientBtn(
                              onPressed: () => logic.selectFixStatus(status: WordOrderFixButtonStatus.belong),
                              select: logic.state.selectFixStatus == WordOrderFixButtonStatus.belong,
                              height: 28.w,
                              borderRadius: BorderRadius.circular(14.w),
                              child: Text(
                                '所属维保组',
                                style: logic.state.selectFixStatus == WordOrderFixButtonStatus.belong
                                    ? TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                      )
                                    : TextStyle(
                                        fontSize: 12.sp,
                                        color: Colours.text_333,
                                      ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, top: 10.w, bottom: 10.w),
                            child: GradientBtn(
                              onPressed: () => logic.selectFixStatus(status: WordOrderFixButtonStatus.all),
                              select: logic.state.selectFixStatus == WordOrderFixButtonStatus.all,
                              height: 28.w,
                              borderRadius: BorderRadius.circular(14.w),
                              child: Text(
                                '所有维保组',
                                style: logic.state.selectFixStatus == WordOrderFixButtonStatus.all
                                    ? TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                      )
                                    : TextStyle(
                                        fontSize: 12.sp,
                                        color: Colours.text_333,
                                      ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${logic.state.groupModel?.groupName ?? ''} ${logic.state.groupModel?.groupCode ?? ''}',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              if (StoreLogic.to.getUser()!.leader != true && StoreLogic.to.getUser()!.group != true)
                Expanded(child: GroupPage(logic: logic))
              else if (StoreLogic.to.getUser()!.leader == true && StoreLogic.to.getUser()!.group != true)
                Expanded(child: keepAlivePage(AllGroupListPage(logic: logic)))
              else
                Expanded(
                    child: logic.state.selectFixStatus == WordOrderFixButtonStatus.belong
                        ? keepAlivePage(GroupPage(logic: logic))
                        : keepAlivePage(AllGroupListPage(logic: logic))),
            ],
          );
        } else if (logic.state.pageStatus == PageStatus.loading) {
          return CenterLoading();
        } else if (logic.state.pageStatus == PageStatus.error) {
          return ErrorPage(msg: '权限不足');
        } else {
          return EmptyPage();
        }
      }),
    );
  }
}

/// 所有维保组列表
class AllGroupListPage extends StatelessWidget {
  AllGroupListPage({required this.logic});

  final GroupListLogic logic;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10.w),
      padding: EdgeInsets.all(10.w),
      itemBuilder: (context, index) => FixGroupListItem(
        groupDetailEntity: logic.state.items[index],
      ),
      itemCount: logic.state.items.length,
    );
  }
}

class FixGroupListItem extends StatefulWidget {
  const FixGroupListItem({Key? key, required this.groupDetailEntity}) : super(key: key);
  final GroupDetailEntity groupDetailEntity;

  @override
  State<FixGroupListItem> createState() => _FixGroupListItemState();
}

class _FixGroupListItemState extends State<FixGroupListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.groupDetail, arguments: {'entity': widget.groupDetailEntity}),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.groupDetailEntity.groupName ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colours.text_333,
                        ),
                      ),
                      SizedBox(height: 5.w),
                      Row(
                        children: [
                          LoadSvgImage(
                            'group_member',
                            width: 10.w,
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Text(
                              widget.groupDetailEntity.employee ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xFF9F9F9F),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '今日',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colours.primary,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '未响应${widget.groupDetailEntity.awaitFinish ?? 0} | 响应中${widget.groupDetailEntity.response ?? 0} | 已完成${widget.groupDetailEntity.finish ?? 0}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF9F9F9F),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
          ),
        ),
      ),
    );
  }
}
