import 'package:hedma/app/utils/product_sort_option.dart';

class ProductsRequest {
  const ProductsRequest({
    this.page,
    this.pageSize,
    this.bestSeller,
    this.recommended,
    this.newArrival,
    this.image,
    this.similarToId,
    this.categoryId,
    this.shopId,
    this.sizeId,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
    this.search,
  });

  final int? page;
  final int? pageSize;
  final bool? bestSeller;
  final bool? recommended;
  final bool? newArrival;
  final String? image;
  final String? similarToId;
  final String? categoryId;
  final String? shopId;
  final String? sizeId;
  final double? minPrice;
  final double? maxPrice;
  final ProductSortOption? sortBy;
  final String? search;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};

    if (page != null) params['page'] = page;
    if (pageSize != null) params['page_size'] = pageSize;
    if (bestSeller == true) params['best_seller'] = 1;
    if (recommended == true) params['recommended'] = 1;
    if (newArrival == true) params['new_arrival'] = 1;
    if (similarToId != null && similarToId!.isNotEmpty) {
      params['similar_to_id'] = similarToId;
    }
    if (categoryId != null &&
        categoryId!.isNotEmpty &&
        categoryId != 'all') {
      params['category_id'] = categoryId;
    }
    if (shopId != null && shopId!.isNotEmpty) params['shop_id'] = shopId;
    if (sizeId != null && sizeId!.isNotEmpty) params['size_id'] = sizeId;
    if (minPrice != null) params['min_price'] = minPrice;
    if (maxPrice != null) params['max_price'] = maxPrice;
    if (sortBy != null) params['sort_by'] = sortBy!.apiValue;
    if (search != null && search!.trim().isNotEmpty) {
      params['search'] = search!.trim();
    }

    return params;
  }
}
