import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/splash/controller.dart';
import 'package:zay/presentation/widgets/app_logo.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(child: AppLogo()),
      ),
    );
  }
}
