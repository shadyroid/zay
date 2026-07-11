import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/size_bean.dart';

class ProductSizeSection extends StatelessWidget {
  const ProductSizeSection({
    super.key,
    required this.sizes,
    required this.selectedSizeId,
    required this.onSizeSelected,
    required this.onSizeGuideTap,
  });

  final List<SizeBean>? sizes;
  final int? selectedSizeId;
  final ValueChanged<int?> onSizeSelected;
  final VoidCallback onSizeGuideTap;

  @override
  Widget build(BuildContext context) {
    if (sizes==null||sizes!.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'size'.tr,
                style: Get.theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSizeGuideTap,
                child: Text(
                  '${'sizeGuide'.tr} >',
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
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
            children: sizes!.map((size) {
              final isSelected = selectedSizeId == size.id;
              return InkWell(
                onTap: size.isAvailable == true ? () => onSizeSelected(size.id) : null,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.screenBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: size.isAvailable == true
                        ? null
                        : Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    size.label ?? "",
                    style: Get.theme.textTheme.titleSmall?.copyWith(
                          color: size.isAvailable == false
                              ? AppColors.textSecondary.withValues(alpha: 0.5)
                              : isSelected
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
