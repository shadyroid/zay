import 'package:get/get.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/domain/models/beans/order_track_step_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrderTrackController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final order = Rxn<OrderBean>();
  final steps = <OrderTrackStepBean>[].obs;
  final estimatedDelivery = ''.obs;

  late final String orderId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    orderId = args['orderId'] as String? ?? '';
    order.value = args['order'] as OrderBean?;
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadOrderIfNeeded(),
      requestOrderTrack(),
    ]);
  }

  Future<void> _loadOrderIfNeeded() async {
    if (order.value != null || orderId.isEmpty) return;
    final response = await _orderUseCase.requestOrderDetails(orderId: orderId);
    if (response.isSuccess) {
      order.value = response.data;
    }
  }

  Future<void> requestOrderTrack() async {
    if (orderId.isEmpty) return;
    isLoading.value = true;
    final response = await _orderUseCase.requestOrderTrack(orderId: orderId);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    estimatedDelivery.value = response.estimatedDelivery ?? '';
    steps.assignAll(response.steps ?? []);
  }

  void goBack() => Get.back();
}
