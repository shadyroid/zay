import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/enums/review_size_fit.dart';

class SizeEvaluationSection extends StatelessWidget {
  const SizeEvaluationSection({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ReviewSizeFit selected;
  final ValueChanged<ReviewSizeFit> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'sizeEvaluationQuestion'.tr,
          style: Get.theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: ReviewSizeFit.values.map((fit) {
            final isSelected = fit == selected;
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: fit != ReviewSizeFit.values.last ? 8 : 0,
                ),
                child: InkWell(
                  onTap: () => onSelected(fit),
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _RadioDot(isSelected: isSelected),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          fit.labelKey.tr,
                          style:
                              Get.theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
            )
          : null,
    );
  }
}
