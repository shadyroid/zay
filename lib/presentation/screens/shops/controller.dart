import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/shops_use_case.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ShopsController extends BaseController {
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());

  final allShops = <ShopBean>[].obs;
  final shops = <ShopBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestShops();
  }

  Future<void> requestShops() async {
    isLoading.value = true;
    final response = await _shopsUseCase.requestShops();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    allShops.assignAll(response.data ?? []);
    shops.assignAll(response.data ?? []);
  }

  void navigateToShopDetails(ShopBean shop) {
    Get.toNamed(Routes.shopDetails, arguments: {'shopId': shop.id});
  }

  void goBack() => Get.offNamed(Routes.home);

  void onSearch(String text) {
    shops.value = allShops
        .where((shop) =>
        (shop.name ?? '').toLowerCase()
            .contains(text.toLowerCase()))
        .toList();
  }
}
