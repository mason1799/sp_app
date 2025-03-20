import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/entity/message_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/message/message_logic.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/permission_util.dart';
import 'package:konesp/util/version_update_util.dart';
import 'package:konesp/widget/enum_data.dart';
import 'package:konesp/widget/my_bottom_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main_state.dart';

class MainLogic extends BaseController {
  final MainState state = MainState();

  @override
  void onReady() async {
    VersionUpdateUtil.check(this, inForceUpdateContext: true);
    queryUnreadCount();
    initSetups();
  }

  void selectToIndex(int index) {
    if (StoreLogic.to.getUser() == null) {
      StoreLogic.to.whenSignOut();
      return;
    }
    if (index < 0 || index > 4) {
      return;
    }
    if (index == 2) {
      if (StoreLogic.to.permissions.contains(UserPermission.showCreateTroubleTicket)) {
        Get.toNamed(Routes.fixCreate);
      } else {
        showToast('暂无创建故障工单权限');
      }
    } else {
      state.selectedIndex = index;
      state.pageController.jumpToPage(index);
      update(['bottomBar']);
    }
  }

  Future<List<MessageEntity>> queryUnreadCount() async {
    final result = await get<List<MessageEntity>>(Api.unreadCount);
    if (result.success) {
      if (ObjectUtil.isNotEmpty(result.data)) {
        int _totalCount = 0;
        for (var item in result.data!) {
          _totalCount = (item.count ?? 0) + _totalCount;
        }
        setUnreadCount(_totalCount);
      } else {
        setUnreadCount(0);
      }
      return result.data ?? [];
    }
    return [];
  }

  void setUnreadCount(int totalCount) async {
    if (state.tabBar[3].number != totalCount && totalCount > -1) {
      state.tabBar[3] = BottomBarItem(icon: 'message', activeIcon: 'message_s', title: '消息', number: totalCount);
      update(['bottomBar']);
      AppBadgePlus.updateBadge(totalCount);
    }
  }

  void initSetups() async {
    Get.focusScope?.unfocus();
    BuildEnvironment buildEnvironment = Get.find<BuildEnvironment>();
    JPush().setup(
      appKey: buildEnvironment.jpushKey,
      channel: 'konesp',
      production: true,
    );
    AMapFlutterLocation.setApiKey(buildEnvironment.amapAndroidKey, buildEnvironment.amapIOSKey);
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);
    if (Platform.isIOS) {
      JPush().setUnShowAtTheForeground(unShow: false);
      JPush().applyPushAuthority(NotificationSettingsIOS(sound: true, alert: true, badge: false));
    } else {
      JPush().requestRequiredPermission();
      JPush().enableAutoWakeup(enable: true);
    }
    await PermissionUtil.requestPermission(Permission.notification);
    JPush().addEventHandler(
      onOpenNotification: (Map<String, dynamic> msg) async {
        Map _map = Platform.isAndroid ? msg['extras']['cn.jpush.android.EXTRA'] : msg;
        if (_map.containsKey('type')) {
          int type = int.parse(_map['type'] ?? '0');
          if (!GetStorage().hasData(Constant.keyToken)) {
            Get.toNamed(Routes.login);
            return;
          }
          Get.until((route) => route.settings.name == Routes.main);
          if (type == 0) {
            if (Get.isRegistered<MainLogic>()) {
              Get.find<MainLogic>().selectToIndex(3);
            }
            await Get.toNamed(Routes.messageList, arguments: {'type': 0});
            if (Get.isRegistered<MainLogic>()) {
              List<MessageEntity> list = await Get.find<MainLogic>().queryUnreadCount();
              if (Get.isRegistered<MessageLogic>()) {
                Get.find<MessageLogic>().setItems(list);
              }
            }
          } else if (type == 1) {
            if (Get.isRegistered<MainLogic>()) {
              Get.find<MainLogic>().selectToIndex(0);
            }
            int bizId = int.parse(_map['bizId'] ?? '0');
            Get.toNamed(Routes.regularDetail, arguments: {'id': bizId});
          } else if (type == 2) {
            if (Get.isRegistered<MainLogic>()) {
              Get.find<MainLogic>().selectToIndex(0);
            }
            int bizId = int.parse(_map['bizId'] ?? '0');
            Get.toNamed(Routes.fixDetail, arguments: {'id': bizId});
          }
        }
      },
      onReceiveMessage: (Map<String, dynamic> msg) async {
        if (Get.isRegistered<MainLogic>()) {
          List<MessageEntity> list = await Get.find<MainLogic>().queryUnreadCount();
          if (Get.isRegistered<MessageLogic>()) {
            Get.find<MessageLogic>().setItems(list);
          }
        }
      },
    );
    final regId = await JPush().getRegistrationID();
    post(Api.bindRegId, params: {'regId': regId});
  }
}
