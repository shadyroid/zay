import 'package:get/get.dart';
import 'package:hedma/data/repositories/order_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/order_response.dart';
import 'package:hedma/domain/models/responses/return_reasons_response.dart';
import 'package:hedma/domain/models/responses/orders_response.dart';
import 'package:hedma/domain/repositories/order_repository.dart';
import 'package:hedma/domain/requests/create_order_request.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/domain/requests/order_return_request.dart';

class OrderUseCase {
  final OrderRepository _orderRepository = Get.put(OrderRepositoryImpl());

  Future<BaseResponse> requestCreateOrder(CreateOrderRequest request) =>
      _orderRepository.requestCreateOrder(request);

  Future<OrdersResponse> requestOrders() => _orderRepository.requestOrders();

  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request) =>
      _orderRepository.requestOrderDetails(request);

  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request) =>
      _orderRepository.requestOrderReturn(request);

  Future<ReturnReasonsResponse> requestReturnReasons() =>
      _orderRepository.requestReturnReasons();
}
