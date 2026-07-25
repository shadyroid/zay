import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/presentation/screens/splash/controller.dart';
import 'package:zay/presentation/widgets/app_logo.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: const AppLogo(size: 96)
              .animate()
              .fadeIn(duration: AppMotion.slow, curve: AppMotion.standard)
              .scale(
                begin: const Offset(0.82, 0.82),
                end: const Offset(1, 1),
                duration: AppMotion.slow,
                curve: Curves.easeOutBack,
              )
              .then(delay: const Duration(milliseconds: 200))
              .shimmer(
                duration: const Duration(milliseconds: 900),
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
        ),
      ),
    );
  }
}
