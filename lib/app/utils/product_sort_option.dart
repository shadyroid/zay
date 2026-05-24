enum ProductSortOption {
  priceHighToLow,
  priceLowToHigh,
  popularity,
  customerRating,
}

extension ProductSortOptionX on ProductSortOption {
  String get labelKey => switch (this) {
        ProductSortOption.priceHighToLow => 'sortPriceHighToLow',
        ProductSortOption.priceLowToHigh => 'sortPriceLowToHigh',
        ProductSortOption.popularity => 'sortPopularity',
        ProductSortOption.customerRating => 'sortCustomerRating',
      };

  String get apiValue => switch (this) {
        ProductSortOption.priceHighToLow => 'price_high_to_low',
        ProductSortOption.priceLowToHigh => 'price_low_to_high',
        ProductSortOption.popularity => 'popularity',
        ProductSortOption.customerRating => 'rating',
      };
}
