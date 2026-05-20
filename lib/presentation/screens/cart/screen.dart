import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/cart/controller.dart';
import 'package:hedma/presentation/screens/cart/widgets/cart_bottom_bar.dart';
import 'package:hedma/presentation/screens/cart/widgets/cart_delivery_section.dart';
import 'package:hedma/presentation/screens/cart/widgets/cart_item.dart';
import 'package:hedma/presentation/screens/cart/widgets/cart_payment_section.dart';
import 'package:hedma/presentation/screens/cart/widgets/cart_price_summary.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/empty_state.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        onBack: controller.goBack,
        title: 'cart'.tr,
        showDivider: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.items.isEmpty) {
          return EmptyState(
            message: 'emptyCart'.tr,
            icon: Icons.shopping_cart_outlined,
          );
        }

        final itemCount = controller.itemCount;
        final subtotal = controller.subtotal;
        final shipping = CartController.shippingFee;
        final total = controller.total;
        final paymentMethod = controller.paymentMethod.value;
        final deliveryAddress = controller.deliveryAddress.value;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        children: controller.items
                            .map(
                              (item) => CartItem(
                                item: item,
                                onRemove: () => controller.removeItem(item),
                                onIncrement: () =>
                                    controller.incrementQuantity(item),
                                onDecrement: () =>
                                    controller.decrementQuantity(item),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    CartDeliverySection(
                      locationText: deliveryAddress,
                      mobileController: controller.mobileController,
                      onSelectLocation: controller.onSelectLocation,
                    ),
                    CartPaymentSection(
                      selectedMethod: paymentMethod,
                      onMethodSelected: controller.selectPaymentMethod,
                    ),
                    CartPriceSummary(
                      itemCount: itemCount,
                      subtotal: subtotal,
                      shipping: shipping,
                      total: total,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            CartBottomBar(
              total: total,
              isLoading: controller.isLoading.value,
              onPayNow: controller.onPayNow,
            ),
          ],
        );
      }),
      bottomNavigationBar: const MainBottomNav(currentIndex: 2),
    );
  }
}
