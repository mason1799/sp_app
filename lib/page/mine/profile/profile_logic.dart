import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/file_util.dart';
import 'package:konesp/util/oss_util.dart';
import 'package:konesp/widget/sheet/alert_bottom_sheet.dart';
import 'package:konesp/widget/sheet/input_dialog.dart';

import 'profile_state.dart';

class ProfileLogic extends BaseController {
  final ProfileState state = ProfileState();

  void toUpload({required String key, bool isCrop = false}) {
    showAlertBottomSheet(
      ['拍照', '从相册中选择'],
      (data, index) async {
        if (index == 0) {
          final _photo = await FileUtil.takeCamera(isCrop: isCrop);
          _updateImage(key: key, path: _photo);
        } else if (index == 1) {
          final _photo = await FileUtil.takeOnePhoto(isCrop: isCrop);
          _updateImage(key: key, path: _photo);
        }
      },
    );
  }

  void _updateImage({required String key, String? path}) async {
    if (path == null) {
      return;
    }
    showProgress();
    final result = await OssUtil.instance.upload(
      path,
      dict: key,
    );
    closeProgress();
    if (result.success) {
      final _signResult = await post(
        Api.editUserInfo,
        params: {
          'id': StoreLogic.to.getUser()!.id,
          key: result.data!.ossKey!,
        },
      );
      if (_signResult.success) {
        await StoreLogic.to.queryUserInfo();
      } else {
        showToast(_signResult.msg);
      }
    } else {
      showToast(result.msg);
    }
  }

  toEditOperationCertificateCode() {
    Get.dialog(
      InputDialog(
        title: '操作证号',
        necessary: true,
        initialValue: StoreLogic.to.getUser()!.operationCertificateCode,
        keyboardType: TextInputType.text,
        inputFormatters: [
          LengthLimitingTextInputFormatter(18),
          FilteringTextInputFormatter.allow(RegExp('[0-9X]')),
        ],
        onSave: (value) async {
          showProgress();
          final result = await post(
            Api.editUserInfo,
            params: {
              'id': StoreLogic.to.getUser()!.id,
              'operationCertificateCode': value,
            },
          );
          closeProgress();
          if (result.success) {
            StoreLogic.to.queryUserInfo();
          } else {
            showToast(result.msg);
          }
        },
      ),
    );
  }
}
