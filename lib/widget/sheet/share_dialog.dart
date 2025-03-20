import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/toast_util.dart';
import 'package:konesp/widget/text_btn.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({
    required this.isRegularOrder,
    required this.orderId,
  });

  final bool isRegularOrder;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    String _url =
        '${Get.find<BuildEnvironment>().baseUrl}/web/#/${isRegularOrder ? 'h5-sign' : 'h5-fault-repair'}?orderId=$orderId&tenantId=${StoreLogic.to.getUser()!.tenantId!}';
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Container(
              width: 1.sw * 0.75,
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '签字链接创建成功',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Container(
                      height: 30.w,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _url,
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 13.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        border: Border.all(
                          color: Colours.bg,
                          width: 1.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      '您可以将生成的签字链接，通过微信、短信或其他通讯方式发送给客户，客户收到链接后，打开链接即可完成签字',
                      style: TextStyle(
                        color: Colours.text_666,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 20.w),
                    TextBtn(
                      text: '复制链接',
                      radius: 7.w,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                      backgroundColor: Colours.primary,
                      size: Size(double.infinity, 44.w),
                      onPressed: () {
                        Get.back();
                        Clipboard.setData(ClipboardData(text: _url));
                        Toast.show('复制成功');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: Get.back,
              child: Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colours.text_ccc,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close_rounded,
                  size: 15.w,
                  color: Colours.text_666,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
