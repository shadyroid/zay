import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dio_client.dart';
import 'package:hedma/domain/requests/create_order_request.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/domain/requests/order_return_request.dart';

class OrderDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestCreateOrder(
    CreateOrderRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.createOrderPath,
      data: {
        'lat': request.lat,
        'lng': request.lng,
        'address': request.address,
        'phone': request.phone,
        'recipient_name': request.recipientName,
        'payment_method': request.paymentMethod,
        'notes': request.notes?.trim() ?? '',
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestOrders() async {
    final response = await _dioClient.get(Constants.ordersPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestOrderDetails(
    OrderDetailsRequest request,
  ) async {
    final response = await _dioClient.get(
      '${Constants.orderDetailsPath}/${request.orderId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestOrderReturn(
    OrderReturnRequest request,
  ) async {
    final response = await _dioClient.post(
      '${Constants.orderReturnPath}/${request.orderId}',
      data: {
        'reason': request.reason,
        'description': request.description,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestReturnReasons() async {
    final response = await _dioClient.get(Constants.returnReasonsPath);
    return Map<String, dynamic>.from(response.data as Map);
  }
}
