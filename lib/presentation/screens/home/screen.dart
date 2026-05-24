import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/presentation/screens/home/controller.dart';
import 'package:hedma/presentation/screens/home/widgets/home_header.dart';
import 'package:hedma/presentation/screens/home/widgets/home_product_item.dart';
import 'package:hedma/presentation/screens/home/widgets/home_promo_banner.dart';
import 'package:hedma/presentation/screens/home/widgets/home_search_bar.dart';
import 'package:hedma/presentation/screens/home/widgets/home_section_header.dart';
import 'package:hedma/presentation/screens/home/widgets/home_top_store_item.dart';
import 'package:hedma/presentation/screens/products/widgets/category_chip.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value &&
              controller.recommendedProducts.isEmpty) {
            return const Center(child: AppProgressIndicator());
          }

          final favorites = Get.find<FavoriteProductsService>();
          final selectedCategoryId = controller.selectedCategoryId.value;
          final favoriteIds = favorites.favoriteIds;

          return ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              HomeHeader(userName: controller.userName.value),
              HomeSearchBar(
                controller: controller.searchController,
                onSearchSubmit: controller.onSearchSubmit,
                onSearchIconTap: controller.onSearchIconTap,
                onCameraTap: controller.onCameraTap,
                onFilterTap: controller.onFilterTap,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 56,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return CategoryChip(
                      category: category,
                      isSelected: selectedCategoryId == category.id,
                      onTap: () => controller.onCategoryTap(category),
                    );
                  },
                ),
              ),
              HomeSectionHeader(
                title: 'recommendedForYou'.tr,
                onSeeAll: controller.onSeeAllRecommended,
              ),
              SizedBox(
                height: HomeProductItem.listHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.recommendedProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.recommendedProducts[index];
                    return HomeProductItem(
                      product: product,
                      shopName: controller.shopNameFor(product),
                      isFavorite: favoriteIds.contains(product.id) ||
                          product.isFavorite,
                      onTap: () =>
                          controller.navigateToProductDetails(product),
                      onFavoriteTap: () => controller.toggleFavorite(product),
                    );
                  },
                ),
              ),
              const HomePromoBanner(),
              HomeSectionHeader(
                title: 'newArrival'.tr,
                onSeeAll: controller.onSeeAllNewArrival,
              ),
              SizedBox(
                height: HomeProductItem.listHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.newArrivalProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.newArrivalProducts[index];
                    return HomeProductItem(
                      product: product,
                      shopName: controller.shopNameFor(product),
                      isFavorite: favoriteIds.contains(product.id) ||
                          product.isFavorite,
                      onTap: () =>
                          controller.navigateToProductDetails(product),
                      onFavoriteTap: () => controller.toggleFavorite(product),
                    );
                  },
                ),
              ),
              HomeSectionHeader(
                title: 'topStores'.tr,
                onSeeAll: controller.onSeeAllStores,
              ),
              SizedBox(
                height: HomeTopStoreItem.listHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.topStores.length,
                  itemBuilder: (context, index) {
                    final shop = controller.topStores[index];
                    return HomeTopStoreItem(
                      shop: shop,
                      onTap: () => controller.onStoreTap(shop),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 0),
    );
  }
}
