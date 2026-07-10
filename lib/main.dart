import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/translations/app_translations.dart';
import 'package:zay/app/utils/app_theme.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/data/remote/dio_client.dart';
import 'package:zay/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefsManager.init();
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
      locale: Locale(PrefsManager.locale ?? 'en'),
      fallbackLocale: const Locale('en'),
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      theme: AppTheme.light(),
    );
  }
}
