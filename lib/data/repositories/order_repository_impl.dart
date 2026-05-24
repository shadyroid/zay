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
    return OrderResponse.fromJson(json);
  }

  @override
  Future<OrdersResponse> requestOrders() async {
    final json = await _orderDataSource.requestOrders();
    return OrdersResponse.fromJson(json);
  }

  @override
  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request) async {
    final json = await _orderDataSource.requestOrderDetails(request);
    return OrderResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request) async {
    final json = await _orderDataSource.requestOrderReturn(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<ReturnReasonsResponse> requestReturnReasons() async {
    final json = await _orderDataSource.requestReturnReasons();
    return ReturnReasonsResponse.fromJson(json);
  }
}
