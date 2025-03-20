import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/version_update_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put<MineLogic>(MineLogic());
    final state = Get.find<MineLogic>().state;

    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 1) {
          logic.query();
        }
      },
      key: const Key('MinePage'),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Material(
          color: Colours.bg,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                  child: Container(
                    height: 105.w,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Obx(() {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed(Routes.profile),
                            child: LoadImage(
                              StoreLogic.to.getUser()?.avatar ?? '',
                              width: 65.w,
                              height: 65.w,
                              borderRadius: BorderRadius.circular(35.w),
                              holderImg: 'default_avatar',
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      StoreLogic.to.getUser()?.username ?? '',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colours.text_333,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    TextBtn(
                                      size: Size(40.w, 24.w),
                                      radius: 12.w,
                                      onPressed: () => Get.toNamed(Routes.profile),
                                      backgroundColor: Colours.text_ccc.withOpacity(0.4),
                                      text: '编辑',
                                      style: TextStyle(
                                        color: Colours.text_333,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.w),
                                Text(
                                  '${StoreLogic.to.getUser()?.organName ?? ''}·${StoreLogic.to.getUser()?.duty ?? ''}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colours.text_333,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InkwellCell(title: '个人信息', onTap: () => Get.toNamed(Routes.profile)),
                      divider,
                      _InkwellCell(title: '重置密码', onTap: () => Get.toNamed(Routes.resetPassword)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => VersionUpdateUtil.check(logic, needVersionToast: true, needShowProgress: true),
                        child: Container(
                          height: 60.w,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '版本更新',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colours.text_333,
                                ),
                              ),
                              const Spacer(),
                              FutureBuilder<PackageInfo>(
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data?.version ?? '',
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 13.sp,
                                      ),
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                                future: PackageInfo.fromPlatform(),
                              ),
                              GetBuilder<MineLogic>(
                                  id: 'version',
                                  builder: (logic) {
                                    if (state.isNeedUpdate) {
                                      return Container(
                                        margin: EdgeInsets.only(left: 5.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        width: 6.w,
                                        height: 6.w,
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }),
                              SizedBox(width: 10.w),
                              LoadSvgImage(
                                'arrow_right',
                                width: 14.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                      divider,
                      InkWell(
                        onTap: logic.clearCache,
                        child: Container(
                          height: 60.w,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: GetBuilder<MineLogic>(
                            id: 'cache',
                            builder: (_) => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '清除缓存',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colours.text_333,
                                  ),
                                ),
                                const Spacer(),
                                if (ObjectUtil.isNotEmpty(state.cacheSize))
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Text(
                                      state.cacheSize!,
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                LoadSvgImage(
                                  'arrow_right',
                                  width: 14.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      divider,
                      Container(
                        height: 60.w,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '拍照保存到本地',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colours.text_333,
                              ),
                            ),
                            const Spacer(),
                            GetBuilder<MineLogic>(
                              id: 'saveInAlbum',
                              builder: (_) => Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  activeColor: Colours.primary,
                                  value: GetStorage().read<bool>(Constant.keySaveAlbum) ?? false,
                                  onChanged: (value) => logic.toChanged(value),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InkwellCell(title: '帮助中心', onTap: logic.toHelp),
                      divider,
                      _InkwellCell(title: '用户服务协议', onTap: logic.toUserProtocol),
                      divider,
                      _InkwellCell(title: '个人信息处理规则', onTap: logic.toRuleProtocol),
                    ],
                  ),
                ),
                SizedBox(height: 10.w),
                TextBtn(
                  onPressed: logic.logout,
                  size: Size(double.infinity, 45.w),
                  text: '退出登录',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InkwellCell extends StatelessWidget {
  const _InkwellCell({
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colours.text_333,
              ),
            ),
            const Spacer(),
            LoadSvgImage(
              'arrow_right',
              width: 14.w,
            ),
          ],
        ),
      ),
    );
  }
}
