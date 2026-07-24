import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/requests/product_id_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class FavoriteController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final favorites = <ProductBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestFavorites();
  }

  Future<void> requestFavorites() async {
    isLoading.value = true;
    final response = await _productsUseCase.requestFavorites();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    favorites.assignAll(response.data ?? []);
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  Future<void> removeFavorite(ProductBean product) async {
    final response = await _productsUseCase.requestUnFavorite(
      ProductIdRequest(productId: product.id),
    );
    if (!isSuccess(response)) return;
    favorites.removeWhere((p) => p.id == product.id);
  }

  
}
