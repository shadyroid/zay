import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
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
    if (sizes == null || sizes!.isEmpty) return const SizedBox.shrink();

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
            crossAxisAlignment: WrapCrossAlignment.end,
            children: sizes!.map((size) {
              final isSelected = selectedSizeId == size.id;
              final isOutOfStock = size.isOutOfStock == true;
              final isRecommended =
                  size.isRecommended == true && !isOutOfStock;

              return InkWell(
                onTap: isOutOfStock
                    ? () => Get.rawSnackbar(message: 'outOfStock'.tr)
                    : () => onSizeSelected(size.id),
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 48,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isRecommended)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            'recommended'.tr,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                              height: 1.1,
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 13),
                      AnimatedScale(
                        scale: isSelected && !isOutOfStock ? 1.05 : 1.0,
                        duration: AppMotion.fast,
                        curve: AppMotion.standard,
                        child: AnimatedContainer(
                          duration: AppMotion.fast,
                          curve: AppMotion.standard,
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isOutOfStock
                                ? AppColors.screenBackground
                                : isSelected
                                    ? AppColors.primary
                                    : AppColors.screenBackground,
                            borderRadius: BorderRadius.circular(10),
                            border: isOutOfStock
                                ? Border.all(color: AppColors.border)
                                : isRecommended
                                    ? Border.all(
                                        color: AppColors.primary,
                                        width: 2,
                                      )
                                    : null,
                            boxShadow: isRecommended && !isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.18),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: AnimatedDefaultTextStyle(
                            duration: AppMotion.fast,
                            curve: AppMotion.standard,
                            style: (Get.theme.textTheme.titleSmall ??
                                    const TextStyle())
                                .copyWith(
                              color: isOutOfStock
                                  ? AppColors.textSecondary
                                      .withValues(alpha: 0.45)
                                  : isSelected
                                      ? Colors.white
                                      : isRecommended
                                          ? AppColors.primary
                                          : AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              decoration: isOutOfStock
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: AppColors.textSecondary
                                  .withValues(alpha: 0.45),
                            ),
                            child: Text(size.label ?? ''),
                          ),
                        ),
                      ),
                    ],
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
