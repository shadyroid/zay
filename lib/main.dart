import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/translations/app_translations.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/app/utils/app_theme.dart';
import 'package:zay/app/utils/deep_links_util.dart';
import 'package:zay/app/utils/notifications_util.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await PrefsManager.init();
  await Future.wait([
    initializeDateFormatting('ar'),
    initializeDateFormatting('en'),
  ]);
  await NotificationsUtil.init();
  await DeepLinksUtil.init();
  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ZAY',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Locale(PrefsManager.locale ?? 'ar'),
      fallbackLocale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      unknownRoute: Routes.unknownPage,
      theme: AppTheme.light(),
      defaultTransition: AppMotion.pageTransition,
      transitionDuration: AppMotion.page,
      builder: (context, child) {
        return Intro(
          padding: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          maskColor: const Color.fromRGBO(0, 0, 0, 0.6),
          maskClosable: true,
          buttonBuilder: (order) {
            return IntroButtonConfig(
              text: order >= 2 ? 'guideGotIt'.tr : 'guideNext'.tr,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            );
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
