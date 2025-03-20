import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';

import 'comment_logic.dart';

class CommentPage extends StatelessWidget {
  final logic = Get.find<CommentLogic>();
  final state = Get.find<CommentLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TitleBar(
          title: state.type == 0 ? '安全员签字' : '客户签字',
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
              decoration: BoxDecoration(color: Colors.white),
              child: GetBuilder<CommentLogic>(
                  id: 'signatureKey',
                  builder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: SizedBox(width: 5.w),
                                  ),
                                  TextSpan(
                                    text: '手写签字',
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            InkWell(
                              onTap: logic.toSignatureBoard,
                              child: Container(
                                height: 25.w,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.w),
                                  border: Border.all(
                                    width: 0.5.w,
                                    color: Colours.text_ccc,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  ObjectUtil.isEmpty(state.signatureKey) ? '添加签字' : '重置签字',
                                  style: TextStyle(
                                    color: Colours.primary,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        if (ObjectUtil.isNotEmpty(state.signatureKey))
                          LoadImage(
                            state.signatureKey!,
                            width: 60.w,
                            height: 60.w,
                            borderRadius: BorderRadius.circular(4.w),
                            border: Border.all(
                              color: Colours.text_ccc,
                              width: 0.5.w,
                            ),
                          )
                        else
                          SizedBox(
                            width: 60.w,
                            height: 60.w,
                          ),
                        if (state.type > 0)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 0.5.w,
                                width: double.infinity,
                                color: Colours.bg,
                                margin: EdgeInsets.symmetric(vertical: 10.w),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(width: 5.w),
                                    ),
                                    TextSpan(
                                      text: '审核人',
                                      style: TextStyle(
                                        color: Colours.text_333,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: state.approveOperatorController,
                                focusNode: state.approveOperatorFocusNode,
                                onEditingComplete: () => Get.focusScope?.unfocus(),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: '请输入',
                                  hintStyle: TextStyle(
                                    color: Colours.text_999,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        Container(
                          height: 0.5.w,
                          width: double.infinity,
                          color: Colours.bg,
                          margin: EdgeInsets.symmetric(vertical: 10.w),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                            children: [
                              WidgetSpan(
                                child: SizedBox(width: 5.w),
                              ),
                              TextSpan(
                                text: '审核意见',
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state.type == 0)
                          TextField(
                            controller: state.approveAdviceController,
                            focusNode: state.approveAdviceFocusNode,
                            keyboardType: TextInputType.multiline,
                            onEditingComplete: () => Get.focusScope?.unfocus(),
                            textInputAction: TextInputAction.done,
                            maxLines: 4,
                            maxLength: 50,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: '请输入',
                              hintStyle: TextStyle(
                                color: Colours.text_999,
                                fontSize: 14.sp,
                              ),
                            ),
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 14.sp,
                            ),
                          )
                        else
                          GetBuilder<CommentLogic>(
                            id: 'radio',
                            builder: (_) {
                              return Padding(
                                padding: EdgeInsets.only(top: 10.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                    state.levels.length,
                                    (index) => Row(
                                      children: [
                                        Radio(
                                          value: index + 1,
                                          groupValue: state.selectedLevel,
                                          onChanged: (value) => logic.checkRadio(value),
                                        ),
                                        InkWell(
                                          onTap: () => logic.checkRadio(index + 1),
                                          child: Text(
                                            state.levels[index],
                                            style: TextStyle(
                                              color: Colours.text_333,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  }),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 12.w, bottom: 12.w + ScreenUtil().bottomBarHeight),
              alignment: Alignment.center,
              child: TextBtn(
                onPressed: logic.confirm,
                size: Size(double.infinity, 44.w),
                backgroundColor: Colours.primary,
                radius: 7.w,
                text: '确认',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
