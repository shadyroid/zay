import 'package:zay/domain/models/enums/payment_method.dart';
import 'package:zay/domain/models/enums/payment_status.dart';
import 'package:zay/data/remote/data_sources/order_data_source.dart';
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
import 'package:get/get.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource _orderDataSource = Get.put(OrderDataSource());

  @override
  Future<OrderResponse> requestCreateOrder(CreateOrderRequest request) async {
    var json = await _orderDataSource.requestCreateOrder(request);
    final order = json['order'];
    String? paymentUrl;
    PaymentStatus? paymentStatus;

    if (request.paymentMethod == PaymentMethod.card.apiValue &&
        order is Map &&
        order['id'] != null) {
      final initiateJson = await _orderDataSource.requestInitiatePayment(
        PaymentRequest(orderId: order['id'] as int),
      );
      final initiate = PaymentInitiateResponse.fromJson(initiateJson);
      if (initiate.isSuccess) {
        paymentUrl = initiate.paymentUrl;
        paymentStatus = initiate.paymentStatus;
      } else {
        return OrderResponse(
          statusCode: initiate.statusCode,
          message: initiate.message,
        );
      }
    }

    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": order,
      "payment_url": paymentUrl,
      "payment_status": paymentStatus?.apiValue,
    };
    return OrderResponse.fromJson(json);
  }

  @override
  Future<PaymentInitiateResponse> requestInitiatePayment(
    PaymentRequest request,
  ) async {
    final json = await _orderDataSource.requestInitiatePayment(request);
    return PaymentInitiateResponse.fromJson(json);
  }

  @override
  Future<PaymentStatusResponse> requestPaymentStatus(
    PaymentRequest request,
  ) async {
    final json = await _orderDataSource.requestPaymentStatus(request);
    return PaymentStatusResponse.fromJson(json);
  }

  @override
  Future<SummaryResponse> requestSummary(SummaryRequest request) async {
    final json = await _orderDataSource.requestSummary(request);
    return SummaryResponse.fromJson(json);
  }

  @override
  Future<OrdersResponse> requestOrders() async {
    var json = await _orderDataSource.requestOrders();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['orders'],
    };
    return OrdersResponse.fromJson(json);
  }

  @override
  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request) async {
    var json = await _orderDataSource.requestOrderDetails(request);
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['order'],
    };
    return OrderResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request) async {
    final json = await _orderDataSource.requestOrderReturn(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<ReturnReasonsResponse> requestReturnReasons() async {
    var json = await _orderDataSource.requestReturnReasons();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['reasons'],
      'returnPolicy': json['return_policy'] as String?,
      'returnWindowDays': json['return_window_days'] as int?,
    };
    return ReturnReasonsResponse.fromJson(json);
  }
}
