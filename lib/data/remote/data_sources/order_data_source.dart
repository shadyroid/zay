import 'package:dio/dio.dart' as dio_multipart show FormData;
import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/remote/dio_client.dart';
import 'package:zay/domain/models/requests/create_order_request.dart';
import 'package:zay/domain/models/requests/order_details_request.dart';
import 'package:zay/domain/models/requests/order_return_request.dart';
import 'package:zay/domain/models/requests/payment_request.dart';
import 'package:zay/domain/models/requests/summary_request.dart';
import 'package:zay/domain/models/requests/validate_coupon_request.dart';

class OrderDataSource {
  final DioClient _dioClient = Get.put(DioClient());

  Future<Map<String, dynamic>> requestCreateOrder(
    CreateOrderRequest request,
  ) async {
    final data = <String, dynamic>{
      'lat': request.lat,
      'lng': request.lng,
      'address': request.address,
      'city_id': request.cityId,
      'phone': request.phone,
      'recipient_name': request.recipientName,
      'payment_method': request.paymentMethod,
      'notes': request.notes?.trim() ?? '',
    };
    final couponCode = request.couponCode?.trim();
    if (couponCode != null && couponCode.isNotEmpty) {
      data['coupon_code'] = couponCode;
    }
    final response = await _dioClient.post(
      Constants.createOrderPath,
      data: data,
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestValidateCoupon(
    ValidateCouponRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.validateCouponPath,
      data: {
        'code': request.code,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestInitiatePayment(
    PaymentRequest request,
  ) async {
    final response = await _dioClient.post(
      '${Constants.paymentInitiatePath}/${request.orderId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestPaymentStatus(
    PaymentRequest request,
  ) async {
    final response = await _dioClient.get(
      '${Constants.paymentStatusPath}/${request.orderId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestSummary(SummaryRequest request) async {
    final data = <String, dynamic>{
      'city_id': request.cityId,
    };
    final paymentMethod = request.paymentMethod?.trim();
    if (paymentMethod != null && paymentMethod.isNotEmpty) {
      data['payment_method'] = paymentMethod;
    }
    final response = await _dioClient.post(
      Constants.shippingCalculatePath,
      data: data,
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
