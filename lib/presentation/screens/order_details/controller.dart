import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/order_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/app/utils/payment_browser.dart';
import 'package:zay/domain/models/beans/order_bean.dart';
import 'package:zay/domain/models/requests/order_details_request.dart';
import 'package:zay/domain/models/requests/payment_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class OrderDetailsController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final order = Rxn<OrderBean>();
  late final int orderId;

  @override
  void onInit() {
    super.onInit();
    final passed = Get.arguments['order'];
    orderId = Get.arguments['orderId'];
    if (passed != null) order.value = passed;
    requestOrderDetails();
  }

  Future<void> requestOrderDetails() async {
    isLoading.value = true;
    final response = await _orderUseCase.requestOrderDetails(
      OrderDetailsRequest(orderId: orderId),
    );
    if (!isSuccess(response)) {
      isLoading.value = false;
      return;
    }

    var current = response.data;
    if (current != null && current.isCardPayment) {
      final statusResponse = await _orderUseCase.requestPaymentStatus(
        PaymentRequest(orderId: orderId),
      );
      if (statusResponse.isSuccess) {
        current = current.copyWith(paymentStatus: statusResponse.paymentStatus);
      }
    }

    isLoading.value = false;
    order.value = current;
  }

  Future<void> onPay() async {
    final current = order.value;
    if (current == null || !current.needsPayment) return;

    isLoading.value = true;
    final initiate = await _orderUseCase.requestInitiatePayment(
      PaymentRequest(orderId: orderId),
    );
    isLoading.value = false;
    if (!isSuccess(initiate)) return;

    final paymentUrl = initiate.paymentUrl;
    if (paymentUrl == null || paymentUrl.isEmpty) {
      Get.rawSnackbar(message: 'paymentLinkOpenFailed'.tr);
      return;
    }

    final opened = await PaymentBrowser.openAndWaitForReturn(paymentUrl);
    if (!opened) {
      Get.rawSnackbar(message: 'paymentLinkOpenFailed'.tr);
    }

    isLoading.value = true;
    final statusResponse = await _orderUseCase.requestPaymentStatus(
      PaymentRequest(orderId: orderId),
    );
    isLoading.value = false;
    if (!isSuccess(statusResponse)) return;

    order.value = current.copyWith(paymentStatus: statusResponse.paymentStatus);
  }

  Future<void> navigateToTrack() async {
    await AppAuthGuard.toNamed(
      Routes.orderTrack,
      arguments: {'orderId': orderId, 'order': order.value},
    );
  }

  Future<void> navigateToReturn() async {
    await AppAuthGuard.toNamed(
      Routes.orderReturn,
      arguments: {'orderId': orderId, 'order': order.value},
    );
  }

  Future<void> navigateToReview() async {
    final currentOrder = order.value;
    await AppAuthGuard.toNamed(
      Routes.review,
      arguments: {
        'orderId': orderId,
        'order': currentOrder,
        if (currentOrder != null && currentOrder.items?.isNotEmpty == true)
          'items': currentOrder.items,
      },
    );
  }
}
