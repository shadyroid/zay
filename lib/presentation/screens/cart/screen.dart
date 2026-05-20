import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/cart/controller.dart';
import 'package:hedma/presentation/screens/cart/widgets/cart_item.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/empty_state.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.items.isEmpty
            ? EmptyState(message: 'emptyCart'.tr, icon: Icons.shopping_cart_outlined)
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.items.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
                        return CartItem(
                          product: item,
                          onRemove: () => controller.removeItem(item),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('total'.tr,
                                style: Theme.of(context).textTheme.titleLarge),
                            Text('\$${controller.total.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AppButton(text: 'checkout'.tr, onPressed: controller.checkout),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 2),
    );
  }
}
