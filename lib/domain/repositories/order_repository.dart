import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/order_response.dart';
import 'package:hedma/domain/models/responses/return_reasons_response.dart';
import 'package:hedma/domain/models/responses/orders_response.dart';
import 'package:hedma/domain/requests/create_order_request.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/domain/requests/order_return_request.dart';

abstract class OrderRepository {
  Future<OrderResponse> requestCreateOrder(CreateOrderRequest request);

  Future<OrdersResponse> requestOrders();

  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request);

  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request);

  Future<ReturnReasonsResponse> requestReturnReasons();
}
