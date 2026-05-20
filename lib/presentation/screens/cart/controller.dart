import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/app/use_cases/cart_use_case.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/app/utils/payment_method.dart';
import 'package:hedma/domain/models/beans/cart_item_bean.dart';
import 'package:hedma/domain/models/beans/delivery_location.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class CartController extends BaseController {
  final CartUseCase _cartUseCase = Get.put(CartUseCase());
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final items = <CartItemBean>[].obs;
  final mobileController = TextEditingController();
  final deliveryAddress = RxnString();
  final deliveryLatitude = RxnDouble();
  final deliveryLongitude = RxnDouble();
  final paymentMethod = PaymentMethod.cash.obs;

  static const double shippingFee = 0;

  @override
  void onInit() {
    super.onInit();
    requestCart();
    _loadProfilePhone();
  }

  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }

  Future<void> _loadProfilePhone() async {
    final response = await _authUseCase.requestProfile();
    if (!response.isSuccess) return;
    final phone = response.data?.phone?.trim();
    if (phone != null && phone.isNotEmpty) {
      mobileController.text = phone;
    }
  }

  Future<void> requestCart() async {
    isLoading.value = true;
    final response = await _cartUseCase.requestCart();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    items.assignAll(response.data ?? []);
  }

  Future<void> removeItem(CartItemBean item) async {
    isLoading.value = true;
    final response =
        await _cartUseCase.requestRemoveFromCart(productId: item.id);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    items.assignAll(response.data ?? []);
  }

  void incrementQuantity(CartItemBean item) {
    final index = items.indexWhere((i) => i.id == item.id);
    if (index < 0) return;
    items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
  }

  void decrementQuantity(CartItemBean item) {
    final index = items.indexWhere((i) => i.id == item.id);
    if (index < 0 || items[index].quantity <= 1) return;
    items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
  }

  void selectPaymentMethod(PaymentMethod method) {
    paymentMethod.value = method;
  }

  Future<void> onSelectLocation() async {
    final result = await Get.toNamed(Routes.map);
    if (result == null) return;
    final location = DeliveryLocation.fromMap(result);
    deliveryAddress.value = location.address;
    deliveryLatitude.value = location.latitude;
    deliveryLongitude.value = location.longitude;
  }

  int get itemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.lineTotal);

  double get total => subtotal + shippingFee;

  Future<void> onPayNow() async {
    if (items.isEmpty) return;

    final address = deliveryAddress.value?.trim();
    if (address == null || address.isEmpty) {
      Get.rawSnackbar(message: 'selectLocationRequired'.tr);
      return;
    }

    final phone = mobileController.text.trim();
    if (phone.isEmpty) {
      Get.rawSnackbar(message: 'mobileRequired'.tr);
      return;
    }

    isLoading.value = true;
    final response = await _orderUseCase.requestCreateOrder(
      address: address,
      latitude: deliveryLatitude.value ?? 0,
      longitude: deliveryLongitude.value ?? 0,
      mobileNumber: phone,
      paymentMethod: paymentMethod.value.name,
      items: items
          .map(
            (item) => {
              'productId': item.id,
              'quantity': item.quantity,
              'sizeLabel': item.sizeLabel,
              'price': item.price,
            },
          )
          .toList(),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.offNamed(
      Routes.orderSuccess,
      arguments: {'orderId': response.data?.id ?? ''},
    );
  }

  void goBack() => Get.back();
}
