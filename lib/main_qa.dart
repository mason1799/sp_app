import 'package:get/get.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:konesp/main.dart';

void main() async {
  Get.put(
    BuildEnvironment(
      flavor: BuildFlavor.qa,
      baseUrl: 'https://service-platform-qa.kone.cn',
      wsUrl: 'ws://service-platform-qa.kone.cn',
      serverUrl: 'https://serviceplatform-dk-test.guance.kone.cn',
      appIOSId: 'appid_20230613_ios',
      appAndroidId: 'appid_20230613',
      jpushKey: 'dd9010c0a9829778bc8fbe00',
      amapAndroidKey: 'be8b6f6530b3a47a7591ad1799b5067e',
      amapIOSKey: '3f686f01fdc5abdc8f92cdf645849530',
    ),
  );
  await init();
}
