import 'package:get/get.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:konesp/main.dart';

void main() async {
  Get.put(
    BuildEnvironment(
      flavor: BuildFlavor.dev,
      baseUrl: 'https://service-platform-dev.kone.cn',
      wsUrl: 'ws://service-platform-dev.kone.cn',
      serverUrl: 'https://serviceplatform-dk-test.guance.kone.cn',
      appIOSId: 'appid_20230613_ios',
      appAndroidId: 'appid_20230613',
      jpushKey: '4715d0d4fe1224ad9696e84a',
      amapAndroidKey: '50ca174bc238972e0a8337e6be0e48b5',
      amapIOSKey: '65d5cfe0c3231fa0929c9e2b98e01334',
    ),
  );
  await init();
}
