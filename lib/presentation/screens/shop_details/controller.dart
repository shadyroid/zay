import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/use_cases/shops_use_case.dart';
import 'package:hedma/app/utils/app_auth_guard.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/requests/product_id_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/domain/requests/shop_details_request.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ShopDetailsController extends BaseController {
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final shop = Rxn<ShopBean>();
  final categories = <CategoryBean>[].obs;
  final bestSellerProducts = <ProductBean>[].obs;
  final selectedCategoryId = 'all'.obs;
  final isAboutExpanded = false.obs;

  late final String shopId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final passed = args['shop'] as ShopBean?;
    shopId = args['shopId'] as String? ?? passed?.id ?? '';
    if (passed != null) shop.value = passed;
    _loadScreen();
  }

  Future<void> _loadScreen() async {
    await requestShopDetails();
    await requestCategories();
    await requestProducts();
  }

  Future<void> requestShopDetails() async {
    if (shopId.isEmpty) return;
    isLoading.value = true;
    final response = await _shopsUseCase.requestShopDetails(
      ShopDetailsRequest(shopId: shopId),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    shop.value = response.data;
  }

  Future<void> requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (!isSuccess(response)) return;
    categories.assignAll(response.data ?? []);
  }

  ProductsRequest _buildQuery() {
    return ProductsRequest(
      shopId: shopId,
      categoryId: selectedCategoryId.value,
      bestSeller: true,
      pageSize: 4,
    );
  }

  Future<void> requestProducts() async {
    if (shopId.isEmpty) return;
    final response =
        await _productsUseCase.requestProducts(request: _buildQuery());
    if (!isSuccess(response)) return;
    bestSellerProducts.assignAll(response.data ?? []);
  }

  void selectCategory(CategoryBean category) {
    if (selectedCategoryId.value == category.id) return;
    selectedCategoryId.value = category.id;
    requestProducts();
  }

  void toggleAboutExpanded() => isAboutExpanded.toggle();

  Future<void> toggleFavorite(ProductBean product) async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;

    final response = product.isFavorite.value
        ? await _productsUseCase.requestUnFavorite(
            ProductIdRequest(productId: product.id),
          )
        : await _productsUseCase.requestFavorite(
            ProductIdRequest(productId: product.id),
          );
    if (!isSuccess(response)) return;
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  void navigateToAllProducts() => Get.toNamed(Routes.products);

  void goBack() => Get.back();

  void onShare() {
    Get.rawSnackbar(message: 'shareComingSoon'.tr);
  }
}
