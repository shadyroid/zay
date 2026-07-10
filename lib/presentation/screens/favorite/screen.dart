import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/presentation/screens/favorite/controller.dart';
import 'package:zay/presentation/screens/favorite/widgets/favorite_empty_state.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';
import 'package:zay/presentation/widgets/product_item.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'favoriteTitle'.tr,
        showDivider: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: AppProgressIndicator());
          }
          if (controller.favorites.isEmpty) {
            return const FavoriteEmptyState();
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: controller.favorites.length,
            itemBuilder: (context, index) {
              final product = controller.favorites[index];
              return ProductItem(
                product: product,
                isFavorite: product.isFavorite,
                onTap: () => controller.navigateToProductDetails(product),
                onFavoriteTap: () => controller.removeFavorite(product),
              );
            },
          );
        },
      ),
    );
  }
}
