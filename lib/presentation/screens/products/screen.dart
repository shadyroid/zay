import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/products/controller.dart';
import 'package:hedma/presentation/widgets/category_item.dart';
import 'package:hedma/presentation/screens/products/widgets/products_action_bar.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/product_grid_item.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'products'.tr,
        showDivider: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/ic_search.svg',
              width: 22,
              height: 22,
            ),
            onPressed: controller.onSearch,
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value && controller.products.isEmpty) {
            return const Center(child: AppProgressIndicator());
          }

          final selectedCategoryId = controller.selectedCategoryId.value;

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 48,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return CategoryItem(
                          category: category,
                          isSelected: selectedCategoryId == category.id,
                          onTap: () => controller.selectCategory(category),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      '${controller.totalCount.value} ${'items'.tr}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return ProductGridItem(
                          product: product,
                          isFavorite: product.isFavorite,
                          onTap: () =>
                              controller.navigateToProductDetails(product),
                          onFavoriteTap: () async {
                            await controller.toggleFavorite(product);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 16,
                child: ProductsActionBar(
                  onFilters: controller.onFilters,
                  onSort: controller.onSort,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
