import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/product_sort_option.dart';
import 'package:hedma/presentation/bottom_sheets/sort/widgets/sort_option_item.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({
    super.key,
    required this.selectedOption,
  });

  final ProductSortOption? selectedOption;

  static Future<ProductSortOption?> show({
    required ProductSortOption? selectedOption,
  }) {
    return Get.bottomSheet<ProductSortOption?>(
      SortBottomSheet(selectedOption: selectedOption),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'sortBy'.tr,
                      style: Get.theme.textTheme.titleMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: SvgPicture.asset(
                      'assets/icons/ic_close.svg',
                      width: 20,
                      height: 20,
                    ),
                    onPressed: Get.back,
                  ),
                ],
              ),
            ),
            ...ProductSortOption.values.map(
              (option) => SortOptionItem(
                option: option,
                isSelected: option == selectedOption,
                onTap: () => Get.back(result: option),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
