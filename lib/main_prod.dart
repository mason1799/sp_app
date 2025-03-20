import 'package:get/get.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:konesp/main.dart';

void main() async {
  Get.put(
    BuildEnvironment(
      flavor: BuildFlavor.prod,
      baseUrl: 'https://service-platform.kone.cn',
      wsUrl: 'ws://service-platform.kone.cn',
      serverUrl: 'https://serviceplatform-dk-prod.guance.kone.cn',
      appAndroidId: 'Service_Platform_Android_20230621',
      appIOSId: 'Service_Platform_iOS_20230621',
      jpushKey: 'f95ffbaa0c9ee70c5502f3dc',
      amapAndroidKey: '92f64d37a478a6e4ece086b021406cfc',
      amapIOSKey: '04b9457cf3c720a46547d05bfeca6d1e',
    ),
  );
  await init();
}
