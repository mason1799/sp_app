import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/main_response_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/search_widget.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';

import 'regular_select_member_logic.dart';

class RegularSelectMemberPage extends StatelessWidget {
  final logic = Get.find<RegularSelectMemberLogic>();
  final state = Get.find<RegularSelectMemberLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(title: '选择主响应人'),
      body: GetBuilder<RegularSelectMemberLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                child: SearchWidget(
                  controller: state.searchController,
                  onSearch: logic.search,
                  hintText: '搜索姓名或手机号',
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(10.w),
                  itemBuilder: (context, index) {
                    MainResponseEntity _groupEntity = state.items![index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 30.w,
                          padding: EdgeInsets.only(left: 10.w),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${_groupEntity.groupName} (${_groupEntity.memberList?.length ?? 0}人)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colours.text_666,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        ListView.separated(
                          itemBuilder: (context, index) {
                            MainResponseMember _childEntity = _groupEntity.memberList![index];
                            return Container(
                              height: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.w),
                                color: Colors.white,
                              ),
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () => logic.toSelect(
                                    userId: _childEntity.id!,
                                    userName: _childEntity.username!,
                                    groupCode: _groupEntity.groupCode!,
                                    groupName: _groupEntity.groupName!),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: state.selectedList.indexWhere((item) => item.selectedUserId == _childEntity.id) > -1,
                                      onChanged: (value) => logic.toSelect(
                                          userId: _childEntity.id!,
                                          userName: _childEntity.username!,
                                          groupCode: _groupEntity.groupCode!,
                                          groupName: _groupEntity.groupName!),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _childEntity.username ?? '',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colours.text_333,
                                            ),
                                          ),
                                          SizedBox(height: 3.w),
                                          Text(
                                            _childEntity.phone ?? '',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colours.text_999,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10.w),
                          itemCount: _groupEntity.memberList?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.w),
                  itemCount: state.items?.length ?? 0,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 12.w, bottom: 12.w + ScreenUtil().bottomBarHeight),
                alignment: Alignment.center,
                child: TextBtn(
                  onPressed: logic.toSubmit,
                  size: Size(double.infinity, 44.w),
                  backgroundColor: Colours.primary,
                  radius: 7.w,
                  text: '确认',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                ),
              ),
            ],
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
}
