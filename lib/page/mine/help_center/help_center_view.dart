import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'help_center_logic.dart';

class HelpCenterPage extends StatelessWidget {
  final logic = Get.find<HelpCenterLogic>();
  final state = Get.find<HelpCenterLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '帮助中心'),
      body: GetBuilder<HelpCenterLogic>(builder: (_) {
        if (state.pageStatus == PageStatus.success) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 10.w),
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () => logic.toVideo(state.list![index].url),
                child: Container(
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.list![index].name ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_333,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
            itemCount: state.list!.length,
            separatorBuilder: (BuildContext context, int index) => divider,
          );
        } else if (state.pageStatus == PageStatus.error) {
          return ErrorPage();
        } else if (state.pageStatus == PageStatus.empty) {
          return EmptyPage();
        } else {
          return CenterLoading();
        }
      }),
    );
  }
}
