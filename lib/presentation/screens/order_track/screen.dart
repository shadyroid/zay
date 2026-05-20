import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/order_track/controller.dart';

class OrderTrackScreen extends GetView<OrderTrackController> {
  const OrderTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('orderTrack'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: controller.steps.length,
          itemBuilder: (_, i) {
            final isActive = i <= 2;
            return ListTile(
              leading: Icon(
                isActive ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isActive ? AppColors.secondary : Colors.grey,
              ),
              title: Text(controller.steps[i]),
            );
          },
        ),
      ),
    );
  }
}
