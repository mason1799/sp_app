import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/task/my_task/widget/task_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/search_placehold.dart';

import 'search_task_result_logic.dart';

class SearchTaskResultPage extends StatelessWidget {
  SearchTaskResultPage({Key? key}) : super(key: key);

  final logic = Get.find<SearchTaskResultLogic>();
  final state = Get.find<SearchTaskResultLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 10.w, bottom: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchPlacehold(
                          onSearch: logic.toSearch,
                          hintText: state.keyword,
                          hintColor: Colours.text_333,
                        ),
                      ),
                      InkWell(
                        onTap: Get.back,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 34.w,
                          alignment: Alignment.center,
                          child: Text(
                            '取消',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GetBuilder<SearchTaskResultLogic>(
                    id: 'search_result',
                    builder: (_) {
                      if (state.pageStatus == PageStatus.success) {
                        // 搜索结果页不用侧滑操作工单，所以onResult没赋值进去
                        return ListView.separated(
                          padding: EdgeInsets.all(10.w),
                          itemBuilder: (context, index) => TaskItem(
                            entity: state.items![index],
                            controller: logic,
                          ),
                          itemCount: state.items?.length ?? 0,
                          separatorBuilder: (context, index) => SizedBox(height: 10.w),
                        );
                      } else if (state.pageStatus == PageStatus.loading) {
                        return CenterLoading();
                      } else if (state.pageStatus == PageStatus.empty) {
                        return EmptyPage(msg: '未找到相关内容');
                      } else {
                        return ErrorPage();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}