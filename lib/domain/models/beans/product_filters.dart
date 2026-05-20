class ProductFilters {
  const ProductFilters({
    this.categoryId = 'all',
    this.shopId,
    this.sizeId,
    this.priceMin = 0,
    this.priceMax = 250,
  });

  final String categoryId;
  final String? shopId;
  final String? sizeId;
  final double priceMin;
  final double priceMax;

  static const ProductFilters initial = ProductFilters();

  ProductFilters copyWith({
    String? categoryId,
    String? shopId,
    String? sizeId,
    double? priceMin,
    double? priceMax,
    bool clearShop = false,
    bool clearSize = false,
  }) {
    return ProductFilters(
      categoryId: categoryId ?? this.categoryId,
      shopId: clearShop ? null : shopId ?? this.shopId,
      sizeId: clearSize ? null : sizeId ?? this.sizeId,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
    );
  }

  ProductFilters cleared() => const ProductFilters();
}
