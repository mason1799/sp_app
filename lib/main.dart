import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ft_mobile_agent_flutter/ft_mobile_agent_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kfps/kfps.dart';
import 'package:konesp/config/application.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/initial_binding.dart';
import 'package:konesp/util/handle_error_util.dart';
import 'package:konesp/util/theme_util.dart';
import 'package:oktoast/oktoast.dart';

Future<void> init() async {
  handleError(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    await KFPS.qf().initializeKFPSModule(soLanguage: SOLanguage.ZH);
    InitialBinding().dependencies();
    runApp(App());
  });
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class App extends StatelessWidget {
  App() {
    Application.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    final _designSize = const Size(375, 667);
    return LifecycleApp(
      child: ScreenUtilInit(
        designSize: _designSize,
        fontSizeResolver: (fontSize, instance) {
          final display = View.of(context).display;
          final screenSize = display.size / display.devicePixelRatio;
          final scaleWidth = screenSize.width / _designSize.width;
          return fontSize * scaleWidth;
        },
        builder: (context, child) => OKToast(
          duration: Duration(milliseconds: 1500),
          textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
          textPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
          radius: 6.w,
          position: ToastPosition.center,
          movingOnWindowChange: false,
          child: GetMaterialApp(
            title: '仟帆',
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.native,
            navigatorObservers: [
              LifecycleNavigatorObserver.hookMode(),
              FTRouteObserver(),
            ],
            theme: ThemeUtil.getTheme(),
            initialRoute: GetStorage().hasData(Constant.keyToken) ? Routes.main : Routes.login,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            ),
            getPages: Routes.getPages,
            locale: Locale('zh', 'CN'),
            fallbackLocale: const Locale('zh', 'CN'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [const Locale('zh', 'CN')],
          ),
        ),
      ),
    );
  }
}
