import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/product_details/controller.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_description_section.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_details_app_bar.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_details_bottom_bar.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_details_header.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_image_carousel.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_reviews_section.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_seller_banner.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_size_guide_table.dart';
import 'package:hedma/presentation/screens/product_details/widgets/product_size_section.dart';
import 'package:hedma/presentation/screens/product_details/widgets/similar_products_section.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProductDetailsAppBar(
        onShare: controller.onShare,
      ),
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
                controller: controller.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProductImageCarousel(
                      images: product.galleryImages,
                      currentIndex: controller.imageIndex.value,
                      isFavorite: product.isFavorite,
                      onFavoriteTap: controller.toggleFavorite,
                      onPageChanged: controller.onImageChanged,
                    ),
                    ProductDetailsHeader(
                      name: product.name,
                      price: product.price,
                      rating: product.rating ?? '5.0',
                      reviewCount: product.reviewCount ?? 0,
                      quantity: controller.quantity.value,
                      onIncrement: controller.incrementQuantity,
                      onDecrement: controller.decrementQuantity,
                    ),
                    ProductDescriptionSection(
                      description: product.description ?? '',
                      isExpanded: controller.isDescriptionExpanded.value,
                      onToggle: controller.toggleDescription,
                    ),
                    ProductSizeSection(
                      sizes: product.sizes,
                      selectedSizeId: controller.selectedSizeId.value,
                      onSizeSelected: controller.selectSize,
                      onSizeGuideTap: controller.scrollToSizeGuide,
                    ),
                    ProductSellerBanner(
                      shopName: product.shopName ?? '',
                      categories: product.sellerCategories ?? '',
                      onTap: controller.navigateToShop,
                    ),
                    KeyedSubtree(
                      key: controller.sizeGuideKey,
                      child: ProductSizeGuideTable(sizes: product.sizes),
                    ),
                    SimilarProductsSection(
                      products: controller.similarProducts,
                      shopNameFor: (p) => p.shopName ?? '',
                      onProductTap: controller.navigateToProduct,
                      onFavoriteTap: controller.toggleFavoriteFor,
                    ),
                    ProductReviewsSection(
                      reviews: controller.reviews,
                      onSeeAll: controller.onSeeAllReviews,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            ProductDetailsBottomBar(
              price: product.price,
              onTryOn: controller.onTryOn,
              onAddToCart: controller.addToCart,
            ),
          ],
        );
      }),
    );
  }
}
