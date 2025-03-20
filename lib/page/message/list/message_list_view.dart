import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/timeline_util.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';

import 'message_list_logic.dart';

class MessageListPage extends StatelessWidget {
  final logic = Get.put(MessageListLogic());
  final state = Get.find<MessageListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: _title()),
      body: GetBuilder<MessageListLogic>(
        builder: (_) => AdvanceRefreshListView(
          pageStatus: state.pageStatus,
          itemCount: state.items.length,
          onRefresh: logic.pull,
          onLoadMore: logic.loadMore,
          hasMore: state.hasMore,
          itemBuilder: (context, index) {
            final entity = state.items[index];
            return Padding(
              padding: EdgeInsets.only(top: index > 0 ? 30.w : 15.w, left: 15.w, right: 15.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TimelineUtil.formatByDateTime(
                      DateUtil.getDateTimeByMs(entity.time!),
                      locale: 'zh',
                      dayFormat: DayFormat.Common,
                    ),
                    style: TextStyle(
                      color: Colours.text_666,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.w),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                entity.title!,
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.w),
                              Text(
                                entity.content ?? '',
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colours.bg,
                          height: 0.5.w,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                        ),
                        if (logic.state.type != 0)
                          TextBtn(
                            text: '查看详情',
                            size: Size(double.infinity, 50.w),
                            style: TextStyle(
                              color: Colours.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            onPressed: () => logic.viewDetail(entity.bizId!),
                          )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _title() {
    if (state.type == 0) {
      return '系统消息';
    } else if (state.type == 1) {
      return '保养通知';
    } else {
      return '故障报修';
    }
  }
}
