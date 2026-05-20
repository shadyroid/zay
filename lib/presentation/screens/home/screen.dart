import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/home/controller.dart';
import 'package:hedma/presentation/screens/home/widgets/product_card.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appName'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: controller.navigateToOrders,
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('featuredProducts'.tr,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.products.length,
              itemBuilder: (context, index) => ProductCard(
                product: controller.products[index],
                onTap: () => controller.navigateToProductDetails(
                  controller.products[index],
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: controller.navigateToProducts,
              child: Text('viewAllProducts'.tr),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: controller.navigateToShops,
              child: Text('viewAllShops'.tr),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 0),
    );
  }
}
