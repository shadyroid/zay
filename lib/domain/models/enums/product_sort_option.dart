enum ProductSortOption {
  newest,
  priceAsc,
  priceDesc,
  popularity,
  rating;

  String get labelKey => switch (this) {
        ProductSortOption.newest => 'sortNewest',
        ProductSortOption.priceAsc => 'sortPriceLowToHigh',
        ProductSortOption.priceDesc => 'sortPriceHighToLow',
        ProductSortOption.popularity => 'sortPopularity',
        ProductSortOption.rating => 'sortCustomerRating',
      };

  String get apiValue => switch (this) {
        ProductSortOption.newest => 'newest',
        ProductSortOption.priceAsc => 'price_asc',
        ProductSortOption.priceDesc => 'price_desc',
        ProductSortOption.popularity => 'popularity',
        ProductSortOption.rating => 'rating',
      };
}
