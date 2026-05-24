import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/product_filters.dart';
import 'package:hedma/presentation/bottom_sheets/filter/filter_bottom_sheet_controller.dart';
import 'package:hedma/presentation/bottom_sheets/filter/widgets/filter_section_title.dart';
import 'package:hedma/presentation/bottom_sheets/filter/widgets/filter_size_chip.dart';
import 'package:hedma/presentation/bottom_sheets/filter/widgets/filter_store_chip.dart';
import 'package:hedma/presentation/screens/products/widgets/category_chip.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class FilterBottomSheet extends GetView<FilterBottomSheetController> {
  const FilterBottomSheet({super.key});

  static Future<ProductFilters?> show({
    required ProductFilters initial,
  }) async {
    Get.put(FilterBottomSheetController(initial: initial));
    final result = await Get.bottomSheet<ProductFilters?>(
      const FilterBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
    if (Get.isRegistered<FilterBottomSheetController>()) {
      Get.delete<FilterBottomSheetController>();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.88;

    return Container(
      height: sheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Text(
                'filters'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: AppProgressIndicator());
                }

                final selectedCategoryId = controller.selectedCategoryId.value;
                final selectedShopId = controller.selectedShopId.value;
                final selectedSizeId = controller.selectedSizeId.value;
                final priceRange = controller.priceRange.value;

                return ListView(
                  padding: const EdgeInsets.only(bottom: 16),
                  children: [
                    FilterSectionTitle(title: 'categories'.tr),
                    SizedBox(
                      height: 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          final category = controller.categories[index];
                          return CategoryChip(
                            category: category,
                            isSelected: selectedCategoryId == category.id,
                            onTap: () => controller.selectCategory(category),
                          );
                        },
                      ),
                    ),
                    FilterSectionTitle(title: 'stores'.tr),
                    SizedBox(
                      height: 64,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.shops.length,
                        itemBuilder: (context, index) {
                          final shop = controller.shops[index];
                          return FilterStoreChip(
                            shop: shop,
                            isSelected: selectedShopId == shop.id,
                            onTap: () => controller.selectShop(shop),
                          );
                        },
                      ),
                    ),
                    FilterSectionTitle(title: 'size'.tr),
                    SizedBox(
                      height: 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.sizes.length,
                        itemBuilder: (context, index) {
                          final size = controller.sizes[index];
                          return FilterSizeChip(
                            size: size,
                            isSelected: selectedSizeId == size.id,
                            onTap: () => controller.selectSize(size),
                          );
                        },
                      ),
                    ),
                    FilterSectionTitle(title: 'price'.tr),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.secondary,
                              inactiveTrackColor: AppColors.screenBackground,
                              thumbColor: AppColors.secondary,
                              overlayColor:
                                  AppColors.secondary.withValues(alpha: 0.12),
                              rangeThumbShape: const RoundRangeSliderThumbShape(
                                enabledThumbRadius: 10,
                              ),
                              trackHeight: 4,
                            ),
                            child: RangeSlider(
                              values: priceRange,
                              min: FilterBottomSheetController.priceMinBound,
                              max: FilterBottomSheetController.priceMaxBound,
                              onChanged: controller.onPriceChanged,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${priceRange.start.round()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '\$${priceRange.end.round()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: controller.clearFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.screenBackground,
                          foregroundColor: AppColors.textPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: Text(
                          'clearFilter'.tr,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.back(result: controller.buildFilters()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: Text(
                          'apply'.tr,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
