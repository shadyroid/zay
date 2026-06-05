import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/enums/order_list_filter.dart';

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
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
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
      ),
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
      color: isSelected ? AppColors.secondary : AppColors.screenBackground,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Text(
            label,
            style: Get.theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
          ),
        ),
      ),
    );
  }
}
