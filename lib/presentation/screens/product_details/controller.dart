import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ProductDetailsController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final product = Rxn<ProductBean>();
  late final String productId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final passed = args['product'] as ProductBean?;
    productId = args['productId'] as String? ?? passed?.id ?? '';
    if (passed != null) {
      product.value = passed;
    }
    requestProductDetails();
  }

  Future<void> requestProductDetails() async {
    if (productId.isEmpty) return;
    isLoading.value = true;
    final response =
        await _productsUseCase.requestProductDetails(productId: productId);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    product.value = response.data;
  }

  void addToCart() {
    Get.rawSnackbar(message: 'addedToCart'.tr);
    Get.toNamed(Routes.cart);
  }

  void navigateToShop() {
    final shopId = product.value?.shopId;
    if (shopId == null) return;
    Get.toNamed(Routes.shopDetails, arguments: {'shopId': shopId});
  }
}
