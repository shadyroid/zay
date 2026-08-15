import 'package:get/get.dart';
import 'package:zay/data/repositories/order_repository_impl.dart';
import 'package:zay/domain/models/beans/order_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/order_response.dart';
import 'package:zay/domain/models/responses/orders_response.dart';
import 'package:zay/domain/models/responses/payment_initiate_response.dart';
import 'package:zay/domain/models/responses/payment_status_response.dart';
import 'package:zay/domain/models/responses/return_reasons_response.dart';
import 'package:zay/domain/models/responses/summary_response.dart';
import 'package:zay/domain/repositories/order_repository.dart';
import 'package:zay/domain/models/requests/create_order_request.dart';
import 'package:zay/domain/models/requests/order_details_request.dart';
import 'package:zay/domain/models/requests/order_return_request.dart';
import 'package:zay/domain/models/requests/payment_request.dart';
import 'package:zay/domain/models/requests/summary_request.dart';

class OrderUseCase {
  final OrderRepository _orderRepository = Get.put(OrderRepositoryImpl());

  Future<OrderResponse> requestCreateOrder(CreateOrderRequest request) =>
      _orderRepository.requestCreateOrder(request);

  Future<PaymentInitiateResponse> requestInitiatePayment(
    PaymentRequest request,
  ) =>
      _orderRepository.requestInitiatePayment(request);

  Future<PaymentStatusResponse> requestPaymentStatus(PaymentRequest request) =>
      _orderRepository.requestPaymentStatus(request);

  Future<SummaryResponse> requestSummary(SummaryRequest request) =>
      _orderRepository.requestSummary(request);

  Future<OrdersResponse> requestOrders() => _orderRepository.requestOrders();

  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request) =>
      _orderRepository.requestOrderDetails(request);

  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request) =>
      _orderRepository.requestOrderReturn(request);

  Future<ReturnReasonsResponse> requestReturnReasons() =>
      _orderRepository.requestReturnReasons();

  Future<OrderBean?> requestLastReview() =>
      _orderRepository.requestLastReview();
}
