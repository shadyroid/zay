import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/order_track/controller.dart';
import 'package:hedma/presentation/screens/order_track/widgets/order_track_item.dart';

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
          itemBuilder: (context, index) {
            final isActive = index <= 2;
            return OrderTrackItem(
              title: controller.steps[index],
              isActive: isActive,
            );
          },
        ),
      ),
    );
  }
}
