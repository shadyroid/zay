import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/presentation/screens/no_internet/controller.dart';
import 'package:zay/presentation/widgets/app_button.dart';

class NoInternetScreen extends GetView<NoInternetController> {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/no_internet_connection_bg.png',
            width: double.infinity,
          ).animate().fadeIn(duration: AppMotion.slow),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/ic_no_internet_connection.svg')
                    .animateScaleIn(),
                const SizedBox(height: 24),
                Text(
                  'noInternetTitle'.tr,
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.headlineSmall,
                ).animateEntrance(delay: const Duration(milliseconds: 100)),
                const SizedBox(height: 8),
                Text(
                  'noInternetSubtitle'.tr,
                  textAlign: TextAlign.center,
                ).animateEntrance(delay: const Duration(milliseconds: 160)),
                const SizedBox(height: 32),
                AppButton(text: 'retry'.tr, onPressed: controller.retry)
                    .animateEntrance(delay: const Duration(milliseconds: 220)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
