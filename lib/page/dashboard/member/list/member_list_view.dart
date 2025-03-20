import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/member_data_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/search_widget.dart';
import 'package:konesp/widget/title_bar.dart';

import 'member_list_logic.dart';

class MemberListPage extends StatelessWidget {
  final logic = Get.find<MemberListLogic>();
  final state = Get.find<MemberListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TitleBar(title: '人员管理'),
        body: GetBuilder<MemberListLogic>(
            builder: (_) => AdvanceRefreshListView(
                  pageStatus: state.pageStatus,
                  itemCount: state.items.length + 2,
                  onRefresh: () => logic.pull(),
                  onLoadMore: () => logic.loadMore(),
                  hasMore: state.hasMore,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                        child: SearchWidget(
                          onSearch: logic.search,
                          controller: state.searchController,
                          hintText: '搜索姓名、手机号',
                        ),
                      );
                    }
                    if (index == 1) {
                      return InkWell(
                        onTap: logic.toSelectDepartment,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xffD6EBFF),
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              child: Text(
                                state.selectDepartmentLabel ?? '',
                                style: TextStyle(
                                  color: Color(0xFF2896FF),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    MemberDataEntity member = state.items[index - 2];
                    return InkWell(
                      onTap: () => Get.toNamed(Routes.memberDetail, arguments: {'id': member.id}),
                      child: Container(
                        margin: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                LoadImage(
                                  member.avatar,
                                  holderImg: 'default_avatar',
                                  borderRadius: BorderRadius.circular(20.w),
                                  width: 40.w,
                                  height: 40.w,
                                ),
                                SizedBox(height: 4.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
                                  decoration: BoxDecoration(
                                    color: member.onTheJob == '在职' ? Color(0xff00C77A) : Color(0xffFFB442),
                                    borderRadius: BorderRadius.circular(2.w),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    member.onTheJob ?? '',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(maxWidth: 120.w),
                                        child: Text(
                                          member.username ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      LoadSvgImage(
                                        member.gender == '男' ? 'konesp_man' : 'konesp_woman',
                                        width: 12.w,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        '职务：${member.duty ?? ''}',
                                        style: TextStyle(
                                          color: Colours.text_333,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.w),
                                  Text(
                                    '电话：${member.phone ?? ''}',
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.w),
                                  Text(
                                    '劳动合同：${getDateString(member.contractStartDate) ?? ''} - ${getDateString(member.contractEndDate) ?? ''}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 13.sp,
                                    ),
                                  ),
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
                    );
                  },
                )),
      ),
    );
  }
}

String? getDateString(String? date1) {
  var date = date1?.replaceAll('-', '/');

  if (date == null) return date;
  if (date.length >= 10) return date.substring(0, 10);
  return date;
}
