import 'package:get/get.dart';
import 'package:hedma/app/use_cases/cart_use_case.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class CartController extends BaseController {
  final CartUseCase _cartUseCase = Get.put(CartUseCase());

  final items = <ProductBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestCart();
  }

  Future<void> requestCart() async {
    isLoading.value = true;
    final response = await _cartUseCase.requestCart();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    items.assignAll(response.data ?? []);
  }

  Future<void> removeItem(ProductBean item) async {
    isLoading.value = true;
    final response =
        await _cartUseCase.requestRemoveFromCart(productId: item.id);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    items.assignAll(response.data ?? []);
  }

  double get total =>
      items.fold(0, (sum, item) => sum + (double.tryParse(item.price) ?? 0));

  Future<void> checkout() async {
    isLoading.value = true;
    final response = await _cartUseCase.requestCheckout();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    Get.rawSnackbar(message: response.message?.tr ?? 'checkoutSuccess'.tr);
  }
}
