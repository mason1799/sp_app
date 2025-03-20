import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:konesp/config/build_environment.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Application {
  factory Application() => _singleton;

  Application._();

  static final Application _singleton = Application._();

  static Application get instance => Application();

  void init() async {
    await Hive.initFlutter();
    BuildEnvironment buildEnvironment = Get.find<BuildEnvironment>();
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    FTMobileFlutter.sdkConfig(
      datakitUrl: buildEnvironment.serverUrl,
      serviceName: 'Kone_service_platform',
    );
    FTRUMManager().setConfig(
      androidAppId: buildEnvironment.appAndroidId,
      iOSAppId: buildEnvironment.appIOSId,
      errorMonitorType: ErrorMonitorType.all.value,
      deviceMetricsMonitorType: DeviceMetricsMonitorType.all.value,
    );
  }
}
