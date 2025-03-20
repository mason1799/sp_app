/*
  prod: 生产环境
  qa:   测试环境
  dev:  开发联调
 */
enum BuildFlavor { prod, qa, dev }

/*
  flavor:           指定环境
  baseUrl:          http服务器地址
  serverUrl:        观测云地址
  appAndroidId:     观测云android
  appIOSId:         观测云iOS
  jpushKey:         极光推送
  amapAndroidKey:   高德android
  amapIOSKey:       高德iOS
  wsUrl:            websocket服务器地址
 */
class BuildEnvironment {
  final BuildFlavor flavor;
  final String baseUrl;
  final String serverUrl;
  final String appAndroidId;
  final String appIOSId;
  final String jpushKey;
  final String amapAndroidKey;
  final String amapIOSKey;
  final String wsUrl;

  BuildEnvironment({
    required this.flavor,
    required this.baseUrl,
    required this.serverUrl,
    required this.appAndroidId,
    required this.appIOSId,
    required this.jpushKey,
    required this.amapAndroidKey,
    required this.amapIOSKey,
    required this.wsUrl,
  });
}
