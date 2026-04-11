import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' show BuildContextEasyLocalizationExtension, EasyLocalization;
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:size_config/size_config.dart' show SizeConfigInit;
import 'package:touristapp/utils/config/size_config.dart' show SizeConfig;
import 'package:touristapp/utils/di/di.dart' show setUpDI;
import 'package:touristapp/utils/router/router.dart' show router;
import 'package:touristapp/utils/service/app_lock_service.dart' show AppLockService;
import 'package:touristapp/utils/service/fcm_service.dart';

import 'firebase_options.dart' show DefaultFirebaseOptions;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setUpDI();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  AppLockService.instance.init(); // 🔒 app lock
  await Firebase.initializeApp(name: "TouristApp", options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotificationService().initNotification();
  runApp(
    EasyLocalization(
      startLocale: const Locale('uz'),
      fallbackLocale: const Locale('uz'),
      supportedLocales: [Locale('uz'), Locale('ru'), Locale('en')],
      path: 'assets/lang',
      saveLocale: true,
      child: const TouristApp(),
    ),
  );
}

class TouristApp extends StatelessWidget {
  const TouristApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(boldText: false, textScaler: TextScaler.linear(1.0)),
      child: SizeConfigInit(
        referenceHeight: 874,
        referenceWidth: 402,
        builder: (ctx, _) {
          SizeConfig.init(ctx);
          return MaterialApp.router(
            routerConfig: router,
            themeAnimationStyle: AnimationStyle(
              curve: Curves.easeInOutCubicEmphasized,
              duration: Duration(milliseconds: 650),
              reverseDuration: Duration(milliseconds: 500),
            ),
            localizationsDelegates: ctx.localizationDelegates,
            supportedLocales: ctx.supportedLocales,
            locale: ctx.locale,
            themeAnimationDuration: const Duration(milliseconds: 650),
            title: 'Tourist App',
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
