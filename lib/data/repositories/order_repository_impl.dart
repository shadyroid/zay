import 'package:zay/data/remote/data_sources/order_data_source.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/order_response.dart';
import 'package:zay/domain/models/responses/orders_response.dart';
import 'package:zay/domain/models/responses/return_reasons_response.dart';
import 'package:zay/domain/repositories/order_repository.dart';
import 'package:zay/domain/models/requests/create_order_request.dart';
import 'package:zay/domain/models/requests/order_details_request.dart';
import 'package:zay/domain/models/requests/order_return_request.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource _orderDataSource = OrderDataSource();

  @override
  Future<BaseResponse> requestCreateOrder(CreateOrderRequest request) async {
    var json = await _orderDataSource.requestCreateOrder(request);
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['order'],
    };
    return OrderResponse.fromJson(json);
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
