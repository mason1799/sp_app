import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kfps/kfmapp/amc/ckfm/native_tools.dart';
import 'package:kfps/kfps.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/common_util.dart';
import 'package:konesp/util/permission_util.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class KfpsUtil {
  static void jumpPage({
    required String orderNumber,
    required String equipmentCode,
    String? projectName,
  }) async {
    late Permission _target;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 30) {
        _target = Permission.storage;
      } else {
        _target = Permission.manageExternalStorage;
      }
    } else {
      _target = Permission.photos;
    }
    final isGranted = await PermissionUtil.requestPermission(_target);
    if (isGranted) {
      await Get.toNamed(Routes.kfps, arguments: {
        'orderId': orderNumber,
        'orderType': 'REPAIRE',
        'deviceType': 'KCE',
        'deviceNo': equipmentCode,
      });
      final _map1 = {
        'branchName': '',
        'branchCode': '',
        'companyName': StoreLogic.to.getUser()!.companyName,
        'companyCode': '',
      };
      compute((List args) => nativeSetEnvironmentVariables(args[0]), [jsonEncode(_map1)]);
      final _map2 = {
        'ken': equipmentCode,
        'contractStart': StoreLogic.to.getUser()!.contractStartDate,
        'contractEnd': StoreLogic.to.getUser()!.contractEndDate,
        'acceptanceDate': '',
        'projectName': projectName,
        'area': '',
      };
      compute((List args) => nativeSetEnvironmentVariables(args[0]), [jsonEncode(_map2)]);
    } else {
      Get.dialog(
        ConfirmDialog(
          content: '访问kfps需要外部文件目录权限，请打开权限',
          cancel: '取消',
          confirm: '去设置',
          onCancel: () {},
          onConfirm: () async {
            await openAppSettings();
          },
        ),
      );
    }
  }

  static void initAppLicense() {
    kfps.initLicenses(
      employeeId: '${StoreLogic.to.getUser()!.tenantId!}_${StoreLogic.to.getUser()!.id!}',
      email: CommonUtil.hidePhone(StoreLogic.to.getUser()!.phone!),
      token: GetStorage().read<String>(Constant.keyToken)!,
      licenseType: 0,
    );
    Future.delayed(Duration(seconds: 1), () {
      compute((_) => nativeDelayUploadParameter(), 0);
    });
  }

  static void initPageLicense() {
    compute((List args) {
      nativeCheckLicense(args[0], args[1], args[2], args[3], args[4]);
    }, [
      '${StoreLogic.to.getUser()!.tenantId!}_${StoreLogic.to.getUser()!.id!}',
      CommonUtil.hidePhone(StoreLogic.to.getUser()!.phone!),
      GetStorage().read<String>(Constant.keyToken),
      3,
      3
    ]);
  }
}
