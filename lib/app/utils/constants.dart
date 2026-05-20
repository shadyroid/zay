class Constants {
  static const String tokenKey = 'token';
  static const String localeKey = 'locale';

  static const String baseUrl = 'https://api.example.com';

  /// Set to `true` when real API endpoints are ready.
  static const bool useRemoteApi = false;

  static const String signInPath = '/auth/signIn';
  static const String signUpPath = '/auth/signUp';
  static const String forgetPasswordPath = '/auth/forgetPassword';
  static const String verificationPath = '/auth/verification';
  static const String resetPasswordPath = '/auth/resetPassword';
  static const String logoutPath = '/auth/logout';

  static const String productsPath = '/catalog/products';
  static const String featuredProductsPath = '/catalog/featuredProducts';
  static const String productDetailsPath = '/catalog/productDetails';
  static const String shopsPath = '/catalog/shops';
  static const String shopDetailsPath = '/catalog/shopDetails';
  static const String shopProductsPath = '/catalog/shopProducts';
  static const String favoritesPath = '/catalog/favorites';

  static const String cartPath = '/cart';
  static const String removeFromCartPath = '/cart/remove';
  static const String checkoutPath = '/cart/checkout';

  static const String ordersPath = '/orders';
  static const String orderDetailsPath = '/orders/details';
  static const String orderTrackPath = '/orders/track';
  static const String orderReturnPath = '/orders/return';

  static const String profilePath = '/profile';
  static const String updateProfilePath = '/profile/update';

  static const String aboutUsPath = '/content/aboutUs';
  static const String termsPath = '/content/terms';
  static const String contactUsPath = '/contact/send';

  static const int splashDelaySeconds = 2;
}
