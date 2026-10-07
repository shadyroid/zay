import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/auth_use_case.dart';
import 'package:zay/app/use_cases/cart_use_case.dart';
import 'package:zay/app/use_cases/cities_use_case.dart';
import 'package:zay/app/use_cases/order_use_case.dart';
import 'package:zay/app/utils/address_city_matcher.dart';
import 'package:zay/app/utils/egyptian_phone_util.dart';
import 'package:zay/app/utils/payment_browser.dart';
import 'package:zay/domain/models/enums/payment_method.dart';
import 'package:zay/domain/models/beans/cart_item_bean.dart';
import 'package:zay/domain/models/beans/city_bean.dart';
import 'package:zay/domain/models/beans/coupon_bean.dart';
import 'package:zay/domain/models/beans/location_bean.dart';
import 'package:zay/domain/models/requests/create_order_request.dart';
import 'package:zay/domain/models/requests/delete_cart_item_request.dart';
import 'package:zay/domain/models/requests/payment_request.dart';
import 'package:zay/domain/models/requests/summary_request.dart';
import 'package:zay/domain/models/requests/update_cart_item_request.dart';
import 'package:zay/domain/models/requests/validate_coupon_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class CartController extends BaseController {
  final CartUseCase _cartUseCase = Get.put(CartUseCase());
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());
  final CitiesUseCase _citiesUseCase = Get.put(CitiesUseCase());

  final deliveryFormKey = GlobalKey<FormState>();
  final items = <CartItemBean>[].obs;
  final mobileController = TextEditingController();
  final couponController = TextEditingController();
  String _recipientName = '';
  final deliveryAddress = RxnString();
  final deliveryLatitude = RxnDouble();
  final deliveryLongitude = RxnDouble();
  final cities = <CityBean>[].obs;
  final selectedCity = Rxn<CityBean>();
  final showCityPicker = false.obs;
  final paymentMethod = PaymentMethod.cash.obs;
  final shippingFee = 0.0.obs;
  final appliedCoupon = Rxn<CouponBean>();
  final isValidatingCoupon = false.obs;

  @override
  void onInit() {
    super.onInit();
    requestCart();
    requestProfile();
    requestCities();
  }

  @override
  void onClose() {
    mobileController.dispose();
    couponController.dispose();
    super.onClose();
  }

  Future<void> requestProfile() async {
    final response = await _authUseCase.requestProfile();
    if (!response.isSuccess) return;
    mobileController.text = response.data?.phone ?? "";
    _recipientName = response.data?.name ?? "";
  }

  Future<void> requestCities() async {
    final response = await _citiesUseCase.requestCities();
    if (!isSuccess(response)) return;
    cities.assignAll(response.data ?? []);

    final current = selectedCity.value;
    if (current == null) return;
    CityBean? matched;
    for (final city in cities) {
      if (city.id == current.id) {
        matched = city;
        break;
      }
    }
    selectedCity.value = matched;
    if (matched == null) {
      shippingFee.value = 0;
      if (deliveryAddress.value?.trim().isNotEmpty == true) {
        showCityPicker.value = true;
      }
    }
  }

  Future<void> requestCart() async {
    isLoading.value = true;
    final response = await _cartUseCase.requestCart();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    await _setItems(response.data ?? []);
  }

  Future<void> removeItem(CartItemBean item) async {
    isLoading.value = true;
    final response = await _cartUseCase.requestDeleteCartItem(
      DeleteCartItemRequest(cartItemId: item.id),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    await _setItems(response.data ?? []);
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
    await _setItems(response.data ?? []);
  }

  void selectPaymentMethod(PaymentMethod method) {
    paymentMethod.value = method;
    requestSummary();
  }

  void selectCity(CityBean? city) {
    selectedCity.value = city;
    if (city == null) {
      shippingFee.value = 0;
      return;
    }
    requestSummary();
  }

  Future<void> onSelectLocation() async {
    final result = await Get.toNamed(Routes.map);
    if (result is! LocationBean) return;

    deliveryAddress.value = result.address;
    deliveryLatitude.value = result.lat;
    deliveryLongitude.value = result.lng;

    if (cities.isEmpty) {
      await requestCities();
    }

    final city = AddressCityMatcher.match(
      address: result.address,
      cities: cities,
      addressComponents: result.addressComponents,
    );

    if (city == null) {
      selectedCity.value = null;
      showCityPicker.value = true;
      shippingFee.value = 0;
      return;
    }

    selectedCity.value = city;
    showCityPicker.value = false;
    await requestSummary();
  }

  Future<void> requestSummary() async {
    final cityId = selectedCity.value?.id;
    if (cityId == null || cityId <= 0) return;

    final response = await _orderUseCase.requestSummary(
      SummaryRequest(
        cityId: cityId,
        paymentMethod: paymentMethod.value.apiValue,
      ),
    );
    if (!isSuccess(response)) {
      shippingFee.value = 0;
      if (response.statusCode == 422) {
        showCityPicker.value = true;
        await requestCities();
      }
      return;
    }
    shippingFee.value = response.shippingFee ?? 0;
  }

  Future<void> requestValidateCoupon() async {
    final code = couponController.text.trim();
    if (code.isEmpty) {
      Get.rawSnackbar(message: 'couponRequired'.tr);
      return;
    }

    isValidatingCoupon.value = true;
    final response = await _orderUseCase.requestValidateCoupon(
      ValidateCouponRequest(code: code),
    );
    isValidatingCoupon.value = false;
    if (!isSuccess(response) || response.coupon == null) {
      appliedCoupon.value = null;
      return;
    }
    appliedCoupon.value = response.coupon;
    couponController.text = response.coupon!.code;
  }

  void removeCoupon() {
    appliedCoupon.value = null;
    couponController.clear();
  }

  Future<void> _setItems(List<CartItemBean> updated) async {
    items.assignAll(updated);
    if (items.isEmpty) {
      appliedCoupon.value = null;
      couponController.clear();
      return;
    }
    await _refreshAppliedCoupon();
  }

  Future<void> _refreshAppliedCoupon() async {
    final coupon = appliedCoupon.value;
    if (coupon == null) return;

    final response = await _orderUseCase.requestValidateCoupon(
      ValidateCouponRequest(code: coupon.code),
    );
    if (!isSuccess(response) || response.coupon == null) {
      appliedCoupon.value = null;
      return;
    }
    appliedCoupon.value = response.coupon;
  }

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  double get discount => appliedCoupon.value?.discountAmount ?? 0;

  double get total => (subtotal-(appliedCoupon.value?.discountAmount??0)) + shippingFee.value;

  Future<void> onPayNow() async {
    if (items.isEmpty) return;

    if (cities.isEmpty) {
      await requestCities();
    }

    if (deliveryFormKey.currentState?.validate() != true) return;

    final address = deliveryAddress.value?.trim();
    if (address == null || address.isEmpty) {
      Get.rawSnackbar(message: 'selectLocationRequired'.tr);
      return;
    }

    final city = selectedCity.value;
    if (city == null || city.id <= 0) {
      showCityPicker.value = true;
      Get.rawSnackbar(message: 'cityRequired'.tr);
      return;
    }

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
        cityId: city.id,
        phone: phone,
        recipientName: _recipientName,
        paymentMethod: paymentMethod.value.apiValue,
        couponCode: appliedCoupon.value?.code,
      ),
    );

    if (!isSuccess(response)) {
      isLoading.value = false;
      if (response.statusCode == 422) {
        showCityPicker.value = true;
        await requestCities();
      }
      return;
    }

    var paymentStatus = response.paymentStatus;
    final paymentUrl = response.paymentUrl;
    final orderId = response.data?.id;

    if (paymentMethod.value == PaymentMethod.card &&
        paymentUrl != null &&
        paymentUrl.isNotEmpty &&
        orderId != null) {
      isLoading.value = false;
      final opened = await PaymentBrowser.openAndWaitForReturn(paymentUrl);
      if (!opened) {
        Get.rawSnackbar(message: 'paymentLinkOpenFailed'.tr);
      }

      isLoading.value = true;
      final statusResponse = await _orderUseCase.requestPaymentStatus(
        PaymentRequest(orderId: orderId),
      );
      isLoading.value = false;
      if (isSuccess(statusResponse)) {
        paymentStatus = statusResponse.paymentStatus;
      }
    } else {
      isLoading.value = false;
    }

    Get.offNamed(
      Routes.orderSuccess,
      arguments: {
        'paymentMethod': paymentMethod.value.apiValue,
        'paymentStatus': paymentStatus,
      },
    );
  }
}
