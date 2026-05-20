import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/product_size_bean.dart';

class ProductSizeSection extends StatelessWidget {
  const ProductSizeSection({
    super.key,
    required this.sizes,
    required this.selectedSizeId,
    required this.onSizeSelected,
    required this.onSizeGuideTap,
  });

  final List<ProductSizeBean> sizes;
  final String? selectedSizeId;
  final ValueChanged<String> onSizeSelected;
  final VoidCallback onSizeGuideTap;

  @override
  Widget build(BuildContext context) {
    if (sizes.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'size'.tr,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSizeGuideTap,
                child: Text(
                  '${'sizeGuide'.tr} >',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.selectedCheck,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sizes.map((size) {
              final isSelected = selectedSizeId == size.id;
              return InkWell(
                onTap: () => onSizeSelected(size.id),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondary
                        : AppColors.screenBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    size.label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
