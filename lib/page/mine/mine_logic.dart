import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/permission_util.dart';
import 'package:konesp/util/version_update_util.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'mine_state.dart';

class MineLogic extends BaseController {
  final MineState state = MineState();

  query() async {
    state.cacheSize = formatSize(await getCacheSize());
    update(['cache']);
    state.isNeedUpdate = await VersionUpdateUtil.ifIsNeedUpdate(this);
    update(['version']);
  }

  void logout() async {
    Get.dialog(
      ConfirmDialog(
        content: '确定退出登录?',
        onConfirm: () => StoreLogic.to.whenSignOut(),
      ),
    );
  }

  clearCache() {
    Get.dialog(
      ConfirmDialog(
        content: '确定清除所有缓存数据?',
        onConfirm: () async {
          final cacheManager = DefaultCacheManager();
          final cacheDir = await getTemporaryDirectory();
          final directory = Directory(cacheDir.path);
          if (await directory.exists()) {
            final files = directory.listSync(recursive: true);
            for (var file in files) {
              if (file is File) {
                await file.delete();
              }
            }
          }
          await cacheManager.emptyCache();
          (await Hive.openBox(Constant.privateOssBox)).clear();
          (await Hive.openBox(Constant.stuffsBox)).clear();
          showToast('清除成功');
          state.cacheSize = formatSize(await getCacheSize());
          update(['cache']);
        },
      ),
    );
  }

  void toHelp() {
    Get.toNamed(Routes.helpCenter);
  }

  void toUserProtocol() {
    Get.toNamed(Routes.web, arguments: {'url': 'assets/resource/user_protocol.html'});
  }

  void toRuleProtocol() {
    Get.toNamed(Routes.web, arguments: {'url': 'assets/resource/rule_protocol.html'});
  }

  toChanged(bool value) async {
    if (value == true) {
      late Permission _target;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          _target = Permission.storage;
        } else {
          _target = Permission.photos;
        }
      } else {
        _target = Permission.photos;
      }
      final _isGranted = await PermissionUtil.requestPermission(_target);
      if (_isGranted) {
        GetStorage().write(Constant.keySaveAlbum, true);
        update(['saveInAlbum']);
      } else {
        Get.dialog(
          ConfirmDialog(
            content: '相册权限未开启',
            confirm: '去设置',
            onConfirm: () async => await openAppSettings(),
          ),
        );
      }
    } else {
      GetStorage().write(Constant.keySaveAlbum, false);
      update(['saveInAlbum']);
    }
  }

  Future<int> getCacheSize() async {
    final cacheDir = await getTemporaryDirectory();
    final directory = Directory(cacheDir.path);
    int totalSize = 0;
    if (await directory.exists()) {
      final files = directory.listSync(recursive: true);
      for (var file in files) {
        if (file is File) {
          totalSize += await file.length();
        }
      }
    }
    return totalSize;
  }

  String formatSize(int? bytes) {
    if (bytes == null || bytes <= 0) {
      return '';
    } else if (bytes < 1024) {
      return '${bytes}B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)}K';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)}M';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)}G';
    }
  }
}
