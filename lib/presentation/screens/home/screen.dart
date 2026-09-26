import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/presentation/screens/home/controller.dart';
import 'package:zay/presentation/screens/home/widgets/home_ads_carousel.dart';
import 'package:zay/presentation/screens/home/widgets/home_header.dart';
import 'package:zay/presentation/screens/home/widgets/home_promo_banner.dart';
import 'package:zay/presentation/screens/home/widgets/home_search_bar.dart';
import 'package:zay/presentation/screens/home/widgets/home_section_header.dart';
import 'package:zay/presentation/screens/home/widgets/home_skeleton.dart';
import 'package:zay/presentation/screens/home/widgets/shop_item.dart';
import 'package:zay/presentation/widgets/category_item.dart';
import 'package:zay/presentation/widgets/horizontal_list_view.dart';
import 'package:zay/presentation/widgets/product_item.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final intro = Intro.of(context);
    return ValueListenableBuilder<IntroStatus>(
      valueListenable: intro.statusNotifier,
      builder: (context, status, _) {
        return PopScope(
          canPop: !status.isOpen,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) intro.dispose();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: ListView(
                controller: controller.scrollController,
                padding: const EdgeInsets.only(bottom: 16),
                children: [
                  Obx(
                    () => HomeHeader(
                      userName: controller.userName.value,
                      imagePath: controller.profileImagePath.value,
                      unreadNotificationsCount:
                          controller.unreadNotificationsCount.value,
                      onSearchTap: () => controller.onSearchToggle(),
                      onNotificationsTap: controller.onNotificationsTap,
                    ).animateEntrance(),
                  ),
                  Obx(
                    () => AnimatedSize(
                      duration: AppMotion.fast,
                      curve: AppMotion.emphasized,
                      alignment: Alignment.topCenter,
                      child: controller.isSearchExpanded.value
                          ? HomeSearchBar(
                              controller: controller.searchController,
                              focusNode: controller.searchFocusNode,
                              onSearchSubmit: controller.onSearchSubmit,
                              onSearchIconTap: controller.onSearchIconTap,
                              onCameraTap: controller.onCameraTap,
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    if (controller.isLoadingCategories.value &&
                        controller.categories.isEmpty) {
                      return const HomeHorizontalSkeleton(
                        itemWidth: 72,
                        itemHeight: 40,
                        itemCount: 5,
                      );
                    }
                    return HorizontalListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return CategoryItem(
                          category: category,
                          isSelected: controller.selectedCategoryId.value ==
                              category.id,
                          onTap: () => controller.onCategoryTap(category),
                        ).animateSlideIn(
                          delay: Duration(milliseconds: index * 30),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    if (controller.isLoadingAds.value &&
                        controller.ads.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: HomeShimmerBox(borderRadius: 0),
                        ),
                      );
                    }
                    return HomeAdsCarousel(
                      ads: controller.ads.toList(),
                      currentIndex: controller.currentAdIndex.value,
                      onPageChanged: controller.onAdPageChanged,
                    ).animateEntrance(
                      delay: const Duration(milliseconds: 80),
                    );
                  }),
                  Obx(() => _productsSection(
                        isLoading: controller.isLoadingRecommended.value,
                        products: controller.recommendedProducts.toList(),
                        title: 'recommendedForYou'.tr,
                        onSeeAll: controller.onSeeAllRecommended,
                        scrollController:
                            controller.recommendedProductsScrollController,
                        fromRecommended: true,
                        headerDelay: const Duration(milliseconds: 120),
                      )),
                  HomePromoBanner(
                    onTryOnTap: () => controller.startTryOnGuide(context),
                    onSearchByImageTap: () =>
                        controller.startSearchByImageGuide(context),
                  ).animateEntrance(
                    delay: const Duration(milliseconds: 160),
                  ),
                  Obx(() => _productsSection(
                        isLoading: controller.isLoadingNewArrivals.value,
                        products: controller.newArrivalProducts.toList(),
                        title: 'newArrival'.tr,
                        onSeeAll: controller.onSeeAllNewArrival,
                        scrollController:
                            controller.newArrivalProductsScrollController,
                        fromRecommended: false,
                        headerDelay: const Duration(milliseconds: 180),
                      )),
                  Obx(() {
                    final loading = controller.isLoadingStores.value &&
                        controller.topStores.isEmpty;
                    if (!loading && controller.topStores.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeSectionHeader(
                          title: 'topStores'.tr,
                          onSeeAll: controller.onSeeAllStores,
                        ).animateEntrance(
                          delay: const Duration(milliseconds: 200),
                        ),
                        if (loading)
                          const HomeHorizontalSkeleton(
                            itemWidth: 120,
                            itemHeight: 44,
                          )
                        else
                          HorizontalListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: controller.topStores.length,
                            itemBuilder: (context, index) {
                              final shop = controller.topStores[index];
                              return ShopItem(
                                shop: shop,
                                onTap: () => controller.onStoreTap(shop),
                              ).animateSlideIn(
                                delay: Duration(milliseconds: index * 40),
                              );
                            },
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _productsSection({
    required bool isLoading,
    required List<ProductBean> products,
    required String title,
    required VoidCallback onSeeAll,
    required ScrollController scrollController,
    required bool fromRecommended,
    required Duration headerDelay,
  }) {
    if (isLoading && products.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeSectionHeader(title: title, onSeeAll: onSeeAll),
          const HomeHorizontalSkeleton(
            itemWidth: ProductItem.cardWidth,
            itemHeight: ProductItem.cardHeight,
          ),
        ],
      );
    }
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionHeader(
          title: title,
          onSeeAll: onSeeAll,
        ).animateEntrance(delay: headerDelay),
        HorizontalListView.separated(
          controller: scrollController,
          height: ProductItem.cardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _guidedProduct(
              product: product,
              index: index,
              includeTryOnStep: controller.isTryOnGuideTarget(
                product,
                fromRecommended: fromRecommended,
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 12),
        ),
      ],
    );
  }

  Widget _guidedProduct({
    required ProductBean product,
    required int index,
    required bool includeTryOnStep,
  }) {
    final card = SizedBox(
      width: ProductItem.cardWidth,
      height: ProductItem.cardHeight,
      child: ProductItem(
        product: product,
        animationIndex: index,
        isFavorite: product.isFavorite,
        onTap: () => controller.navigateToProductDetails(product),
        onFavoriteTap: () => controller.toggleFavorite(product),
      ),
    );

    if (!includeTryOnStep) return card;

    return KeyedSubtree(
      key: controller.tryOnProductKey,
      child: IntroStepBuilder(
        group: 'tryOn',
        order: 1,
        padding: EdgeInsets.zero,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        overlayBuilder: (params) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'tryOnGuideProductTitle'.tr}\n${'tryOnGuideProductDesc'.tr}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.4,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            IntroButton.fromConfig(
              config: IntroButtonConfig(
                text: 'guideNext'.tr,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
              onPressed: () {
                params.onFinish();
                controller.openTryOnGuideProduct();
              },
            ),
          ],
        ),
        builder: (context, key) => KeyedSubtree(key: key, child: card),
      ),
    );
  }
}
