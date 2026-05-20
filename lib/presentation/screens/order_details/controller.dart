import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrderDetailsController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final order = Rxn<OrderBean>();
  late final String orderId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final passed = args['order'] as OrderBean?;
    orderId = args['orderId'] as String? ?? passed?.id ?? '';
    if (passed != null) order.value = passed;
    requestOrderDetails();
  }

  Future<void> requestOrderDetails() async {
    if (orderId.isEmpty) return;
    isLoading.value = true;
    final response = await _orderUseCase.requestOrderDetails(orderId: orderId);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    order.value = response.data;
  }

  void goBack() => Get.back();

  void navigateToTrack() {
    Get.toNamed(
      Routes.orderTrack,
      arguments: {
        'orderId': orderId,
        'order': order.value,
      },
    );
  }

  void navigateToReturn() {
    Get.toNamed(
      Routes.orderReturn,
      arguments: {
        'orderId': orderId,
        'order': order.value,
      },
    );
  }
}
