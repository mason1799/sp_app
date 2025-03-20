import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/entity/check_update_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionUpdateUtil {
  /*版本更新检测
  needVersionToast：是否需要弹出toast提示
  needShowProgress：是否需要弹出loading
  onlyForceUpdate：只有当需要强制更新时才弹出提示更新dialog
   */
  static void check(
    BaseController logic, {
    bool needVersionToast = false,
    bool needShowProgress = false,
    bool inForceUpdateContext = false,
  }) async {
    if (needShowProgress) {
      logic.showProgress();
    }
    final result = await logic.get<CheckUpdateEntity>(Api.checkUpdate);
    logic.closeProgress();
    if (result.success) {
      final checkUpdateEntity = result.data!;
      var info = await PackageInfo.fromPlatform();
      bool needForceUpdate = checkUpdateEntity.forceUpdate == true;
      if (_compareVersion(result.data!.versionNumber, info.version) == 1) {
        if (inForceUpdateContext) {
          if (needForceUpdate) {
            Get.dialog(
              barrierDismissible: false,
              WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: CupertinoAlertDialog(
                  content: Text(
                    '发现新版本，请升级',
                    style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 15.sp,
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('升级'),
                      onPressed: () => _upgrade(logic, checkUpdateEntity),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          Get.dialog(
            barrierDismissible: !needForceUpdate,
            WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: CupertinoAlertDialog(
                content: needForceUpdate
                    ? Text(
                        '发现新版本，请升级',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 15.sp,
                        ),
                      )
                    : Text(
                        '当前发现新版本，是否进行升级',
                        style: TextStyle(
                          color: Colours.text_333,
                          fontSize: 15.sp,
                        ),
                      ),
                actions: [
                  if (!needForceUpdate)
                    CupertinoDialogAction(
                      child: Text('取消'),
                      onPressed: Get.back,
                    ),
                  CupertinoDialogAction(
                    child: Text('升级'),
                    onPressed: () => _upgrade(logic, checkUpdateEntity),
                  ),
                ],
              ),
            ),
          );
        }
      } else if (needVersionToast) {
        logic.showToast('你已是最新版本了');
      }
    } else {
      logic.showToast(result.msg);
    }
  }

  static Future<bool> ifIsNeedUpdate(BaseController logic) async {
    final result = await logic.get<CheckUpdateEntity>(Api.checkUpdate);
    if (result.success) {
      var info = await PackageInfo.fromPlatform();
      return _compareVersion(result.data!.versionNumber, info.version) == 1;
    } else {
      return false;
    }
  }

  static void _upgrade(BaseController logic, CheckUpdateEntity entity) async {
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(Constant.APPSTORE_URL))) {
        await launchUrl(Uri.parse(Constant.APPSTORE_URL), mode: LaunchMode.externalApplication);
      } else {
        logic.showToast('无法打开iOS应用商店地址');
      }
    } else {
      if (ObjectUtil.isNotEmpty(entity.url) && await canLaunchUrl(Uri.parse(entity.url!))) {
        await launchUrl(Uri.parse(entity.url!), mode: LaunchMode.externalApplication);
      } else {
        logic.showToast('无法打开Android下载地址');
      }
    }
  }

  // 版本号比对
  static int _compareVersion(String? v1, String? v2) {
    if (v1 == null || v2 == null) {
      //如果有个版本号空的话，不比较了。
      return 0;
    }
    List<String> v1Arr = v1.split('.');
    List<String> v2Arr = v2.split('.');
    var minVersionLens = v1Arr.length > v2Arr.length ? v2Arr.length : v1Arr.length;
    var result = 0;
    for (int i = 0; i < minVersionLens; i++) {
      var curV1 = int.parse(v1Arr[i]);
      var curV2 = int.parse(v2Arr[i]);
      if (curV1 > curV2) {
        result = 1;
        break;
      } else if (curV1 < curV2) {
        result = -1;
        break;
      }
    }
    if (result == 0 && (v1Arr.length != v2Arr.length)) {
      var v1BiggerThenv2 = v1Arr.length > v2Arr.length;
      var maxLensVersion = v1BiggerThenv2 ? v1Arr : v2Arr;
      for (int i = minVersionLens; i < maxLensVersion.length; i++) {
        var curVersion = int.parse(maxLensVersion[i]);
        if (curVersion > 0) {
          v1BiggerThenv2 ? (result = 1) : (result = -1);
          break;
        }
      }
    }
    return result;
  }
}
