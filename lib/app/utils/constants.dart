class Constants {
  static const String tokenKey = 'token';
  static const String localeKey = 'locale';

  static const String baseUrl = 'https://zaymarketplace.online/api';

  /// Set to `true` when real API endpoints are ready.
  static const bool useRemoteApi = false;

  static const String signInPath = '/auth/login';
  static const String signUpPath = '/auth/register';
  static const String forgetPasswordPath = '/auth/forgot-password';
  static const String verificationPath = '/auth/verify-email';
  static const String resetPasswordPath = '/auth/reset-password';
  static const String signOutPath = '/auth/logout';

  static const String productsPath = '/products';
  static const String categoriesPath = '/categories';
  static const String sizesPath = '/sizes';
  static const String productDetailsPath = '/products';
  static const String shopsPath = '/shops';
  static const String shopDetailsPath = '/shops';
  static const String wishlistPath = '/wishlist';
  static const String reviewsPath = '/products';
  static const String addTryOutReviewPath = '/catalog/reviews/add';
  static const String tryProductPath = '/catalog/tryProduct';

  static const String cartPath = '/cart';
  static const String cartItemsPath = '/cart/items';

  static const String createOrderPath = '/orders/create';
  static const String ordersPath = '/orders';
  static const String orderDetailsPath = '/orders';
  static const String orderReturnPath = '/returns/order';
  static const String returnReasonsPath = '/returns/reasons';

  static const String profilePath = '/profile';

  static const String aboutUsPath = '/pages/about-us';
  static const String termsPath = '/pages/terms';
  static const String privacyPath = '/pages/privacy';
  static const String contactUsPath = '/pages/contact-us';

  static const int splashDelaySeconds = 2;
}
