import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class FavoriteController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final FavoriteProductsService _favorites = Get.find<FavoriteProductsService>();

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
    _favorites.favoriteIds.assignAll(favorites.map((p) => p.id));
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  Future<void> removeFavorite(ProductBean product) async {
    final success = await _favorites.requestUnFavorite(product);
    if (!success) return;
    favorites.removeWhere((p) => p.id == product.id);
  }

  void goBack() => Get.back();
}
