import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/domain/models/enums/payment_method.dart';
import 'package:zay/domain/models/enums/payment_status.dart';
import 'package:zay/presentation/base/base_controller.dart';

/// Placeholder success screen after order placement.
class OrderSuccessController extends BaseController {
  late final bool isCardPayment;
  late final bool isPaymentPending;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    final method = PaymentMethod.fromApi(
      args is Map ? args['paymentMethod'] as String? : null,
    );
    final paymentStatus = args is Map
        ? (args['paymentStatus'] is PaymentStatus
            ? args['paymentStatus'] as PaymentStatus
            : PaymentStatus.fromApi(args['paymentStatus']?.toString()))
        : PaymentStatus.pending;
    isCardPayment = method == PaymentMethod.card;
    isPaymentPending = isCardPayment && !paymentStatus.isPaid;
  }

  void goHome() => Get.offAllNamed(Routes.home);
}
