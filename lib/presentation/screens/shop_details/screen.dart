import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/shop_details/controller.dart';

class ShopDetailsScreen extends GetView<ShopDetailsController> {
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.shop.value?.name ?? 'shops'.tr)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(controller.shop.value?.description ?? '',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            Text('products'.tr, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...controller.products.map(
              (p) => ListTile(
                title: Text(p.name),
                subtitle: Text('\$${p.price}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => controller.navigateToProductDetails(p),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
