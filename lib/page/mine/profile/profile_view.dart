import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/photo_preview.dart';
import 'package:konesp/widget/title_bar.dart';

import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  final logic = Get.find<ProfileLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '个人信息'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => logic.toUpload(key: 'avatar', isCrop: true),
                        child: Container(
                          height: 60.w,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              Text(
                                '头像',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colours.text_333,
                                ),
                              ),
                              const Spacer(),
                              LoadImage(
                                StoreLogic.to.getUser()!.avatar ?? '',
                                width: 30.w,
                                height: 30.w,
                                borderRadius: BorderRadius.circular(15.w),
                                holderImg: 'default_avatar',
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: LoadSvgImage(
                                  'arrow_right',
                                  width: 14.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      divider,
                      _Cell(
                        title: '姓名',
                        value: StoreLogic.to.getUser()!.username,
                      ),
                      divider,
                      _Cell(
                        title: '工号',
                        value: StoreLogic.to.getUser()!.employeeCode,
                      ),
                      divider,
                      _Cell(
                        title: '电话',
                        value: StoreLogic.to.getUser()!.phone,
                      ),
                      divider,
                      _Cell(
                        title: '邮箱',
                        value: StoreLogic.to.getUser()!.email,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.w),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Cell(
                        title: '部门',
                        value: StoreLogic.to.getUser()!.organName,
                      ),
                      divider,
                      _Cell(
                        title: '职务',
                        value: StoreLogic.to.getUser()!.duty,
                      ),
                      divider,
                      _Cell(
                        title: '在职状态',
                        value: StoreLogic.to.getUser()!.onTheJob,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.w),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Cell(
                        title: '操作证号',
                        value: StoreLogic.to.getUser()!.operationCertificateCode,
                        onTap: logic.toEditOperationCertificateCode,
                      ),
                      divider,
                      InkWell(
                        onTap: () => logic.toUpload(key: 'operationCertificate'),
                        child: Container(
                          height: 60.w,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              Text(
                                '操作证照片',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colours.text_333,
                                ),
                              ),
                              const Spacer(),
                              if (ObjectUtil.isNotEmpty(StoreLogic.to.getUser()!.operationCertificate))
                                InkWell(
                                  onTap: () => Get.to(() => PhotoPreview(ossKey: StoreLogic.to.getUser()!.operationCertificate!, title: '操作证照片')),
                                  child: LoadImage(
                                    StoreLogic.to.getUser()!.operationCertificate!,
                                    width: 40.w,
                                    height: 40.w,
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                )
                              else
                                Text(
                                  '请上传',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colours.text_999,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: LoadSvgImage(
                                  'arrow_right',
                                  width: 14.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.title,
    this.value,
    this.onTap,
  });

  final String title;
  final String? value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colours.text_333,
              ),
            ),
            if (onTap == null)
              Expanded(
                child: Text(
                  value ?? '',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colours.text_333,
                    fontSize: 14.sp,
                  ),
                ),
              )
            else
              Expanded(
                child: ObjectUtil.isNotEmpty(value)
                    ? Text(
                        value!,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 14.sp,
                        ),
                      )
                    : Text(
                        '请输入',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colours.text_999,
                          fontSize: 14.sp,
                        ),
                      ),
              ),
            if (onTap != null)
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: LoadSvgImage(
                  'arrow_right',
                  width: 14.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
