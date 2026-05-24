import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/presentation/screens/home/widgets/home_product_item.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({
    super.key,
    required this.products,
    required this.shopNameFor,
    required this.onProductTap,
    required this.onFavoriteTap,
  });

  final List<ProductBean> products;
  final String Function(ProductBean) shopNameFor;
  final ValueChanged<ProductBean> onProductTap;
  final ValueChanged<ProductBean> onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    final favorites = Get.find<FavoriteProductsService>();
    final favoriteIds = favorites.favoriteIds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'similarTo'.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        SizedBox(
          height: HomeProductItem.listHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return HomeProductItem(
                product: product,
                shopName: shopNameFor(product),
                isFavorite:
                    favoriteIds.contains(product.id) || product.isFavorite,
                onTap: () => onProductTap(product),
                onFavoriteTap: () => onFavoriteTap(product),
              );
            },
          ),
        ),
      ],
    );
  }
}
