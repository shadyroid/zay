import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dio_client.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';
import 'package:hedma/domain/requests/create_order_request.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/domain/requests/order_return_request.dart';

class OrderDataSource {
  final DioClient _dioClient = Get.find<DioClient>();
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestCreateOrder(
    CreateOrderRequest request,
  ) =>
      _remote.post(
        Constants.createOrderPath,
        variables: {
          'address': request.address,
          'latitude': request.latitude,
          'longitude': request.longitude,
          'mobileNumber': request.mobileNumber,
          'paymentMethod': request.paymentMethod,
        },
        dummyJson: DummyJson.createOrder(),
      );

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
    final response = await _dioClient.postForm(
      '${Constants.orderReturnPath}/${request.orderId}',
      fields: {
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
