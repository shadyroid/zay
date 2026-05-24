import 'package:get/get.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/requests/product_id_request.dart';

class FavoriteProductsService extends GetxService {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final favoriteIds = <String>{}.obs;
  var _loaded = false;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final response = await _productsUseCase.requestFavorites();
    if (!response.isSuccess) return;
    favoriteIds.assignAll((response.data ?? []).map((p) => p.id));
    _loaded = true;
  }

  bool isFavorite(String productId) => favoriteIds.contains(productId);

  bool isFavoriteProduct(ProductBean product) =>
      isFavorite(product.id) || product.isFavorite;

  Future<bool> toggleFavorite(ProductBean product) async {
    if (isFavoriteProduct(product)) {
      return requestUnFavorite(product);
    }
    return requestFavorite(product);
  }

  Future<bool> requestFavorite(ProductBean product) async {
    final response = await _productsUseCase.requestFavorite(
      ProductIdRequest(productId: product.id),
    );
    return _handleFavoriteResponse(response, product.id, add: true);
  }

  Future<bool> requestUnFavorite(ProductBean product) async {
    final response = await _productsUseCase.requestUnFavorite(
      ProductIdRequest(productId: product.id),
    );
    return _handleFavoriteResponse(response, product.id, add: false);
  }

  bool _handleFavoriteResponse(
    BaseResponse response,
    String productId, {
    required bool add,
  }) {
    if (!response.isSuccess) {
      Get.rawSnackbar(message: response.message ?? 'warning'.tr);
      return false;
    }
    if (add) {
      favoriteIds.add(productId);
    } else {
      favoriteIds.remove(productId);
    }
    if (response.message != null) {
      Get.rawSnackbar(message: response.message!.tr);
    }
    return true;
  }

  Future<void> ensureLoaded() async {
    if (!_loaded) await loadFavorites();
  }
}
