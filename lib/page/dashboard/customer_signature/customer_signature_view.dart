import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/widget/custom_tab_indicator.dart';
import 'package:konesp/widget/keep_alive_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/red_badge.dart';
import 'package:konesp/widget/title_bar.dart';

import 'customer_signature_logic.dart';
import 'fix/fix_list_view.dart';
import 'regular/regular_list_view.dart';

class CustomerSignaturePage extends StatelessWidget {
  final logic = Get.find<CustomerSignatureLogic>();
  final state = Get.find<CustomerSignatureLogic>().state;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TitleBar(title: '客户签字'),
        body: Column(
          children: [
            GetBuilder<CustomerSignatureLogic>(
                id: 'range',
                builder: (_) {
                  return Container(
                    color: Colors.white,
                    height: 40.w,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () => logic.onSelectRange(context),
                            child: Text(
                              '${DateUtil.formatDate(state.selectDateRange[0], format: DateFormats.ymd)} - ${DateUtil.formatDate(state.selectDateRange[1], format: DateFormats.ymd)}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colours.text_333,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: LoadSvgImage(
                              'arrow_right',
                              width: 10.w,
                              color: Colours.text_333,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            GetBuilder<CustomerSignatureLogic>(
                id: 'tabbar',
                builder: (_) {
                  return Row(
                    children: [
                      Container(
                        height: 32.w,
                        margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
                        child: TabBar(
                          labelColor: Colours.text_333,
                          indicatorColor: Colours.primary,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: CustomTabIndicator(
                            width: 20.w,
                            borderSide: BorderSide(
                              width: 3.w,
                              color: Colours.primary,
                            ),
                          ),
                          isScrollable: true,
                          labelStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colours.text_333,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_333,
                          ),
                          unselectedLabelColor: Colours.text_666,
                          dividerHeight: 0,
                          tabs: state.tabs.map((element) {
                            if (element == '例行保养') {
                              return CustomBadgeTab(
                                number: state.regularNumber,
                                text: element,
                              );
                            } else {
                              return CustomBadgeTab(
                                number: state.fixNumber,
                                text: element,
                              );
                            }
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }),
            Expanded(
              child: TabBarView(
                children: [
                  keepAlivePage(RegularListPage()),
                  keepAlivePage(FixListPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
