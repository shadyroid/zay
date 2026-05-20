import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/shops_use_case.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ShopDetailsController extends BaseController {
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());

  final shop = Rxn<ShopBean>();
  final products = <ProductBean>[].obs;
  late final String shopId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final passed = args['shop'] as ShopBean?;
    shopId = args['shopId'] as String? ?? passed?.id ?? '';
    if (passed != null) shop.value = passed;
    requestShopDetails();
    requestShopProducts();
  }

  Future<void> requestShopDetails() async {
    if (shopId.isEmpty) return;
    isLoading.value = true;
    final response = await _shopsUseCase.requestShopDetails(shopId: shopId);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    shop.value = response.data;
  }

  Future<void> requestShopProducts() async {
    if (shopId.isEmpty) return;
    final response = await _shopsUseCase.requestShopProducts(shopId: shopId);
    if (!isSuccess(response)) return;
    products.assignAll(response.data ?? []);
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }
}
