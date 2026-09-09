import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/domain/models/enums/product_sort_option.dart';
import 'package:zay/app/utils/transfer_progress.dart';
import 'package:zay/domain/models/beans/category_bean.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/requests/product_id_request.dart';
import 'package:zay/domain/models/requests/products_request.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:zay/presentation/bottom_sheets/filter/filter_bottom_sheet.dart';
import 'package:zay/presentation/bottom_sheets/sort/sort_bottom_sheet.dart';
import 'package:zay/presentation/screens/home/controller.dart';
import 'package:zay/presentation/screens/home/home_sections_data.dart';
import 'package:image_picker/image_picker.dart';

class ProductsController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final categories = <CategoryBean>[].obs;
  final selectedCategoryId = RxnInt();
  final selectedSort = Rxn<ProductSortOption>();
  final searchQuery = RxnString();
  final totalCount = 0.obs;
  final sendProgress = 0.0.obs;
  final receiveProgress = 0.0.obs;

  late final PagingController<int, ProductBean> pagingController;

  int? shopId;
  int? sizeId;
  double? priceMin;
  double? priceMax;
  XFile? image;
  String? type;
  late final HomeSectionsData homeSections;

  final isSearchMode = ValueNotifier<bool>(false);
  final searchText = ValueNotifier<String>('');

  @override
  void onInit() {
    super.onInit();
    selectedCategoryId.value = Get.arguments?['categoryId'];
    searchQuery.value = Get.arguments?['search'];
    if (searchQuery.value != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchText.value = searchQuery.value!;
        isSearchMode.value = true;
      });
    }
    shopId = Get.arguments?['shopId'];
    image = Get.arguments?['image'];
    type = Get.arguments?['type'];
    homeSections = HomeSectionsData.fromArguments(Get.arguments);
    if (homeSections.isEmpty && Get.isRegistered<HomeController>()) {
      homeSections = Get.find<HomeController>().homeSections;
    }
    pagingController = PagingController<int, ProductBean>(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) return null;
        final lastPage = state.pages?.lastOrNull;
        if (lastPage != null &&
            lastPage.length < ProductsRequest.pageSizeDefault) {
          return null;
        }
        return state.nextIntPageKey;
      },
      fetchPage: requestProducts,
    );
    requestCategories();
  }

  @override
  void onClose() {
    pagingController.dispose();
    isSearchMode.dispose();
    searchText.dispose();
    super.onClose();
  }

  Future<void> requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (!isSuccess(response)) return;
    if (response.data?.isNotEmpty == true) {
      categories.add(CategoryBean.fromJson({"name": "all_items".tr}));
      categories.addAll(response.data ?? []);
    }
  }

  Future<List<ProductBean>> requestProducts(int pageKey) async {
    if (image != null && pageKey == 1) {
      sendProgress.value = 0;
      receiveProgress.value = 0;
    }
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(
        page: pageKey,
        pageSize: ProductsRequest.pageSizeDefault,
        categoryId: selectedCategoryId.value,
        shopId: shopId,
        sizeId: sizeId,
        minPrice: priceMin,
        maxPrice: priceMax,
        sortBy: selectedSort.value,
        search: searchQuery.value,
        image: image,
        type: type,
      ),
      onSendProgress: image == null
          ? null
          : (count, total) {
              final next = TransferProgress.portion(count, total);
              if (next > sendProgress.value) sendProgress.value = next;
            },
      onReceiveProgress: image == null
          ? null
          : (count, total) {
              sendProgress.value = 1;
              final next = TransferProgress.portion(count, total);
              if (next > receiveProgress.value) {
                receiveProgress.value = next;
              }
            },
    );
    if (image != null && pageKey == 1) {
      sendProgress.value = 1;
      receiveProgress.value = 1;
    }
    if (!isSuccess(response)) {
      throw Exception(response.message ?? 'warning'.tr);
    }
    if (pageKey == 1) {
      totalCount.value = response.totalCount ?? response.data?.length ?? 0;
    }
    return response.data ?? [];
  }

  void selectCategory(CategoryBean category) {
    if (selectedCategoryId.value == category.id) {
      selectedCategoryId.value = null;
    } else {
      selectedCategoryId.value = category.id;
    }
    pagingController.refresh();
  }

  Future<void> onSortTap() async {
    final option = await SortBottomSheet.show(
      selectedOption: selectedSort.value,
    );
    if (option == null || option == selectedSort.value) return;
    selectedSort.value = option;
    pagingController.refresh();
  }

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
    Get.toNamed(
      Routes.productDetails,
      arguments: homeSections.mergeWith({'productId': product.id}),
    );
  }

  void onSearchSubmitted(String text) {
    searchQuery.value = text;
    pagingController.refresh();
  }

  Future<void> onPullToRefresh() async {
    pagingController.refresh();
  }

  Future<void> onFilters() async {
    final result = await FilterBottomSheet.show(
      categoryId: selectedCategoryId.value,
      shopId: shopId,
      sizeId: sizeId,
      priceMin: priceMin,
      priceMax: priceMax,
    );
    if (result == null) return;
    selectedCategoryId.value = result['categoryId'];
    shopId = result['shopId'];
    sizeId = result['sizeId'];
    priceMin = result['priceMin'];
    priceMax = result['priceMax'];
    pagingController.refresh();
  }
}
