import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/order_response.dart';
import 'package:hedma/domain/models/responses/order_track_response.dart';
import 'package:hedma/domain/models/responses/orders_response.dart';

abstract class OrderRepository {
  Future<OrderResponse> requestCreateOrder({
    required String address,
    required double latitude,
    required double longitude,
    required String mobileNumber,
    required String paymentMethod,
    required List<Map<String, dynamic>> items,
  });

  Future<OrdersResponse> requestOrders();

  Future<OrderResponse> requestOrderDetails({required String orderId});

  Future<OrderTrackResponse> requestOrderTrack({required String orderId});

  Future<BaseResponse> requestOrderReturn({
    required String orderId,
    required String reason,
  });
}
