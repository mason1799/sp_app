import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/fix_order_process_entity.dart';
import 'package:konesp/entity/regular_order_process_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/photo_preview.dart';
import 'package:konesp/widget/title_bar.dart';

import 'process_logic.dart';

class ProcessPage extends StatelessWidget {
  final logic = Get.find<ProcessLogic>();
  final state = Get.find<ProcessLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar(title: '工作进度'),
      body: GetBuilder<ProcessLogic>(
        builder: (_) => AdvanceRefreshListView(
          pageStatus: state.pageStatus,
          onRefresh: () => logic.pull(),
          padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w, bottom: ScreenUtil().bottomBarHeight),
          itemBuilder: (context, index) => state.type == 0
              ? _buildItemOfRegular(state.regularRecords![index], index == 0, index + 1 == state.regularRecords!.length, index)
              : _buildItemOfFix(state.fixRecords![index], index == 0, index + 1 == state.fixRecords!.length, index),
          itemCount: state.type == 0 ? (state.regularRecords?.length ?? 0) : (state.fixRecords?.length ?? 0),
        ),
      ),
    );
  }

  Widget _buildItemOfRegular(RegularOrderProcessEntity data, bool isFirst, bool isLast, int index) {
    String content = '${data.username ?? ''}${logic.getPhone(data.phone)}${logic.getStateStr(data)}';
    if (ObjectUtil.isNotEmpty(data.location)) {
      content += '\n${logic.getStateStr(data)}地址：${data.location}';
    }
    return IntrinsicHeight(
      child: Stack(
        children: [
          Visibility(
              visible: !isFirst,
              child: Container(
                width: 20.w,
                height: 10.w,
                alignment: Alignment.center,
                child: VerticalDivider(
                  color: Colours.primary,
                  width: 1.w,
                ),
              )),
          Visibility(
              visible: !isLast,
              child: Container(
                width: 20.w,
                padding: EdgeInsets.only(top: 10.w),
                alignment: Alignment.center,
                child: VerticalDivider(
                  color: Colours.primary,
                  width: 1.w,
                ),
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: Center(
                              child: Container(
                                width: isFirst ? 12.w : 8.w,
                                height: isFirst ? 12.w : 8.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                                  color: Colours.primary,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Text(
                              '【${logic.getStateStr(data)}】${ObjectUtil.isNotEmpty(data.createTime) ? DateUtil.formatDateStr(data.createTime!, format: DateFormats.ymdhm) : ''}',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colours.text_333,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.w, top: 5.w),
                        child: Text(
                          content,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_999,
                          ),
                        ),
                      ),
                      if ((data.type == 1 && ObjectUtil.isNotEmpty(data.startImage)) || (data.type == 3 && ObjectUtil.isNotEmpty(data.endImage)))
                        Padding(
                          padding: EdgeInsets.only(left: 30.w, top: 10.w),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => PhotoPreview(
                                    ossKey: data.type == 1 ? data.startImage! : data.endImage!,
                                    title: data.type == 1 ? '签到照片' : '签退照片',
                                  ),
                                ),
                                child: LoadImage(
                                  data.type == 1 ? data.startImage! : data.endImage!,
                                  width: 80.w,
                                  height: 80.w,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.w),
                                    bottomRight: Radius.circular(4.w),
                                  ),
                                  color: Colours.primary,
                                ),
                                padding: EdgeInsets.only(top: 3.w, bottom: 3.w, left: 7.w, right: 7.w),
                                child: Text(
                                  '${logic.getStateStr(data)}照片',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else if ([6, 9].contains(data.type))
                        Padding(
                          padding: EdgeInsets.only(left: 30.w, top: 5.w),
                          child: Text(
                            '审核意见：${data.approvalReason ?? ''}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colours.text_999,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemOfFix(FixOrderProcessEntity data, bool isFirst, bool isLast, int index) {
    String content = data.content ?? '';
    content = content.replaceAll('<br/>', '\n');
    return IntrinsicHeight(
      child: Stack(
        children: [
          Visibility(
              visible: !isFirst,
              child: Container(
                width: 20.w,
                height: 10.w,
                alignment: Alignment.center,
                child: VerticalDivider(
                  color: Colours.primary,
                  width: 1.w,
                ),
              )),
          Visibility(
              visible: !isLast,
              child: Container(
                width: 20.w,
                padding: EdgeInsets.only(top: 10.w),
                alignment: Alignment.center,
                child: VerticalDivider(
                  color: Colours.primary,
                  width: 1.w,
                ),
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: Center(
                              child: Container(
                                width: isFirst ? 12.w : 8.w,
                                height: isFirst ? 12.w : 8.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                                  color: Colours.primary,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Text(
                              '【${data.flowTypeContent ?? ''}】${ObjectUtil.isNotEmpty(data.flowTime) ? DateUtil.formatDateStr(data.flowTime!, format: DateFormats.ymdhm) : ''}',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colours.text_333,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.w, top: 5.w),
                        child: Text(
                          content,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_999,
                          ),
                        ),
                      ),
                      if ((data.flowType == 4 || data.flowType == 7) && ObjectUtil.isNotEmpty(data.imageUrl))
                        Padding(
                          padding: EdgeInsets.only(left: 30.w, top: 10.w),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => PhotoPreview(
                                        ossKey: data.imageUrl!,
                                        title: data.flowType == 4 ? '签到照片' : '签退照片',
                                      ),
                                    );
                                  },
                                  child: LoadImage(
                                    data.imageUrl!,
                                    width: 80.w,
                                    height: 80.w,
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.w),
                                    bottomRight: Radius.circular(4.w),
                                  ),
                                  color: Colours.primary,
                                ),
                                padding: EdgeInsets.only(top: 3.w, bottom: 3.w, left: 7.w, right: 7.w),
                                child: Text(
                                  '${data.flowType == 4 ? '签到' : '签退'}照片',
                                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
