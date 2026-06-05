class Constants {
  static const String tokenKey = 'token';
  static const String tempTokenKey = 'tempToken';
  static const String isVerified = 'isVerified';
  static const String localeKey = 'locale';

  static const String baseUrl = 'https://zaymarketplace.online/api';

  static const String signInPath = '/auth/login';
  static const String signUpPath = '/auth/register';
  static const String forgetPasswordPath = '/auth/forgot-password';
  static const String resendVerificationPath = '/auth/resend-verification';
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
  static const String tryOnPath = '/try-on';
  static const String tryOnReviewPath = '/requests';

  static const String cartPath = '/cart';
  static const String cartItemsPath = '/cart/items';

  static const String createOrderPath = '/orders';
  static const String ordersPath = '/orders';
  static const String orderDetailsPath = '/orders';
  static const String orderReturnPath = '/returns/order';
  static const String returnReasonsPath = '/returns/reasons';

  static const String profilePath = '/profile';
  static const String changePasswordPath = '/profile/password';
  static const String deleteAccountPath = '/profile';

  static const String aboutUsPath = '/pages/about-us';
  static const String termsPath = '/pages/terms';
  static const String privacyPath = '/pages/privacy';
  static const String contactUsPath = '/pages/contact-us';

  static const String appName = 'Hedma';
  static const String androidStoreUrl =
      'https://play.google.com/store/apps/details?id=com.hedma';
  static const String iosStoreUrl = 'https://zaymarketplace.online';

  static const int splashDelaySeconds = 2;
  static const double priceMinBound = 0;
  static const double priceMaxBound = 10000;
}
