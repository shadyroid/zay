import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/use_cases/shops_use_case.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/domain/models/beans/category_bean.dart';

import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/beans/size_bean.dart';

class FilterBottomSheetController extends GetxController {
  FilterBottomSheetController({
    int? categoryId,
    int? shopId,
    int? sizeId,
    double? priceMin,
    double? priceMax,
  }) {
    selectedCategoryId.value = categoryId;
    selectedShopId.value = shopId;
    selectedSizeId.value = sizeId;
    selectedPriceMin.value = priceMin;
    selectedPriceMax.value = priceMax;
  }



  final ProductsUseCase _productsUseCase = Get.isRegistered<ProductsUseCase>()
      ? Get.find<ProductsUseCase>()
      : Get.put(ProductsUseCase());
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());

  final isLoading = true.obs;
  final categories = <CategoryBean>[].obs;
  final shops = <ShopBean>[].obs;
  final sizes = <SizeBean>[].obs;

  final selectedCategoryId = RxnInt();
  final selectedShopId = RxnInt();
  final selectedSizeId = RxnInt();
  final selectedPriceMin = RxnDouble();
  final selectedPriceMax = RxnDouble();

  @override
  void onInit() {
    super.onInit();
    _loadFilterData();
  }

  Future<void> _loadFilterData() async {
    isLoading.value = true;
    await Future.wait([_requestCategories(), _requestShops(), _requestSizes()]);
    isLoading.value = false;
  }

  Future<void> _requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (response.statusCode != 200) return;
    categories.assignAll(response.data ?? []);
  }

  Future<void> _requestShops() async {
    final response = await _shopsUseCase.requestShops();
    if (response.statusCode != 200) return;
    shops.assignAll(response.data ?? []);
  }

  Future<void> _requestSizes() async {
    final response = await _productsUseCase.requestSizes();
    if (response.statusCode != 200) return;
    sizes.assignAll(response.data ?? []);
  }

  void selectCategory(CategoryBean category) {
    selectedCategoryId.value = category.id;
  }

  void selectShop(ShopBean shop) {
    selectedShopId.value = selectedShopId.value == shop.id ? null : shop.id;
  }

  void selectSize(SizeBean size) {
    selectedSizeId.value = selectedSizeId.value == size.id ? null : size.id;
  }

  void onPriceChanged(RangeValues values) {
    selectedPriceMin.value = values.start;
    selectedPriceMax.value = values.end;
  }

  void clearFilters() {
    selectedCategoryId.value = null;
    selectedShopId.value = null;
    selectedSizeId.value = null;
    selectedPriceMin.value = Constants.priceMinBound;
    selectedPriceMax.value = Constants.priceMaxBound;
  }
}
