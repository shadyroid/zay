import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class HomeController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final FavoriteProductsService _favorites = Get.find<FavoriteProductsService>();

  final products = <ProductBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestFeaturedProducts();
  }

  Future<void> requestFeaturedProducts() async {
    isLoading.value = true;
    await _favorites.ensureLoaded();
    final response = await _productsUseCase.requestFeaturedProducts();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    products.assignAll(response.data ?? []);
    for (final product in response.data ?? []) {
      if (product.isFavorite) {
        _favorites.favoriteIds.add(product.id);
      }
    }
  }

  bool isFavorite(ProductBean product) => _favorites.isFavoriteProduct(product);

  Future<void> toggleFavorite(ProductBean product) =>
      _favorites.toggleFavorite(product);

  void navigateToProducts() => Get.toNamed(Routes.products);

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  void navigateToShops() => Get.toNamed(Routes.shops);

  void navigateToOrders() => Get.toNamed(Routes.orders);
}
