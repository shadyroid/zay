import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/coupon_bean.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';
import 'package:zay/presentation/widgets/app_text_field.dart';

class CartCouponSection extends StatelessWidget {
  const CartCouponSection({
    super.key,
    required this.controller,
    required this.appliedCoupon,
    required this.isValidating,
    required this.onApply,
    required this.onRemove,
  });

  final TextEditingController controller;
  final CouponBean? appliedCoupon;
  final bool isValidating;
  final VoidCallback onApply;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'coupon'.tr,
            style: Get.theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (appliedCoupon != null)
            _AppliedCouponCard(
              coupon: appliedCoupon!,
              onRemove: onRemove,
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: controller,
                    hint: 'couponHint'.tr,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => onApply(),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isValidating ? null : onApply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.primary.withValues(alpha: 0.6),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: isValidating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: AppProgressIndicator(
                              radius: 8,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'apply'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _AppliedCouponCard extends StatelessWidget {
  const _AppliedCouponCard({
    required this.coupon,
    required this.onRemove,
  });

  final CouponBean coupon;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.orderSuccess),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.orderSuccess,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupon.code,
                  style: Get.theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '-£${coupon.discountAmount.toStringAsFixed(0)}',
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.orderSuccess,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close, size: 20),
            color: AppColors.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
