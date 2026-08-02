import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/auth_use_case.dart';
import 'package:zay/app/use_cases/cart_use_case.dart';
import 'package:zay/app/use_cases/cities_use_case.dart';
import 'package:zay/app/use_cases/order_use_case.dart';
import 'package:zay/app/utils/address_city_area_parser.dart';
import 'package:zay/app/utils/egyptian_phone_util.dart';
import 'package:zay/app/utils/payment_method.dart';
import 'package:zay/domain/models/beans/cart_item_bean.dart';
import 'package:zay/domain/models/beans/city_bean.dart';
import 'package:zay/domain/models/beans/location_bean.dart';
import 'package:zay/domain/models/requests/create_order_request.dart';
import 'package:zay/domain/models/requests/delete_cart_item_request.dart';
import 'package:zay/domain/models/requests/summary_request.dart';
import 'package:zay/domain/models/requests/update_cart_item_request.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:zay/presentation/bottom_sheets/city_area/city_area_bottom_sheet.dart';

class CartController extends BaseController {
  final CartUseCase _cartUseCase = Get.put(CartUseCase());
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());
  final CitiesUseCase _citiesUseCase = Get.put(CitiesUseCase());

  final deliveryFormKey = GlobalKey<FormState>();
  final items = <CartItemBean>[].obs;
  final mobileController = TextEditingController();
  String _recipientName = '';
  final deliveryAddress = RxnString();
  final deliveryLatitude = RxnDouble();
  final deliveryLongitude = RxnDouble();
  final deliveryCity = RxnString();
  final deliveryCityName = RxnString();
  final deliveryArea = RxnString();
  final paymentMethod = PaymentMethod.cash.obs;
  final shippingFee = 0.0.obs;

  List<CityBean> _cities = [];

  @override
  void onInit() {
    super.onInit();
    requestCart();
    _loadProfile();
    _loadCities();
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

  Future<void> _loadCities() async {
    final response = await _citiesUseCase.requestCities();
    if (!isSuccess(response)) return;
    _cities = response.data ?? [];
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
    requestSummary();
  }

  Future<void> onSelectLocation() async {
    final result = await Get.toNamed(Routes.map);
    if (result is! LocationBean) return;

    deliveryAddress.value = result.address;
    deliveryLatitude.value = result.lat;
    deliveryLongitude.value = result.lng;

    if (_cities.isEmpty) {
      await _loadCities();
    }

    final resolved = AddressCityAreaParser.resolve(
      address: result.address,
      cities: _cities,
      addressComponents: result.addressComponents,
    );

    CityBean? city = resolved.city;
    String? area = resolved.area?.trim();

    if (city == null || area == null || area.isEmpty) {
      final manual = await CityAreaBottomSheet.show(
        cities: _cities,
        initialCity: city,
        initialArea: area,
      );
      if (manual == null) {
        _clearDeliveryLocation();
        return;
      }
      city = manual.city;
      area = manual.area;
    }

    _setDeliveryCity(city);
    deliveryArea.value = area;
    await requestSummary();
  }

  void _setDeliveryCity(CityBean city) {
    deliveryCity.value = city.code;
    deliveryCityName.value = city.name.isNotEmpty ? city.name : city.nameAr;
  }

  void _clearDeliveryLocation() {
    deliveryAddress.value = null;
    deliveryLatitude.value = null;
    deliveryLongitude.value = null;
    deliveryCity.value = null;
    deliveryCityName.value = null;
    deliveryArea.value = null;
    shippingFee.value = 0;
  }

  Future<void> requestSummary() async {
    final lat = deliveryLatitude.value;
    final lng = deliveryLongitude.value;
    final address = deliveryAddress.value?.trim();
    final city = deliveryCityName.value?.trim();
    final area = deliveryArea.value?.trim();

    if (lat == null ||
        lng == null ||
        address == null ||
        address.isEmpty ||
        city == null ||
        city.isEmpty ||
        area == null ||
        area.isEmpty) {
      return;
    }

    final response = await _orderUseCase.requestSummary(
      SummaryRequest(
        lat: lat,
        lng: lng,
        address: address,
        city: city,
        area: area,
        paymentMethod: paymentMethod.value.apiValue,
      ),
    );
    if (!isSuccess(response)) {
      shippingFee.value = 0;
      return;
    }
    shippingFee.value = response.shippingFee ?? 0;
  }

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  double get total => subtotal + shippingFee.value;

  Future<void> onPayNow() async {
    if (items.isEmpty) return;

    final address = deliveryAddress.value?.trim();
    if (address == null || address.isEmpty) {
      Get.rawSnackbar(message: 'selectLocationRequired'.tr);
      return;
    }

    var city = deliveryCity.value?.trim();
    var area = deliveryArea.value?.trim();
    if (city == null || city.isEmpty || area == null || area.isEmpty) {
      if (_cities.isEmpty) await _loadCities();
      CityBean? initialCity;
      for (final c in _cities) {
        if (c.code == city) {
          initialCity = c;
          break;
        }
      }
      final manual = await CityAreaBottomSheet.show(
        cities: _cities,
        initialCity: initialCity,
        initialArea: area,
      );
      if (manual == null) return;
      _setDeliveryCity(manual.city);
      city = manual.city.code;
      area = manual.area;
      deliveryArea.value = area;
      await requestSummary();
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
        city: city,
        area: area,
        phone: phone,
        recipientName: _recipientName,
        paymentMethod: paymentMethod.value.apiValue,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.offNamed(
      Routes.orderSuccess,
      arguments: {'paymentMethod': paymentMethod.value.apiValue},
    );
  }
}
