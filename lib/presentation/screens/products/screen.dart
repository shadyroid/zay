import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/presentation/screens/products/controller.dart';
import 'package:zay/presentation/screens/products/widgets/products_action_bar.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';
import 'package:zay/presentation/widgets/category_item.dart';
import 'package:zay/presentation/widgets/empty_state.dart';
import 'package:zay/presentation/widgets/horizontal_list_view.dart';
import 'package:zay/presentation/widgets/product_item.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithSearchSwitch(
        customIsSearchModeNotifier: controller.isSearchMode,
        customTextNotifier: controller.searchText,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimary,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        centerTitle: true,
        appBarBuilder: (context) {
          return AppBar(
            title: Text(
              'products'.tr,
              style: Get.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              AppBarSearchButton(searchActiveButtonColor: Colors.white),
            ],
          );
        },
        onSubmitted: controller.onSearchSubmitted,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() {
                final selectedCategoryId = controller.selectedCategoryId.value;
                final categories = controller.categories.toList();
                return HorizontalListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryItem(
                      category: category,
                      isSelected: selectedCategoryId == category.id,
                      onTap: () => controller.selectCategory(category),
                    );
                  },
                );
              }),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Obx(
                  () => Text(
                    '${controller.totalCount.value} ${'items'.tr}',
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.onPullToRefresh,
                  child: PagingListener<int, ProductBean>(
                    controller: controller.pagingController,
                    builder: (context, state, fetchNextPage) =>
                        PagedGridView<int, ProductBean>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      showNewPageProgressIndicatorAsGridChild: false,
                      builderDelegate: PagedChildBuilderDelegate<ProductBean>(
                        itemBuilder: (context, product, index) => ProductItem(
                          product: product,
                          isFavorite: product.isFavorite,
                          onTap: () =>
                              controller.navigateToProductDetails(product),
                          onFavoriteTap: () async {
                            await controller.toggleFavorite(product);
                          },
                        ),
                        firstPageProgressIndicatorBuilder: (_) =>
                            const Center(child: AppProgressIndicator()),
                        newPageProgressIndicatorBuilder: (_) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: AppProgressIndicator()),
                        ),
                        noItemsFoundIndicatorBuilder: (_) => EmptyState(
                          message: 'noProducts'.tr,
                        ),
                      ),
                    ),
                  ),
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
              onSort: controller.onSortTap,
            ),
          ),
        ],
      ),
    );
  }
}
