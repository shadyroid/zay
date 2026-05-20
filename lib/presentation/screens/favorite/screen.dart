import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/favorite/controller.dart';
import 'package:hedma/presentation/widgets/empty_state.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorite'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.favorites.isEmpty
            ? EmptyState(message: 'emptyFavorites'.tr, icon: Icons.favorite_border)
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.favorites.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (_, i) {
                  final p = controller.favorites[i];
                  return ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(p.name),
                    subtitle: Text('\$${p.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => controller.removeFavorite(p),
                    ),
                    onTap: () => controller.navigateToProductDetails(p),
                  );
                },
              ),
      ),
    );
  }
}
