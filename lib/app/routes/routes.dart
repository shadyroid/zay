import 'package:get/get.dart';
import 'package:zay/app/bindings/about_us_binding.dart';
import 'package:zay/app/bindings/cart_binding.dart';
import 'package:zay/app/bindings/change_password_binding.dart';
import 'package:zay/app/bindings/contact_us_binding.dart';
import 'package:zay/app/bindings/edit_profile_binding.dart';
import 'package:zay/app/bindings/favorite_binding.dart';
import 'package:zay/app/bindings/forget_password_binding.dart';
import 'package:zay/app/bindings/home_binding.dart';
import 'package:zay/app/bindings/images_viewer_binding.dart';
import 'package:zay/app/bindings/no_internet_binding.dart';
import 'package:zay/app/bindings/notifications_binding.dart';
import 'package:zay/app/bindings/order_details_binding.dart';
import 'package:zay/app/bindings/map_binding.dart';
import 'package:zay/app/bindings/order_return_binding.dart';
import 'package:zay/app/bindings/order_success_binding.dart';
import 'package:zay/app/bindings/order_track_binding.dart';
import 'package:zay/app/bindings/orders_binding.dart';
import 'package:zay/app/bindings/product_details_binding.dart';
import 'package:zay/app/bindings/products_binding.dart';
import 'package:zay/app/bindings/review_binding.dart';
import 'package:zay/app/bindings/reviews_binding.dart';
import 'package:zay/app/bindings/reset_password_binding.dart';
import 'package:zay/app/bindings/server_error_binding.dart';
import 'package:zay/app/bindings/settings_binding.dart';
import 'package:zay/app/bindings/shop_details_binding.dart';
import 'package:zay/app/bindings/shops_binding.dart';
import 'package:zay/app/bindings/sign_in_binding.dart';
import 'package:zay/app/bindings/sign_up_binding.dart';
import 'package:zay/app/bindings/splash_binding.dart';
import 'package:zay/app/bindings/privacy_binding.dart';
import 'package:zay/app/bindings/terms_binding.dart';
import 'package:zay/app/bindings/try_on_binding.dart';
import 'package:zay/app/bindings/verification_binding.dart';
import 'package:zay/presentation/screens/about_us/screen.dart';
import 'package:zay/presentation/screens/cart/screen.dart';
import 'package:zay/presentation/screens/change_password/screen.dart';
import 'package:zay/presentation/screens/contact_us/screen.dart';
import 'package:zay/presentation/screens/edit_profile/screen.dart';
import 'package:zay/presentation/screens/favorite/screen.dart';
import 'package:zay/presentation/screens/forget_password/screen.dart';
import 'package:zay/presentation/screens/home/screen.dart';
import 'package:zay/presentation/screens/images_viewer/screen.dart';
import 'package:zay/presentation/screens/no_internet/screen.dart';
import 'package:zay/presentation/screens/notifications/screen.dart';
import 'package:zay/presentation/screens/order_details/screen.dart';
import 'package:zay/presentation/screens/map/screen.dart';
import 'package:zay/presentation/screens/order_return/screen.dart';
import 'package:zay/presentation/screens/order_success/screen.dart';
import 'package:zay/presentation/screens/order_track/screen.dart';
import 'package:zay/presentation/screens/orders/screen.dart';
import 'package:zay/presentation/screens/product_details/screen.dart';
import 'package:zay/presentation/screens/products/screen.dart';
import 'package:zay/presentation/screens/review/screen.dart';
import 'package:zay/presentation/screens/reviews/screen.dart';
import 'package:zay/presentation/screens/reset_password/screen.dart';
import 'package:zay/presentation/screens/server_error/screen.dart';
import 'package:zay/presentation/screens/settings/screen.dart';
import 'package:zay/presentation/screens/shop_details/screen.dart';
import 'package:zay/presentation/screens/shops/screen.dart';
import 'package:zay/presentation/screens/sign_in/screen.dart';
import 'package:zay/presentation/screens/sign_up/screen.dart';
import 'package:zay/presentation/screens/size_guide/screen.dart';
import 'package:zay/presentation/screens/splash/screen.dart';
import 'package:zay/presentation/screens/privacy/screen.dart';
import 'package:zay/presentation/screens/terms/screen.dart';
import 'package:zay/presentation/screens/try_on/screen.dart';
import 'package:zay/presentation/screens/verification/screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPassword';
  static const String verification = '/verification';
  static const String resetPassword = '/resetPassword';
  static const String home = '/home';
  static const String productDetails = '/productDetails';
  static const String imagesViewer = '/imagesViewer';
  static const String sizeGuide = '/sizeGuide';
  static const String tryOn = '/tryOn';
  static const String products = '/products';
  static const String shops = '/shops';
  static const String shopDetails = '/shopDetails';
  static const String cart = '/cart';
  static const String map = '/map';
  static const String orderSuccess = '/orderSuccess';
  static const String settings = '/settings';
  static const String editProfile = '/editProfile';
  static const String changePassword = '/changePassword';
  static const String favorite = '/favorite';
  static const String contactUs = '/contactUs';
  static const String aboutUs = '/aboutUs';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static const String orders = '/orders';
  static const String orderDetails = '/orderDetails';
  static const String orderTrack = '/orderTrack';
  static const String orderReturn = '/orderReturn';
  static const String review = '/review';
  static const String reviews = '/reviews';
  static const String notifications = '/notifications';
  static const String noInternet = '/noInternet';
  static const String serverError = '/serverError';
  static const String unknown = '/unknown';

  /// Fallback when GetX cannot match a route (e.g. a platform deep link
  /// leaked through as the Navigator initial route). Splash then runs the
  /// normal auth + [DeepLinksUtil.handleInitialLink] flow.
  static final GetPage<dynamic> unknownPage = GetPage(
    name: unknown,
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  );

  static final List<GetPage<dynamic>> pages = [
    GetPage(name: splash, page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(name: signIn, page: () => const SignInScreen(), binding: SignInBinding()),
    GetPage(name: signUp, page: () => const SignUpScreen(), binding: SignUpBinding()),
    GetPage(
      name: forgetPassword,
      page: () => const ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: verification,
      page: () => const VerificationScreen(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: productDetails,
      page: () => const ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: imagesViewer,
      page: () => const ImagesViewerScreen(),
      binding: ImagesViewerBinding(),
    ),
    GetPage(
      name: sizeGuide,
      page: () => const SizeGuideScreen(),
    ),
    GetPage(
      name: tryOn,
      page: () => const TryOnScreen(),
      binding: TryOnBinding(),
    ),
    GetPage(name: products, page: () => const ProductsScreen(), binding: ProductsBinding()),
    GetPage(
      name: shops,
      page: () => const ShopsScreen(),
      binding: ShopsBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: shopDetails,
      page: () => const ShopDetailsScreen(),
      binding: ShopDetailsBinding(),
    ),
    GetPage(
      name: cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(name: map, page: () => const MapScreen(), binding: MapBinding()),
    GetPage(
      name: orderSuccess,
      page: () => const OrderSuccessScreen(),
      binding: OrderSuccessBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(name: favorite, page: () => const FavoriteScreen(), binding: FavoriteBinding()),
    GetPage(
      name: contactUs,
      page: () => const ContactUsScreen(),
      binding: ContactUsBinding(),
    ),
    GetPage(name: aboutUs, page: () => const AboutUsScreen(), binding: AboutUsBinding()),
    GetPage(name: terms, page: () => const TermsScreen(), binding: TermsBinding()),
    GetPage(
      name: privacy,
      page: () => const PrivacyScreen(),
      binding: PrivacyBinding(),
    ),
    GetPage(name: orders, page: () => const OrdersScreen(), binding: OrdersBinding()),
    GetPage(
      name: orderDetails,
      page: () => const OrderDetailsScreen(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: orderTrack,
      page: () => const OrderTrackScreen(),
      binding: OrderTrackBinding(),
    ),
    GetPage(
      name: orderReturn,
      page: () => const OrderReturnScreen(),
      binding: OrderReturnBinding(),
    ),
    GetPage(
      name: review,
      page: () => const ReviewScreen(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: reviews,
      page: () => const ReviewsScreen(),
      binding: ReviewsBinding(),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationsScreen(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: noInternet,
      page: () => const NoInternetScreen(),
      binding: NoInternetBinding(),
    ),
    GetPage(
      name: serverError,
      page: () => const ServerErrorScreen(),
      binding: ServerErrorBinding(),
    ),
  ];
}
