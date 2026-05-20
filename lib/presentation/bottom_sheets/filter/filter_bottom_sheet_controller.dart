import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/use_cases/shops_use_case.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_filters.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/domain/models/beans/size_bean.dart';
class FilterBottomSheetController extends GetxController {
  FilterBottomSheetController({required ProductFilters initial}) {
    selectedCategoryId.value = initial.categoryId;
    selectedShopId.value = initial.shopId;
    selectedSizeId.value = initial.sizeId;
    priceRange.value = RangeValues(initial.priceMin, initial.priceMax);
  }

  static const double priceMinBound = 0;
  static const double priceMaxBound = 250;

  final ProductsUseCase _productsUseCase = Get.isRegistered<ProductsUseCase>()
      ? Get.find<ProductsUseCase>()
      : Get.put(ProductsUseCase());
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());

  final isLoading = true.obs;
  final categories = <CategoryBean>[].obs;
  final shops = <ShopBean>[].obs;
  final sizes = <SizeBean>[].obs;

  final selectedCategoryId = 'all'.obs;
  final selectedShopId = RxnString();
  final selectedSizeId = RxnString();
  final priceRange =
      const RangeValues(priceMinBound, priceMaxBound).obs;

  @override
  void onInit() {
    super.onInit();
    _loadFilterData();
  }

  Future<void> _loadFilterData() async {
    isLoading.value = true;
    await Future.wait([
      _requestCategories(),
      _requestShops(),
      _requestSizes(),
    ]);
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
    selectedShopId.value =
        selectedShopId.value == shop.id ? null : shop.id;
  }

  void selectSize(SizeBean size) {
    selectedSizeId.value =
        selectedSizeId.value == size.id ? null : size.id;
  }

  void onPriceChanged(RangeValues values) {
    priceRange.value = values;
  }

  void clearFilters() {
    selectedCategoryId.value = 'all';
    selectedShopId.value = null;
    selectedSizeId.value = null;
    priceRange.value = const RangeValues(priceMinBound, priceMaxBound);
  }

  ProductFilters buildFilters() {
    return ProductFilters(
      categoryId: selectedCategoryId.value,
      shopId: selectedShopId.value,
      sizeId: selectedSizeId.value,
      priceMin: priceRange.value.start,
      priceMax: priceRange.value.end,
    );
  }
}
