import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/page/order/widget/tip_item.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';

import 'over_time_logic.dart';

class OverTimePage extends StatelessWidget {
  final logic = Get.find<OverTimeLogic>();
  final state = Get.find<OverTimeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '工单超期'),
      body: Column(
        children: [
          TipItem(
            "调整后${logic.getBeginDate()} 至 ${logic.getEndDate()} 间隔超过${state.entity.timeoutValue ?? ''}天，引起工单超期。如需提前回复工单需要在该时间段内插入一条新工单。",
            icon: 'tip_icon',
          ),
          GetBuilder<OverTimeLogic>(
              id: 'date',
              builder: (_) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.w, bottom: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '插入工单日期',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colours.text_333,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => logic.selectDate(context),
                        child: Row(
                          children: [
                            Text(
                              ObjectUtil.isEmpty(state.selectDate) ? '请选择' : state.selectDate!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colours.text_333,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            LoadSvgImage(
                              'arrow_right',
                              width: 14.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          divider,
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '插入工单模块',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colours.text_333,
                    ),
                  ),
                ),
                GetBuilder<OverTimeLogic>(
                    id: 'items',
                    builder: (_) {
                      return Column(
                        children: state.entity.moduleInfoList?.map((item) {
                              return InkWell(
                                onTap: () => logic.checkedItem(item),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.w),
                                    color: state.selected.contains(item) ? Color(0xFFEEF5FF) : Color(0xffF5F5F5),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 5.w, bottom: 5.w),
                                        child: Text(
                                          item.moduleName ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: state.selected.contains(item) ? Colours.primary : Colours.text_333,
                                          ),
                                        ),
                                      ),
                                      if (state.selected.contains(item))
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            LoadAssetImage(
                                              'horn_icon',
                                              width: 20.w,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(right: 2, bottom: 2),
                                              child: LoadAssetImage(
                                                'correct_icon',
                                                width: 8,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              );
                            }).toList() ??
                            [],
                      );
                    })
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 12.w),
            child: TextBtn(
              text: '插入工单',
              backgroundColor: Colours.primary,
              size: Size(double.infinity, 44.w),
              onPressed: logic.insertOrder,
              radius: 7.w,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
