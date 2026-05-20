import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/translations/app_translations.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/data/remote/dio_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  Get.put(DioClient(), permanent: true);
  runApp(const HedmaApp());
}

class HedmaApp extends StatelessWidget {
  const HedmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hedma',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: AppColors.secondary.withValues(alpha: 0.25),
        ),
      ),
    );
  }
}
