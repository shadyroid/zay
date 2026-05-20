import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/product_details/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('productDetails'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () {
          final product = controller.product.value;
          if (product == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.image_outlined, size: 80),
                ),
                const SizedBox(height: 24),
                Text(product.name,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text('\$${product.price}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 16),
                if (product.shopId != null)
                  TextButton(
                    onPressed: controller.navigateToShop,
                    child: Text('viewShop'.tr),
                  ),
                const Spacer(),
                AppButton(text: 'addToCart'.tr, onPressed: controller.addToCart),
              ],
            ),
          );
        },
      ),
    );
  }
}
