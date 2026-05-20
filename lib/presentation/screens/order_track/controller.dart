import 'package:get/get.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrderTrackController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final steps = <String>[].obs;
  late final String orderId;
  final order = Rxn<OrderBean>();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    orderId = args['orderId'] as String? ?? '';
    order.value = args['order'] as OrderBean?;
    requestOrderTrack();
  }

  Future<void> requestOrderTrack() async {
    if (orderId.isEmpty) return;
    isLoading.value = true;
    final response = await _orderUseCase.requestOrderTrack(orderId: orderId);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    steps.assignAll(response.data?.map((s) => s.tr).toList() ?? []);
  }
}
