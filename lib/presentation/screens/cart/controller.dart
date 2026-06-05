import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/app/use_cases/cart_use_case.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/app/utils/egyptian_phone_util.dart';
import 'package:hedma/app/utils/payment_method.dart';
import 'package:hedma/domain/models/beans/cart_item_bean.dart';
import 'package:hedma/domain/models/beans/location_bean.dart';
import 'package:hedma/domain/requests/create_order_request.dart';
import 'package:hedma/domain/requests/delete_cart_item_request.dart';
import 'package:hedma/domain/requests/update_cart_item_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class CartController extends BaseController {
  final CartUseCase _cartUseCase = Get.put(CartUseCase());
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final deliveryFormKey = GlobalKey<FormState>();
  final items = <CartItemBean>[].obs;
  final mobileController = TextEditingController();
  String _recipientName = '';
  final deliveryAddress = RxnString();
  final deliveryLatitude = RxnDouble();
  final deliveryLongitude = RxnDouble();
  final paymentMethod = PaymentMethod.cash.obs;

  static const double shippingFee = 0;

  @override
  void onInit() {
    super.onInit();
    requestCart();
    _loadProfile();
  }

  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }

  Future<void> _loadProfile() async {
    final response = await _authUseCase.requestProfile();
    if (!response.isSuccess) return;

    final phone = response.data?.phone?.trim();
    if (phone != null && phone.isNotEmpty) {
      mobileController.text = phone;
    }

    final name = response.data?.name?.trim();
    if (name != null && name.isNotEmpty) {
      _recipientName = name;
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
    final response = await _cartUseCase.requestDeleteCartItem(
      DeleteCartItemRequest(cartItemId: item.id),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    items.assignAll(response.data ?? []);
  }

  Future<void> incrementQuantity(CartItemBean item) async {
    await _updateItemQuantity(item, item.quantity + 1);
  }

  Future<void> decrementQuantity(CartItemBean item) async {
    if (item.quantity <= 1) return;
    await _updateItemQuantity(item, item.quantity - 1);
  }

  Future<void> _updateItemQuantity(CartItemBean item, int quantity) async {
    isLoading.value = true;
    final response = await _cartUseCase.requestUpdateCartItem(
      UpdateCartItemRequest(cartItemId: item.id, quantity: quantity),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    items.assignAll(response.data ?? []);
  }

  void selectPaymentMethod(PaymentMethod method) {
    paymentMethod.value = method;
  }

  Future<void> onSelectLocation() async {
    // deliveryAddress.value = "asdasdsadasd";
    // deliveryLatitude.value = 0.0;
    // deliveryLongitude.value = 0.0;
    // return;
    final result = await Get.toNamed(Routes.map);
    if (result is! LocationBean) return;

    deliveryAddress.value = result.address;
    deliveryLatitude.value = result.lat;
    deliveryLongitude.value = result.lng;
  }

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  double get total => subtotal + shippingFee;

  Future<void> onPayNow() async {
    if (items.isEmpty) return;

    final address = deliveryAddress.value?.trim();
    if (address == null || address.isEmpty) {
      Get.rawSnackbar(message: 'selectLocationRequired'.tr);
      return;
    }

    if (deliveryFormKey.currentState?.validate() != true) return;

    final phone = EgyptianPhoneUtil.normalize(mobileController.text.trim())!;

    final lat = deliveryLatitude.value;
    final lng = deliveryLongitude.value;
    if (lat == null || lng == null) {
      Get.rawSnackbar(message: 'selectLocationRequired'.tr);
      return;
    }

    isLoading.value = true;
    final response = await _orderUseCase.requestCreateOrder(
      CreateOrderRequest(
        lat: lat,
        lng: lng,
        address: address,
        phone: phone,
        recipientName: _recipientName,
        paymentMethod: paymentMethod.value.apiValue,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.offNamed(Routes.orderSuccess);
  }
}
