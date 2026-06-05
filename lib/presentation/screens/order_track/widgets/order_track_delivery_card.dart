import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class OrderTrackDeliveryCard extends StatelessWidget {
  const OrderTrackDeliveryCard({
    super.key,
    required this.estimatedDelivery,
  });

  final String estimatedDelivery;

  static const Color _background = Color(0xFFE8F6EF);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'estimatedDelivery'.tr,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            estimatedDelivery,
            style: Get.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary,
                ),
          ),
        ],
      ),
    );
  }
}
