import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/presentation/screens/home/widgets/home_section_header.dart';
import 'package:zay/presentation/widgets/horizontal_list_view.dart';
import 'package:zay/presentation/widgets/product_item.dart';

class HomeProductSections extends StatelessWidget {
  const HomeProductSections({
    super.key,
    required this.recommendedProducts,
    required this.newArrivalProducts,
    required this.onProductTap,
    required this.onFavoriteTap,
    this.onSeeAllRecommended,
    this.onSeeAllNewArrival,
    this.excludeProductId,
  });

  final List<ProductBean> recommendedProducts;
  final List<ProductBean> newArrivalProducts;
  final ValueChanged<ProductBean> onProductTap;
  final ValueChanged<ProductBean> onFavoriteTap;
  final VoidCallback? onSeeAllRecommended;
  final VoidCallback? onSeeAllNewArrival;
  final int? excludeProductId;

  List<ProductBean> _filtered(List<ProductBean> products) {
    if (excludeProductId == null) return products;
    return products.where((p) => p.id != excludeProductId).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recommended = _filtered(recommendedProducts);
    final newArrivals = _filtered(newArrivalProducts);
    if (recommended.isEmpty && newArrivals.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (recommended.isNotEmpty)
          _HomeProductsRow(
            title: 'recommendedForYou'.tr,
            products: recommended,
            onSeeAll: onSeeAllRecommended,
            onProductTap: onProductTap,
            onFavoriteTap: onFavoriteTap,
          ),
        if (newArrivals.isNotEmpty)
          _HomeProductsRow(
            title: 'newArrival'.tr,
            products: newArrivals,
            onSeeAll: onSeeAllNewArrival,
            onProductTap: onProductTap,
            onFavoriteTap: onFavoriteTap,
          ),
      ],
    );
  }
}

class _HomeProductsRow extends StatelessWidget {
  const _HomeProductsRow({
    required this.title,
    required this.products,
    required this.onProductTap,
    required this.onFavoriteTap,
    this.onSeeAll,
  });

  final String title;
  final List<ProductBean> products;
  final VoidCallback? onSeeAll;
  final ValueChanged<ProductBean> onProductTap;
  final ValueChanged<ProductBean> onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionHeader(title: title, onSeeAll: onSeeAll),
        HorizontalListView.separated(
          height: ProductItem.cardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return SizedBox(
              width: ProductItem.cardWidth,
              height: ProductItem.cardHeight,
              child: ProductItem(
                product: product,
                isFavorite: product.isFavorite,
                onTap: () => onProductTap(product),
                onFavoriteTap: () => onFavoriteTap(product),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 12),
        ),
      ],
    );
  }
}
