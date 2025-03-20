import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/custom_textfield.dart';
import 'package:konesp/widget/extension.dart';
import 'package:konesp/widget/load_image.dart';

import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  final logic = Get.find<SearchLogic>();
  final state = Get.find<SearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: GetBuilder<SearchLogic>(
            builder: (_) => SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15.w, top: 10.w, bottom: 10.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            controller: state.inputController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            hintText: state.type == 0 ? '搜索项目/设备' : '搜索工单',
                            hintColor: Colours.text_666,
                            textColor: Colours.text_333,
                            constraints: BoxConstraints(maxHeight: 34.w),
                            prefixIcon: Container(
                              height: 30.w,
                              width: 30.w,
                              alignment: Alignment.center,
                              child: LoadAssetImage(
                                'search',
                                width: 15.w,
                                color: Colours.text_999,
                              ),
                            ),
                            suffixIcon: LoadSvgImage(
                              'clear_input',
                              width: 15.w,
                              color: Color(0xFFABABAB),
                            ),
                            padding: EdgeInsets.zero,
                            onEditingComplete: logic.toSearchText,
                            backgroundColor: Colours.bg,
                            borderRadius: BorderRadius.circular(18.w),
                            textInputAction: TextInputAction.search,
                          ),
                        ),
                        InkWell(
                          onTap: Get.back,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            height: 34.w,
                            alignment: Alignment.center,
                            child: Text(
                              '取消',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (ObjectUtil.isNotEmpty(state.historyList))
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, bottom: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '历史搜索',
                                style: TextStyle(
                                  color: Colours.text_333,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: logic.clearHistory,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.w),
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colours.text_999,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.w),
                          Container(
                            padding: EdgeInsets.only(right: 15.w),
                            width: double.infinity,
                            child: Wrap(
                              spacing: 10.w,
                              runSpacing: 10.w,
                              children: List.generate(
                                state.historyList.length,
                                (index) => InkWell(
                                  onTap: () => logic.toSearchItem(state.historyList[index]),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
                                        alignment: Alignment.topLeft,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(maxWidth: 1.sw - 46.w),
                                          child: Text(
                                            state.historyList[index].fixAutoLines(),
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colours.bg,
                                          borderRadius: BorderRadius.circular(8.w),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
