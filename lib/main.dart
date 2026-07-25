import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/translations/app_translations.dart';
import 'package:zay/app/utils/app_theme.dart';
import 'package:zay/app/utils/deep_links_util.dart';
import 'package:zay/app/utils/notifications_util.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/data/remote/dio_client.dart';
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
  await NotificationsUtil.init();
  await DeepLinksUtil.init();
  Get.put(DioClient(), permanent: true);
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
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      theme: AppTheme.light(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
    );
  }
}
