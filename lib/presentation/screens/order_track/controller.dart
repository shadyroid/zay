import 'package:get/get.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/domain/models/beans/order_track_step_bean.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrderTrackController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final order = Rxn<OrderBean>();
  final steps = <OrderTrackStepBean>[].obs;
  final estimatedDelivery = ''.obs;

  late final int orderId;

  @override
  void onInit() {
    super.onInit();
    
    orderId =  Get.arguments['orderId'];
    order.value =  Get.arguments['order'];
    requestOrderDetails();
  }

  Future<void> requestOrderDetails() async {
    isLoading.value = true;
    final response = await _orderUseCase.requestOrderDetails(
      OrderDetailsRequest(orderId: orderId),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    final data = response.data;
    if (data == null) return;

    order.value = data;
    estimatedDelivery.value = data.estimatedDelivery ?? '';
    steps.assignAll(data.steps ?? []);
  }

  
}
