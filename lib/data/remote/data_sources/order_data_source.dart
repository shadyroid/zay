import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';

class OrderDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestOrders() => _remote.post(
        Constants.ordersPath,
        dummyJson: DummyJson.orders(),
      );

  Future<Map<String, dynamic>> requestOrderDetails({
    required String orderId,
  }) =>
      _remote.post(
        Constants.orderDetailsPath,
        variables: {'orderId': orderId},
        dummyJson: DummyJson.orderDetails(orderId),
      );

  Future<Map<String, dynamic>> requestOrderTrack({
    required String orderId,
  }) =>
      _remote.post(
        Constants.orderTrackPath,
        variables: {'orderId': orderId},
        dummyJson: DummyJson.orderTrack(),
      );

  Future<Map<String, dynamic>> requestOrderReturn({
    required String orderId,
    required String reason,
  }) =>
      _remote.post(
        Constants.orderReturnPath,
        variables: {'orderId': orderId, 'reason': reason},
        dummyJson: DummyJson.orderReturn(),
      );
}
