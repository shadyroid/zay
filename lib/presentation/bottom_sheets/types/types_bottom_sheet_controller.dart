import 'package:get/get.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/domain/models/beans/type_bean.dart';
import 'package:zay/presentation/base/base_controller.dart';

class TypesBottomSheetController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.isRegistered<ProductsUseCase>()
      ? Get.find<ProductsUseCase>()
      : Get.put(ProductsUseCase());

  final types = <TypeBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    _requestTypes();
  }

  Future<void> _requestTypes() async {
    isLoading.value = true;
    final response = await _productsUseCase.requestTryOnCategories();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    types.assignAll(response.data ?? []);
  }
}
