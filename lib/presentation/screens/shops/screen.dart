import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/shops/controller.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';

class ShopsScreen extends GetView<ShopsController> {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shops'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.shops.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final shop = controller.shops[i];
            return Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.store)),
                title: Text(shop.name),
                subtitle: Text(shop.description ?? ''),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => controller.navigateToShopDetails(shop),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 1),
    );
  }
}
