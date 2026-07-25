import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/use_cases/shops_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/app/utils/deep_links_util.dart';
import 'package:zay/domain/models/beans/category_bean.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/requests/product_id_request.dart';
import 'package:zay/domain/models/requests/products_request.dart';
import 'package:zay/domain/models/requests/shop_details_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class ShopDetailsController extends BaseController {
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final shop = Rxn<ShopBean>();
  final bestSellerProducts = <ProductBean>[].obs;
  final selectedCategoryId = RxnInt();
  final isAboutExpanded = false.obs;

  late final int shopId;

  @override
  void onInit() {
    super.onInit();
    shopId = Get.arguments['shopId'];
    _loadScreen();
  }

  Future<void> _loadScreen() async {
    requestShopDetails();
    requestProducts();
  }

  Future<void> requestShopDetails() async {
    isLoading.value = true;
    final response = await _shopsUseCase.requestShopDetails(
      ShopDetailsRequest(shopId: shopId),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    shop.value = response.data;
  }

  Future<void> requestProducts() async {
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(
        shopId: shopId,
        categoryId: selectedCategoryId.value,
        bestSeller: true,
        pageSize: 4,
        page: 1,
      ),
    );
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

  Future<void> onShare() async {
    await DeepLinksUtil.shareShop(
      shopId: shopId,
      shopName: shop.value?.name,
    );
  }
}
