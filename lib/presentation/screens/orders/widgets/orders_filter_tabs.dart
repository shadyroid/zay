import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/enums/order_list_filter.dart';
import 'package:zay/presentation/widgets/horizontal_list_view.dart';

class OrdersFilterTabs extends StatelessWidget {
  const OrdersFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final OrderListFilter selectedFilter;
  final ValueChanged<OrderListFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return HorizontalListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: OrderListFilter.values.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final filter = OrderListFilter.values[index];
        final isSelected = filter == selectedFilter;

        return _FilterChip(
          label: filter.translationKey.tr,
          isSelected: isSelected,
          onTap: () => onFilterSelected(filter),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: AppMotion.standard,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.screenBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: AnimatedDefaultTextStyle(
            duration: AppMotion.fast,
            curve: AppMotion.standard,
            style: (Get.theme.textTheme.bodySmall ?? const TextStyle()).copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
