import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/server_error/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';

class ServerErrorScreen extends GetView<ServerErrorController> {
  const ServerErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 24),
            Text('serverErrorTitle'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('serverErrorSubtitle'.tr, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            AppButton(text: 'retry'.tr, onPressed: controller.retry),
          ],
        ),
      ),
    );
  }
}
