import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/timeline_util.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/red_badge.dart';
import 'package:konesp/widget/title_bar.dart';

import 'message_logic.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MessageLogic());
    final state = Get.find<MessageLogic>().state;

    return Scaffold(
      appBar: TitleBar(
        isBack: false,
        title: '消息',
        actionName: '全部已读',
        onActionPressed: logic.readAll,
      ),
      body: GetBuilder<MessageLogic>(
        builder: (logic) => AdvanceRefreshListView(
          onRefresh: () => logic.pull(),
          pageStatus: state.pageStatus,
          itemBuilder: (context, index) => MessageCell(index: index),
          itemCount: state.items.length,
        ),
      ),
    );
  }
}

class MessageCell extends StatelessWidget {
  final int index;

  const MessageCell({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MessageLogic>();
    final entity = logic.state.items[index];
    return InkWell(
      onTap: () => logic.toItem(entity.type!),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: index > 0 ? Border(top: BorderSide(color: Colours.bg, width: 0.5.w)) : null,
        ),
        child: Row(
          children: [
            if (entity.type == 0)
              MessageCellIcon(
                background: Color(0xFF94AADA),
                icon: 'alert_message_type',
              )
            else if (entity.type == 1)
              MessageCellIcon(
                background: Color(0xFF64C9B4),
                icon: 'regular_message_type',
              )
            else
              MessageCellIcon(
                background: Color(0xFFE08752),
                icon: 'fix_message_type',
              ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (entity.type == 0)
                    Text(
                      '系统消息',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    )
                  else if (entity.type == 1)
                    Text(
                      '保养通知',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    )
                  else
                    Text(
                      '故障报修',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                  SizedBox(height: 5.w),
                  Text(
                    entity.title ?? '',
                    style: TextStyle(
                      color: Colours.text_999,
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(width: 5.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (ObjectUtil.isNotEmpty(entity.time))
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.w),
                    child: Text(
                      TimelineUtil.formatByDateTime(
                        DateUtil.getDateTimeByMs(entity.time!),
                        locale: 'zh',
                        dayFormat: DayFormat.Common,
                      ),
                      style: TextStyle(
                        color: Colours.text_999,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                RedBadge(number: entity.count!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageCellIcon extends StatelessWidget {
  final Color background;
  final String icon;

  const MessageCellIcon({
    super.key,
    required this.background,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: background,
      ),
      width: 44.w,
      height: 44.w,
      child: Center(
        child: LoadSvgImage(
          icon,
          width: 20.w,
        ),
      ),
    );
  }
}
