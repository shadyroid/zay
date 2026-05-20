import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/translations/app_translations.dart';
import 'package:hedma/app/utils/app_theme.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/data/remote/dio_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  Get.put(DioClient(), permanent: true);
  Get.put(FavoriteProductsService(), permanent: true);
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
      locale: Locale(PrefsManager.locale ?? 'en'),
      fallbackLocale: const Locale('en'),
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      theme: AppTheme.light(),
    );
  }
}
