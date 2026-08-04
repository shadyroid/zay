import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/utils/payment_method.dart';
import 'package:zay/presentation/base/base_controller.dart';

/// Placeholder success screen after order placement.
class OrderSuccessController extends BaseController {
  late final bool isCardPayment;
  late final bool isPaymentPending;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    final method = args is Map ? args['paymentMethod'] as String? : null;
    final paymentStatus =
        args is Map ? args['paymentStatus'] as String? : null;
    isCardPayment = method == PaymentMethod.card.apiValue;
    final status = paymentStatus?.toLowerCase();
    final isPaid = status == 'paid' ||
        status == 'captured' ||
        status == 'success';
    isPaymentPending = isCardPayment && !isPaid;
  }

  void goHome() => Get.offAllNamed(Routes.home);
}
