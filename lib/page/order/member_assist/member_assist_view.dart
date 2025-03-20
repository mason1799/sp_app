import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/page/order/member_assist/member_assist_logic.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/custom_expand_icon.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/search_widget.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';

class MemberAssistPage extends StatelessWidget {
  final logic = Get.find<MemberAssistLogic>();
  final state = Get.find<MemberAssistLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(title: '编辑辅助人员'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w, bottom: 10.w),
            child: SearchWidget(
              controller: state.searchController,
              onSearch: logic.filterData,
              hintText: '搜索姓名或手机号',
            ),
          ),
          Obx(() {
            return Expanded(child: buildBody(state.pageStatus.value));
          }),
          Obx(() {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 24.w, right: 12.w, top: 12.w, bottom: 12.w + ScreenUtil().bottomBarHeight),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '已选择：${state.currentSelects.length}人',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colours.text_333,
                      ),
                    ),
                  ),
                  TextBtn(
                      text: '提交',
                      backgroundColor: Colours.primary,
                      size: Size(134.w, 44.w),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                      ),
                      radius: 7.w,
                      onPressed: () {
                        Get.dialog(
                          ConfirmDialog(
                            onConfirm: () async {
                              Get.back(result: state.currentSelects);
                            },
                            content: '确定更新辅助人处理本次任务吗',
                          ),
                        );
                      }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget getHeadWidget(MainResponseEntity? entity, int index) {
    List<MainResponseMember> list = entity?.memberList ?? [];
    return Obx(() {
      return ExpandableNotifier(
          initialExpanded: index == 0,
          child: ScrollOnExpand(
            scrollOnExpand: false,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  alignment: Alignment.topCenter,
                  tapBodyToCollapse: false,
                  iconPadding: EdgeInsets.only(right: 24.w),
                  hasIcon: false),
              header: logic.isDeviceBelong(entity)
                  ? SizedBox()
                  : Container(
                      height: 40.w,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Text(
                            '${entity?.groupName} ${entity?.memberList?.length}人',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colours.text_999,
                            ),
                          ),
                          const Spacer(),
                          CustomExpandableIcon(),
                        ],
                      ),
                    ),
              collapsed: SizedBox(),
              expanded: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    for (var e in list)
                      Column(
                        children: [
                          InkWell(
                            onTap: () => logic.operateSelectData(e),
                            child: MemberItemWidget(e.username ?? '', e.phone ?? '', logic.isSelect(e)),
                          ),
                          SizedBox(height: 10.w)
                        ],
                      ),
                  ],
                ),
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
    });
  }

  Widget buildBody(PageStatus pageStatus) {
    if (pageStatus == PageStatus.success) {
      return Obx(() {
        return ListView.separated(
          itemBuilder: (context, index) {
            MainResponseEntity? group;
            if (index <= state.groupList.length - 1) {
              group = state.groupList[index];
            }
            return state.showMore.value && group == null
                ? InkWell(
                    onTap: logic.showMore,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '展开其他维保组成员',
                        style: TextStyle(
                          color: state.otherGroupList.isNotEmpty ? Colours.primary : Colours.text_ccc,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  )
                : Container(
                    child: getHeadWidget(group, index),
                  );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.w),
          itemCount: state.groupList.length + (state.showMore.value ? 1 : 0),
        );
      });
    } else if (pageStatus == PageStatus.error) {
      return ErrorPage();
    } else if (pageStatus == PageStatus.loading) {
      return CenterLoading();
    } else {
      return EmptyPage();
    }
  }
}

class MemberItemWidget extends StatelessWidget {
  final String name;
  final String number;
  final bool checked;

  MemberItemWidget(this.name, this.number, this.checked, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      height: 57.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 22.w,
            height: 22.w,
            child: Checkbox(
              value: checked,
              onChanged: null,
            ),
          ),
          SizedBox(width: 13.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colours.text_333,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                number,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Colours.text_ccc,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
