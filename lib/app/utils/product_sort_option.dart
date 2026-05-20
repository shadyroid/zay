enum ProductSortOption {
  priceHighToLow,
  priceLowToHigh,
  popularity,
  discount,
  customerRating,
}

extension ProductSortOptionX on ProductSortOption {
  String get labelKey => switch (this) {
        ProductSortOption.priceHighToLow => 'sortPriceHighToLow',
        ProductSortOption.priceLowToHigh => 'sortPriceLowToHigh',
        ProductSortOption.popularity => 'sortPopularity',
        ProductSortOption.discount => 'sortDiscount',
        ProductSortOption.customerRating => 'sortCustomerRating',
      };

}
