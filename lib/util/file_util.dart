import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/permission_util.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUtil {
  /// 调用相机
  static Future<String?> takeCamera({bool isCrop = false}) async {
    Get.focusScope?.unfocus();
    final isCameraGranted = await PermissionUtil.requestPermission(Permission.camera);
    if (isCameraGranted) {
      final XFile? _xFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (_xFile == null) {
        return null;
      }
      if (GetStorage().read<bool>(Constant.keySaveAlbum) ?? false) {
        await ImageGallerySaver.saveImage(await _xFile.readAsBytes());
      }
      if (isCrop) {
        final _croppedFile = await ImageCropper().cropImage(
          sourcePath: _xFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: '裁剪',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colours.text_333,
              statusBarColor: Colors.black,
              lockAspectRatio: true,
              aspectRatioPresets: [CropAspectRatioPreset.original],
              cropStyle: CropStyle.circle,
            ),
            IOSUiSettings(
              title: '裁剪',
              aspectRatioLockEnabled: true,
              aspectRatioPresets: [CropAspectRatioPreset.original],
              cropStyle: CropStyle.circle,
            ),
          ],
        );
        return _croppedFile?.path;
      }
      return _xFile.path;
    } else {
      Get.dialog(
        ConfirmDialog(
          content: '相机权限未开启',
          confirm: '去设置',
          onConfirm: () async => await openAppSettings(),
        ),
      );
      return null;
    }
  }

  /// 选取相册
  static Future<List<String>> takePhotos({int limitCount = 1}) async {
    Get.focusScope?.unfocus();
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
    final isAlbumGranted = await PermissionUtil.requestPermission(_target);
    if (isAlbumGranted) {

      if (limitCount <= 1) {
        XFile? _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (_xFile == null) {
          return [];
        }
        return [_xFile.path];
      } else {
        List<XFile> _images = await ImagePicker().pickMultiImage(limit: limitCount);
        if (_images.isEmpty) {
          return [];
        }
        if (_images.length > limitCount) {
          Get.dialog(
            ConfirmDialog(
              content: '选取的照片数量超出限制，请重新选取',
              isSingleButton: true,
            ),
          );
          return [];
        }
        return _images.map((e) => e.path).toList();
      }
    } else {
      Get.dialog(
        ConfirmDialog(
          content: '相册权限未开启',
          confirm: '去设置',
          onConfirm: () async => await openAppSettings(),
        ),
      );
      return [];
    }
  }

  /// 选一张照片
  static Future<String?> takeOnePhoto({bool isCrop = false}) async {
    Get.focusScope?.unfocus();
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
    final isAlbumGranted = await PermissionUtil.requestPermission(_target);
    if (isAlbumGranted) {
      XFile? _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_xFile == null) {
        return null;
      }
      if (isCrop) {
        final _croppedFile = await ImageCropper().cropImage(
          sourcePath: _xFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: '裁剪',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colours.text_333,
              statusBarColor: Colors.black,
              lockAspectRatio: true,
              aspectRatioPresets: [CropAspectRatioPreset.original],
              cropStyle: CropStyle.circle,
            ),
            IOSUiSettings(
              title: '裁剪',
              aspectRatioLockEnabled: true,
              aspectRatioPresets: [CropAspectRatioPreset.original],
              cropStyle: CropStyle.circle,
            ),
          ],
        );
        return _croppedFile?.path;
      }
      return _xFile.path;
    } else {
      Get.dialog(
        ConfirmDialog(
          content: '相册权限未开启',
          confirm: '去设置',
          onConfirm: () async => await openAppSettings(),
        ),
      );
      return null;
    }
  }
}
