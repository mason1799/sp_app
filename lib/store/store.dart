import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:kfps/kfps.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/entity/oss_token_entity.dart';
import 'package:konesp/entity/user_info_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/widget/enum_data.dart';

class StoreLogic extends BaseController {
  static StoreLogic get to => Get.find<StoreLogic>();

  //用户信息
  var userEntity = Rxn<UserInfoEntity>();

  //展示权限
  var permissions = RxSet();

  //定位地址
  var address = RxnString();

  //oss令牌
  var ossToken = Rxn<OssTokenEntity>();

  UserInfoEntity? getUser() {
    return userEntity.value;
  }

  Future<void> whenSignOut() async {
    if (Get.currentRoute == Routes.login) {
      return;
    }
    GetStorage().remove(Constant.keyToken);
    GetStorage().remove(Constant.keyUser);
    GetStorage().remove(Constant.keyEquipmentHistory);
    GetStorage().remove(Constant.keyTaskHistory);
    GetStorage().remove(Constant.keyPermissions);
    Get.offNamedUntil(Routes.login, ModalRoute.withName(Routes.login));
    AppBadgePlus.updateBadge(0);
    (await Hive.openBox(Constant.privateOssBox)).clear();
    (await Hive.openBox(Constant.stuffsBox)).clear();
    kfps.logout();
  }

  Future<void> whenInApp() async {
    if (GetStorage().hasData(Constant.keyUser)) {
      userEntity.value = UserInfoEntity.fromJson(GetStorage().read<Map<String, dynamic>>(Constant.keyUser)!);
    }
    if (GetStorage().hasData(Constant.keyPermissions)) {
      List<String> _list = GetStorage().read(Constant.keyPermissions)?.cast<String>()!;
      permissions.assignAll(EnumToString.fromList<UserPermission>(UserPermission.values, _list).where((element) => element != null));
    }
  }

  Future<void> queryUserInfo() async {
    final result = await get<UserInfoEntity>(Api.queryUserInfo);
    if (result.success) {
      userEntity.value = result.data!;
      GetStorage().write(Constant.keyUser, result.data!.toJson());
    }
  }

  Future<void> queryPermissions() async {
    final result = await get<List<String>>(Api.queryPermissions);
    if (result.success) {
      permissions.assignAll(EnumToString.fromList<UserPermission>(UserPermission.values, result.data!).where((element) => element != null));
      GetStorage().write(Constant.keyPermissions, result.data!);
    }
  }
}
