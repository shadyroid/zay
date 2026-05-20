import 'package:get/get.dart';
import 'package:hedma/data/repositories/order_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/order_response.dart';
import 'package:hedma/domain/models/responses/order_track_response.dart';
import 'package:hedma/domain/models/responses/orders_response.dart';
import 'package:hedma/domain/repositories/order_repository.dart';

class OrderUseCase {
  final OrderRepository _orderRepository = Get.put(OrderRepositoryImpl());

  Future<OrderResponse> requestCreateOrder({
    required String address,
    required double latitude,
    required double longitude,
    required String mobileNumber,
    required String paymentMethod,
    required List<Map<String, dynamic>> items,
  }) =>
      _orderRepository.requestCreateOrder(
        address: address,
        latitude: latitude,
        longitude: longitude,
        mobileNumber: mobileNumber,
        paymentMethod: paymentMethod,
        items: items,
      );

  Future<OrdersResponse> requestOrders() => _orderRepository.requestOrders();

  Future<OrderResponse> requestOrderDetails({required String orderId}) =>
      _orderRepository.requestOrderDetails(orderId: orderId);

  Future<OrderTrackResponse> requestOrderTrack({required String orderId}) =>
      _orderRepository.requestOrderTrack(orderId: orderId);

  Future<BaseResponse> requestOrderReturn({
    required String orderId,
    required String reason,
  }) =>
      _orderRepository.requestOrderReturn(orderId: orderId, reason: reason);
}
