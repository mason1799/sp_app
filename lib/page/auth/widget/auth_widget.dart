import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/widget/load_image.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.focusScope?.unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: LoadSvgImage(
                  'bg_big',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 246.w,
                    padding: EdgeInsets.only(left: 37.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '欢迎使用\n维保管理系统',
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 45.w),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 37.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
                        color: Colors.white,
                      ),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform.translate(
                                offset: Offset(37.5.w, 0),
                                child: LoadSvgImage(
                                  'bg_bottom',
                                  width: 247.w,
                                ),
                              ),
                            ],
                          ),
                          child,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
