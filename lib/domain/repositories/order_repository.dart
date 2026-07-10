import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/order_response.dart';
import 'package:zay/domain/models/responses/return_reasons_response.dart';
import 'package:zay/domain/models/responses/orders_response.dart';
import 'package:zay/domain/requests/create_order_request.dart';
import 'package:zay/domain/requests/order_details_request.dart';
import 'package:zay/domain/requests/order_return_request.dart';

abstract class OrderRepository {
  Future<BaseResponse> requestCreateOrder(CreateOrderRequest request);

  Future<OrdersResponse> requestOrders();

  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request);

  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request);

  Future<ReturnReasonsResponse> requestReturnReasons();
}
