import 'package:hedma/data/remote/data_sources/order_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/order_response.dart';
import 'package:hedma/domain/models/responses/order_track_response.dart';
import 'package:hedma/domain/models/responses/orders_response.dart';
import 'package:hedma/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource _orderDataSource = OrderDataSource();

  @override
  Future<OrderResponse> requestCreateOrder({
    required String address,
    required double latitude,
    required double longitude,
    required String mobileNumber,
    required String paymentMethod,
    required List<Map<String, dynamic>> items,
  }) async {
    final json = await _orderDataSource.requestCreateOrder(
      body: {
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'mobileNumber': mobileNumber,
        'paymentMethod': paymentMethod,
        'items': items,
      },
    );
    return OrderResponse.fromJson(json);
  }

  @override
  Future<OrdersResponse> requestOrders() async {
    final json = await _orderDataSource.requestOrders();
    return OrdersResponse.fromJson(json);
  }

  @override
  Future<OrderResponse> requestOrderDetails({required String orderId}) async {
    final json = await _orderDataSource.requestOrderDetails(orderId: orderId);
    return OrderResponse.fromJson(json);
  }

  @override
  Future<OrderTrackResponse> requestOrderTrack({required String orderId}) async {
    final json = await _orderDataSource.requestOrderTrack(orderId: orderId);
    return OrderTrackResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestOrderReturn({
    required String orderId,
    required String reason,
  }) async {
    final json = await _orderDataSource.requestOrderReturn(
      orderId: orderId,
      reason: reason,
    );
    return BaseResponse.fromJson(json);
  }
}
