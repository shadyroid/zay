import 'package:hedma/data/remote/data_sources/order_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/order_response.dart';
import 'package:hedma/domain/models/responses/return_reasons_response.dart';
import 'package:hedma/domain/models/responses/orders_response.dart';
import 'package:hedma/domain/repositories/order_repository.dart';
import 'package:hedma/domain/requests/create_order_request.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/domain/requests/order_return_request.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource _orderDataSource = OrderDataSource();

  @override
  Future<OrderResponse> requestCreateOrder(CreateOrderRequest request) async {
    final json = await _orderDataSource.requestCreateOrder(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return OrderResponse.fromJson(json);
    }
    return OrderResponse.fromJson({
      ...json,
      'data': json['order'] is Map
          ? Map<String, dynamic>.from(json['order'] as Map)
          : null,
    });
  }

  @override
  Future<OrdersResponse> requestOrders() async {
    var json = await _orderDataSource.requestOrders();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return OrdersResponse.fromJson(json);
    }
    json = {
      "statusCode": json['statusCode'],
      "data": json['orders'],
    };
    return OrdersResponse.fromJson(json);
  }

  @override
  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request) async {
    var json = await _orderDataSource.requestOrderDetails(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return OrderResponse.fromJson(json);
    }
    json = {
      "statusCode": json['statusCode'],
      "data": json['order'],
    };
    return OrderResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request) async {
    final json = await _orderDataSource.requestOrderReturn(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<ReturnReasonsResponse> requestReturnReasons() async {
    final json = await _orderDataSource.requestReturnReasons();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ReturnReasonsResponse.fromJson(json);
    }
    return ReturnReasonsResponse.fromJson({
      ...json,
      'data': json['reasons'],
      'returnPolicy': json['return_policy'] as String?,
      'returnWindowDays': json['return_window_days'] as int?,
    });
  }
}
