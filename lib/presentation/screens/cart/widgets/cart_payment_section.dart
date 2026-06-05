import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/payment_method.dart';

class CartPaymentSection extends StatelessWidget {
  const CartPaymentSection({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'paymentMethod'.tr,
            style: Get.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          _PaymentOption(
            iconPath: 'assets/icons/ic_cash.svg',
            label: 'cash'.tr,
            isSelected: selectedMethod == PaymentMethod.cash,
            onTap: () => onMethodSelected(PaymentMethod.cash),
          ),
          const SizedBox(height: 8),
          _PaymentOption(
            iconPath: 'assets/icons/ic_card.svg',
            label: 'card'.tr,
            isSelected: selectedMethod == PaymentMethod.card,
            onTap: () => onMethodSelected(PaymentMethod.card),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Get.theme.textTheme.bodyLarge,
              ),
            ),
            _RadioDot(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.secondary : AppColors.border,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
