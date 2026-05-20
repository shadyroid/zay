import 'package:get/get.dart';
import 'package:hedma/app/bindings/about_us_binding.dart';
import 'package:hedma/app/bindings/cart_binding.dart';
import 'package:hedma/app/bindings/contact_us_binding.dart';
import 'package:hedma/app/bindings/edit_profile_binding.dart';
import 'package:hedma/app/bindings/favorite_binding.dart';
import 'package:hedma/app/bindings/forget_password_binding.dart';
import 'package:hedma/app/bindings/home_binding.dart';
import 'package:hedma/app/bindings/no_internet_binding.dart';
import 'package:hedma/app/bindings/order_details_binding.dart';
import 'package:hedma/app/bindings/map_binding.dart';
import 'package:hedma/app/bindings/order_return_binding.dart';
import 'package:hedma/app/bindings/order_success_binding.dart';
import 'package:hedma/app/bindings/order_track_binding.dart';
import 'package:hedma/app/bindings/orders_binding.dart';
import 'package:hedma/app/bindings/product_details_binding.dart';
import 'package:hedma/app/bindings/products_binding.dart';
import 'package:hedma/app/bindings/reset_password_binding.dart';
import 'package:hedma/app/bindings/server_error_binding.dart';
import 'package:hedma/app/bindings/settings_binding.dart';
import 'package:hedma/app/bindings/shop_details_binding.dart';
import 'package:hedma/app/bindings/shops_binding.dart';
import 'package:hedma/app/bindings/sign_in_binding.dart';
import 'package:hedma/app/bindings/sign_up_binding.dart';
import 'package:hedma/app/bindings/splash_binding.dart';
import 'package:hedma/app/bindings/privacy_binding.dart';
import 'package:hedma/app/bindings/terms_binding.dart';
import 'package:hedma/app/bindings/try_on_binding.dart';
import 'package:hedma/app/bindings/verification_binding.dart';
import 'package:hedma/presentation/screens/about_us/screen.dart';
import 'package:hedma/presentation/screens/cart/screen.dart';
import 'package:hedma/presentation/screens/contact_us/screen.dart';
import 'package:hedma/presentation/screens/edit_profile/screen.dart';
import 'package:hedma/presentation/screens/favorite/screen.dart';
import 'package:hedma/presentation/screens/forget_password/screen.dart';
import 'package:hedma/presentation/screens/home/screen.dart';
import 'package:hedma/presentation/screens/no_internet/screen.dart';
import 'package:hedma/presentation/screens/order_details/screen.dart';
import 'package:hedma/presentation/screens/map/screen.dart';
import 'package:hedma/presentation/screens/order_return/screen.dart';
import 'package:hedma/presentation/screens/order_success/screen.dart';
import 'package:hedma/presentation/screens/order_track/screen.dart';
import 'package:hedma/presentation/screens/orders/screen.dart';
import 'package:hedma/presentation/screens/product_details/screen.dart';
import 'package:hedma/presentation/screens/products/screen.dart';
import 'package:hedma/presentation/screens/reset_password/screen.dart';
import 'package:hedma/presentation/screens/server_error/screen.dart';
import 'package:hedma/presentation/screens/settings/screen.dart';
import 'package:hedma/presentation/screens/shop_details/screen.dart';
import 'package:hedma/presentation/screens/shops/screen.dart';
import 'package:hedma/presentation/screens/sign_in/screen.dart';
import 'package:hedma/presentation/screens/sign_up/screen.dart';
import 'package:hedma/presentation/screens/splash/screen.dart';
import 'package:hedma/presentation/screens/privacy/screen.dart';
import 'package:hedma/presentation/screens/terms/screen.dart';
import 'package:hedma/presentation/screens/try_on/screen.dart';
import 'package:hedma/presentation/screens/verification/screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPassword';
  static const String verification = '/verification';
  static const String resetPassword = '/resetPassword';
  static const String home = '/home';
  static const String productDetails = '/productDetails';
  static const String tryOn = '/tryOn';
  static const String products = '/products';
  static const String shops = '/shops';
  static const String shopDetails = '/shopDetails';
  static const String cart = '/cart';
  static const String map = '/map';
  static const String orderSuccess = '/orderSuccess';
  static const String settings = '/settings';
  static const String editProfile = '/editProfile';
  static const String favorite = '/favorite';
  static const String contactUs = '/contactUs';
  static const String aboutUs = '/aboutUs';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static const String orders = '/orders';
  static const String orderDetails = '/orderDetails';
  static const String orderTrack = '/orderTrack';
  static const String orderReturn = '/orderReturn';
  static const String noInternet = '/noInternet';
  static const String serverError = '/serverError';

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
    GetPage(name: home, page: () => const HomeScreen(), binding: HomeBinding()),
    GetPage(
      name: productDetails,
      page: () => const ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: tryOn,
      page: () => const TryOnScreen(),
      binding: TryOnBinding(),
    ),
    GetPage(name: products, page: () => const ProductsScreen(), binding: ProductsBinding()),
    GetPage(name: shops, page: () => const ShopsScreen(), binding: ShopsBinding()),
    GetPage(
      name: shopDetails,
      page: () => const ShopDetailsScreen(),
      binding: ShopDetailsBinding(),
    ),
    GetPage(name: cart, page: () => const CartScreen(), binding: CartBinding()),
    GetPage(name: map, page: () => const MapScreen(), binding: MapBinding()),
    GetPage(
      name: orderSuccess,
      page: () => const OrderSuccessScreen(),
      binding: OrderSuccessBinding(),
    ),
    GetPage(name: settings, page: () => const SettingsScreen(), binding: SettingsBinding()),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
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
