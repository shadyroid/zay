import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/presentation/screens/cart/controller.dart';
import 'package:zay/presentation/screens/cart/widgets/cart_bottom_bar.dart';
import 'package:zay/presentation/screens/cart/widgets/cart_delivery_section.dart';
import 'package:zay/presentation/screens/cart/widgets/cart_item.dart';
import 'package:zay/presentation/screens/cart/widgets/cart_payment_section.dart';
import 'package:zay/presentation/screens/cart/widgets/cart_price_summary.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';
import 'package:zay/presentation/widgets/empty_state.dart';
import 'package:zay/presentation/widgets/main_bottom_nav.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'cart'.tr,
        showDivider: true,
      ),
      body: Obx(() {
        Widget child;
        if (controller.isLoading.value && controller.items.isEmpty) {
          child = const Center(
            key: ValueKey('cart-loading'),
            child: AppProgressIndicator(),
          );
        } else if (controller.items.isEmpty) {
          child = EmptyState(
            key: const ValueKey('cart-empty'),
            message: 'emptyCart'.tr,
            icon: Icons.shopping_cart_outlined,
          );
        } else {
          final itemCount = controller.itemCount;
          final subtotal = controller.subtotal;
          final shipping = controller.shippingFee.value;
          final total = controller.total;
          final paymentMethod = controller.paymentMethod.value;
          final deliveryAddress = controller.deliveryAddress.value;

          child = Column(
            key: const ValueKey('cart-content'),
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          children: [
                            for (var i = 0; i < controller.items.length; i++)
                              CartItem(
                                item: controller.items[i],
                                animationIndex: i,
                                onRemove: () =>
                                    controller.removeItem(controller.items[i]),
                                onIncrement: () => controller
                                    .incrementQuantity(controller.items[i]),
                                onDecrement: () => controller
                                    .decrementQuantity(controller.items[i]),
                              ),
                          ],
                        ),
                      ),
                      CartDeliverySection(
                        formKey: controller.deliveryFormKey,
                        locationText: deliveryAddress,
                        mobileController: controller.mobileController,
                        onSelectLocation: controller.onSelectLocation,
                      ).animateEntrance(
                        delay: const Duration(milliseconds: 80),
                      ),
                      CartPaymentSection(
                        selectedMethod: paymentMethod,
                        onMethodSelected: controller.selectPaymentMethod,
                      ).animateEntrance(
                        delay: const Duration(milliseconds: 120),
                      ),
                      CartPriceSummary(
                        itemCount: itemCount,
                        subtotal: subtotal,
                        shipping: shipping,
                        total: total,
                      ).animateEntrance(
                        delay: const Duration(milliseconds: 160),
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
        }

        return AnimatedStateSwitcher(child: child);
      }),
      bottomNavigationBar: const MainBottomNav(currentIndex: 2),
    );
  }
}
