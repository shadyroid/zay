import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({
    super.key,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String name;
  final double? price;
  final double? originalPrice;
  final String rating;
  final int reviewCount;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final double currentPrice = price ?? 0.0;
    final double origPrice = originalPrice ?? 0.0;
    final bool hasDiscount =
        originalPrice != null && price != null && origPrice > currentPrice;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Get.theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Get.theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        children: [
                          TextSpan(text: '${'price'.tr}: '),
                          TextSpan(
                            text: '£${currentPrice.toStringAsFixed(2)}',
                            style: Get.theme.textTheme.titleLarge?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (hasDiscount) ...[
                      Text(
                        '£${origPrice.toStringAsFixed(2)}',
                        style: Get.theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${(((origPrice - currentPrice) / origPrice) * 100).toStringAsFixed(0)}% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/ic_star.svg', width: 16, height: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$rating ($reviewCount ${'reviews'.tr})',
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _QuantitySelector(
            quantity: quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ],
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(icon: Icons.remove, onTap: onDecrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AnimatedSwitcher(
              duration: AppMotion.instant,
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Text(
                '$quantity',
                key: ValueKey(quantity),
                style: Get.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          _QtyButton(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
