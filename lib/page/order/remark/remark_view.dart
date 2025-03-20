import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/nine_grid.dart';
import 'package:konesp/widget/title_bar.dart';

import 'remark_logic.dart';

class RemarkPage extends StatelessWidget {
  final logic = Get.find<RemarkLogic>();
  final state = Get.find<RemarkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TitleBar(
          title: '备注',
          actionWidget: state.enableEdit
              ? TextButton(
                  onPressed: logic.toSave,
                  child: Text(
                    '保存',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colours.primary,
                    ),
                  ),
                )
              : SizedBox(),
        ),
        body: GetBuilder<RemarkLogic>(
          builder: (_) {
            return Container(
              margin: EdgeInsets.only(top: 10.w),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 16.w, right: 15.w, top: 10.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '备注内容',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colours.text_666,
                          ),
                        ),
                        SizedBox(height: 10.w),
                        if (state.enableEdit)
                          TextField(
                            controller: state.textController,
                            focusNode: state.focusNode,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colours.text_333,
                            ),
                            maxLength: 50,
                            maxLines: 2,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: '请输入备注内容',
                              hintStyle: TextStyle(
                                color: Colours.text_ccc,
                                fontSize: 14.sp,
                              ),
                            ),
                          )
                        else
                          Text(
                            state.content ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colours.text_333,
                            ),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.w),
                  divider,
                  GetBuilder<RemarkLogic>(
                      id: 'images',
                      builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, top: 10.w, bottom: 10.w),
                              child: Text(
                                '备注图片(${state.imageList.length}/3)',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colours.text_666,
                                ),
                              ),
                            ),
                            !state.enableEdit && ObjectUtil.isEmpty(state.imageList)
                                ? Container(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 15.w),
                                    width: double.infinity,
                                    child: Text(
                                      '无',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colours.text_333,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 15.w),
                                    child: NineGrid(
                                      state.imageList,
                                      enableEdit: state.enableEdit,
                                      onAdd: (newItems) => logic.onAddItems(newItems),
                                      onDelete: (newItems) => logic.onDeleteItems(newItems),
                                    ),
                                  ),
                          ],
                        );
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
