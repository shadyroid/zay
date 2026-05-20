import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/domain/models/enums/order_list_filter.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrdersController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final orders = <OrderBean>[].obs;
  final selectedFilter = OrderListFilter.all.obs;

  List<OrderBean> get filteredOrders {
    return orders.where(_matchesFilter).toList(growable: false);
  }

  @override
  void onInit() {
    super.onInit();
    requestOrders();
  }

  Future<void> requestOrders() async {
    isLoading.value = true;
    final response = await _orderUseCase.requestOrders();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    orders.assignAll(response.data ?? []);
  }

  void selectFilter(OrderListFilter filter) {
    selectedFilter.value = filter;
  }

  bool _matchesFilter(OrderBean order) {
    switch (selectedFilter.value) {
      case OrderListFilter.all:
        return true;
      case OrderListFilter.active:
        return order.isActive;
      case OrderListFilter.completed:
        return order.isCompleted;
      case OrderListFilter.returned:
        return order.isReturned;
    }
  }

  void goBack() => Get.back();

  void navigateToOrderDetails(OrderBean order) {
    Get.toNamed(
      Routes.orderDetails,
      arguments: {'orderId': order.id, 'order': order},
    );
  }
}
