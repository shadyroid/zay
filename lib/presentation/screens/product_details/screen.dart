import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/screens/product_details/controller.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_button.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Get.find<FavoriteProductsService>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        onBack: controller.goBack,
        title: 'productDetails'.tr,
        showDivider: true,
        actions: [
          Obx(
            () {
              final product = controller.product.value;
              if (product == null) return const SizedBox.shrink();
              final isFavorite = favorites.isFavoriteProduct(product);
              return IconButton(
                icon: SvgPicture.asset(
                  isFavorite ? AppIcons.heartFilled : AppIcons.favorite,
                  width: 22,
                  height: 22,
                ),
                onPressed: controller.toggleFavorite,
              );
            },
          ),
        ],
      ),
      body: Obx(
        () {
          final product = controller.product.value;
          if (controller.isLoading.value && product == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (product == null) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                      ? Image.network(
                          product.imageUrl!,
                          height: 280,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 280,
                          color: AppColors.screenBackground,
                          child: Center(
                            child: SvgPicture.asset(
                              AppIcons.productPlaceholder,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 24),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                if (product.shopId != null)
                  TextButton(
                    onPressed: controller.navigateToShop,
                    child: Text('viewShop'.tr),
                  ),
                const Spacer(),
                AppButton(
                  text: 'addToCart'.tr,
                  onPressed: controller.addToCart,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
