import 'package:zay/domain/models/beans/order_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/order_response.dart';
import 'package:zay/domain/models/responses/orders_response.dart';
import 'package:zay/domain/models/responses/payment_initiate_response.dart';
import 'package:zay/domain/models/responses/payment_status_response.dart';
import 'package:zay/domain/models/responses/return_reasons_response.dart';
import 'package:zay/domain/models/responses/summary_response.dart';
import 'package:zay/domain/models/requests/create_order_request.dart';
import 'package:zay/domain/models/requests/order_details_request.dart';
import 'package:zay/domain/models/requests/order_return_request.dart';
import 'package:zay/domain/models/requests/payment_request.dart';
import 'package:zay/domain/models/requests/summary_request.dart';
import 'package:zay/domain/models/requests/validate_coupon_request.dart';
import 'package:zay/domain/models/responses/validate_coupon_response.dart';

abstract class OrderRepository {
  Future<OrderResponse> requestCreateOrder(CreateOrderRequest request);

  Future<ValidateCouponResponse> requestValidateCoupon(
    ValidateCouponRequest request,
  );

  Future<PaymentInitiateResponse> requestInitiatePayment(
    PaymentRequest request,
  );

  Future<PaymentStatusResponse> requestPaymentStatus(PaymentRequest request);

  Future<SummaryResponse> requestSummary(SummaryRequest request);

  Future<OrdersResponse> requestOrders();

  Future<OrderResponse> requestOrderDetails(OrderDetailsRequest request);

  Future<BaseResponse> requestOrderReturn(OrderReturnRequest request);

  Future<ReturnReasonsResponse> requestReturnReasons();

  /// Returns a delivered, unreviewed order when the prompt interval allows.
  Future<OrderBean?> requestLastReview();
}
