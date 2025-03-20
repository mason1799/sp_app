import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'signature_board_logic.dart';

class SignatureBoardPage extends StatelessWidget {
  final logic = Get.find<SignatureBoardLogic>();
  final state = Get.find<SignatureBoardLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: SfSignaturePad(
                key: state.signaturePadKey,
                backgroundColor: Colors.white,
                onDrawEnd: logic.onDrawEnd,
                minimumStrokeWidth: 5,
              ),
            ),
            Container(
              color: Colours.bg,
              width: 0.5.w,
            ),
            Stack(
              children: [
                Container(
                  width: 50,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: Get.back,
                        child: Container(
                          width: double.infinity,
                          height: 120,
                          child: Center(
                            child: Transform.rotate(
                              angle: pi / 2,
                              child: LoadSvgImage(
                                'back_arrow',
                                height: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: logic.clear,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: Text(
                              '清除',
                              style: TextStyle(
                                color: Colours.primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: logic.confirm,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: Text(
                              '提交',
                              style: TextStyle(
                                color: Colours.primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 50.w,
                    alignment: Alignment.center,
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: Text(
                        '签字',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
