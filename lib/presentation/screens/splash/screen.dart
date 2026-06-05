import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/splash/controller.dart';
import 'package:hedma/presentation/widgets/app_logo.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                AppLogo(),
                const SizedBox(height: 32),
                Text(
                  'appName'.tr,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'splashTagline'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                const Spacer(),
                const AppProgressIndicator(color: Colors.white),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
