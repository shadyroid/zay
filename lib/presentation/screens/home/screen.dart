import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/presentation/screens/home/controller.dart';
import 'package:zay/presentation/screens/home/widgets/home_header.dart';
import 'package:zay/presentation/screens/home/widgets/home_promo_banner.dart';
import 'package:zay/presentation/screens/home/widgets/home_search_bar.dart';
import 'package:zay/presentation/screens/home/widgets/home_section_header.dart';
import 'package:zay/presentation/screens/home/widgets/shop_item.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';
import 'package:zay/presentation/widgets/category_item.dart';
import 'package:zay/presentation/widgets/main_bottom_nav.dart';
import 'package:zay/presentation/widgets/product_item.dart';

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

          final selectedCategoryId = controller.selectedCategoryId.value;

          return ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              HomeHeader(
                userName: controller.userName.value,
                imagePath: controller.profileImagePath.value,
              ),
              HomeSearchBar(
                controller: controller.searchController,
                onSearchSubmit: controller.onSearchSubmit,
                onSearchIconTap: controller.onSearchIconTap,
                onCameraTap: controller.onCameraTap,
                onFilterTap: controller.onFilterTap,
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  for(var category in controller.categories)
                    CategoryItem(
                      category: category,
                      isSelected: selectedCategoryId == category.id,
                      onTap: () => controller.onCategoryTap(category),
                    )
                ],),
              ),

              HomeSectionHeader(
                title: 'recommendedForYou'.tr,
                onSeeAll: controller.onSeeAllRecommended,
              ),
              SizedBox(
                height: (150 / 0.78) + 78,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.recommendedProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.recommendedProducts[index];
                    return SizedBox(
                      width: 150,
                      child: ProductItem(
                        product: product,
                        isFavorite: product.isFavorite,
                        onTap: () =>
                            controller.navigateToProductDetails(product),
                        onFavoriteTap: () => controller.toggleFavorite(product),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 12),
                ),
              ),
              const HomePromoBanner(),

              if (controller.newArrivalProducts.isNotEmpty) ...[
                HomeSectionHeader(
                  title: 'newArrival'.tr,
                  onSeeAll: controller.onSeeAllNewArrival,
                ),
                SizedBox(
                  height: (150 / 0.78) + 78,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.newArrivalProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.newArrivalProducts[index];
                      return SizedBox(
                        width: 150,
                        child: ProductItem(
                          product: product,
                          isFavorite: product.isFavorite,
                          onTap: () =>
                              controller.navigateToProductDetails(product),
                          onFavoriteTap: () =>
                              controller.toggleFavorite(product),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: 12),
                  ),
                ),
              ],
              HomeSectionHeader(
                title: 'topStores'.tr,
                onSeeAll: controller.onSeeAllStores,
              ),
              SizedBox(
                height: 56,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.topStores.length,
                  itemBuilder: (context, index) {
                    final shop = controller.topStores[index];
                    return ShopItem(
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
