import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/no_internet/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';

class NoInternetScreen extends GetView<NoInternetController> {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 24),
            Text('noInternetTitle'.tr,
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('noInternetSubtitle'.tr, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            AppButton(text: 'retry'.tr, onPressed: controller.retry),
          ],
        ),
      ),
    );
  }
}
