import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/app/utils/app_auth_guard.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

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
    isLoading.value = false;
    if (!isSuccess(response)) return;
    order.value = response.data;
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
        if (currentOrder != null && currentOrder.items?.isNotEmpty==true)
          'items': currentOrder.items,
      },
    );
  }
}
