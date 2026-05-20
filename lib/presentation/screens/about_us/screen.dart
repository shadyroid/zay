import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/about_us/controller.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aboutUs'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(Icons.shopping_bag,
                        size: 80, color: AppColors.secondary),
                    const SizedBox(height: 24),
                    Text('appName'.tr,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Text(controller.content.value, textAlign: TextAlign.center),
                  ],
                ),
              ),
      ),
    );
  }
}
