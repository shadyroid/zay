import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/presentation/widgets/horizontal_list_view.dart';
import 'package:zay/presentation/widgets/product_item.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({
    super.key,
    required this.products,
    required this.onProductTap,
    required this.onFavoriteTap,
  });

  final List<ProductBean> products;
  final ValueChanged<ProductBean> onProductTap;
  final ValueChanged<ProductBean> onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'similarTo'.tr,
            style: Get.theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        HorizontalListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return SizedBox(
              width: 150,
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
