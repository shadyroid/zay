import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/presentation/screens/product_details/controller.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_description_section.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_details_app_bar.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_details_bottom_bar.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_details_header.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_image_carousel.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_reviews_section.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_seller_banner.dart';
import 'package:zay/presentation/screens/product_details/widgets/product_size_section.dart';
import 'package:zay/presentation/screens/product_details/widgets/similar_products_section.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

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
      appBar: ProductDetailsAppBar(onShare: controller.onShare),
      body: Obx(() {
        final product = controller.product.value;
        if (controller.isLoading.value && product == null) {
          return const Center(child: AppProgressIndicator());
        }
        if (product == null) return const SizedBox.shrink();

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProductImageCarousel(
                      images: product.images ?? [],
                      currentIndex: controller.imageIndex.value,
                      isFavorite: product.isFavorite,
                      onFavoriteTap: controller.toggleFavorite,
                      onPageChanged: controller.onImageChanged,
                    ),
                    ProductDetailsHeader(
                      name: product.name ?? "",
                      price: product.price,
                      originalPrice: product.originalPrice,
                      rating: product.rating ?? '5.0',
                      reviewCount: product.reviewCount ?? 0,
                      quantity: controller.quantity.value,
                      onIncrement: controller.incrementQuantity,
                      onDecrement: controller.decrementQuantity,
                    ).animateEntrance(
                      delay: const Duration(milliseconds: 60),
                    ),
                    ProductDescriptionSection(
                      description: product.description ?? '',
                      isExpanded: controller.isDescriptionExpanded.value,
                      onToggle: controller.toggleDescription,
                    ).animateEntrance(
                      delay: const Duration(milliseconds: 100),
                    ),
                    ProductSizeSection(
                      sizes: product.sizes,
                      selectedSizeId: controller.selectedSizeId.value,
                      onSizeSelected: controller.selectSize,
                      onSizeGuideTap: controller.openSizeGuide,
                    ).animateEntrance(
                      delay: const Duration(milliseconds: 140),
                    ),
                    ProductSellerBanner(
                      shopName: product.shop?.name ?? '',
                      slogan: product.shop?.slogan ?? "",
                      onTap: controller.navigateToShop,
                    ).animateEntrance(
                      delay: const Duration(milliseconds: 180),
                    ),
                    if (controller.similarProducts.isNotEmpty)
                      SimilarProductsSection(
                        products: controller.similarProducts,
                        onProductTap: controller.navigateToProduct,
                        onFavoriteTap: controller.toggleFavoriteFor,
                      ).animateEntrance(
                        delay: const Duration(milliseconds: 220),
                      ),
                    if (controller.reviews.isNotEmpty)
                      ProductReviewsSection(
                        reviews: controller.reviews,
                        onSeeAll: controller.onSeeAllReviews,
                      ).animateEntrance(
                        delay: const Duration(milliseconds: 260),
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _bottomBar(product),
          ],
        );
      }),
          ),
        );
      },
    );
  }

  Widget _bottomBar(ProductBean product) {
    final bar = ProductDetailsBottomBar(
      price: product.price,
      onTryOn: controller.onTryOn,
      isTryOnEnabled: product.category?.isTryOnEnabled,
      isTryOnLoading: controller.isTryOnLoading.value,
      isOutOfStock: product.isOutOfStock == true,
      onAddToCart: controller.addToCart,
      onTryOnIntroReady: controller.onTryOnIntroStepReady,
    );
    if (controller.skipBottomBarAnimation) return bar;
    return bar
        .animate()
        .slideY(
          begin: 0.3,
          end: 0,
          duration: AppMotion.normal,
          curve: AppMotion.standard,
        )
        .fadeIn(duration: AppMotion.normal);
  }
}
