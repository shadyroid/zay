import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/products/controller.dart';

class ProductsScreen extends GetView<ProductsController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('products'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.products.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final p = controller.products[i];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              title: Text(p.name),
              subtitle: Text('\$${p.price}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => controller.navigateToProductDetails(p),
            );
          },
        ),
      ),
    );
  }
}
