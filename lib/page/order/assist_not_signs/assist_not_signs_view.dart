import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/widget/title_bar.dart';

import 'assist_not_signs_logic.dart';

class AssistNotSignsPage extends StatelessWidget {
  final logic = Get.find<AssistNotSignsLogic>();
  final state = Get.find<AssistNotSignsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '辅助人员'),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10.w),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            height: 50.w,
            padding: EdgeInsets.only(left: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    state.list[index].username ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colours.text_333,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => logic.toSign(state.list[index]),
                  child: Container(
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    alignment: Alignment.center,
                    child: Text(
                      '签字',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colours.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => divider,
        itemCount: state.list.length,
      ),
    );
  }
}
