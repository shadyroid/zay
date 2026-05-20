import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ProductsController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final products = <ProductBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestProducts();
  }

  Future<void> requestProducts() async {
    isLoading.value = true;
    final response = await _productsUseCase.requestProducts();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    products.assignAll(response.data ?? []);
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }
}
