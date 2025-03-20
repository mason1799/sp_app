import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/my_bottom_bar.dart';

import 'main_logic.dart';

class MainPage extends StatelessWidget {
  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: state.pageController,
        itemCount: state.tabPage.length,
        itemBuilder: (context, index) => state.tabPage[index],
      ),
      bottomNavigationBar: GetBuilder<MainLogic>(
          id: 'bottomBar',
          builder: (_) {
            return MyBottomBar(
              items: state.tabBar,
              iconSize: 20.w,
              textFontSize: 10.sp,
              specialIndex: 2,
              currentIndex: state.selectedIndex,
              textFocusColor: Colours.primary,
              textUnfocusColor: Colours.text_999,
              onTap: (int index) => logic.selectToIndex(index),
            );
          }),
    );
  }
}