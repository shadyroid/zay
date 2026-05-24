import 'package:hedma/data/remote/data_sources/cart_data_source.dart';
import 'package:hedma/domain/models/responses/cart_response.dart';
import 'package:hedma/domain/repositories/cart_repository.dart';
import 'package:hedma/domain/requests/add_cart_item_request.dart';
import 'package:hedma/domain/requests/delete_cart_item_request.dart';
import 'package:hedma/domain/requests/update_cart_item_request.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource _cartDataSource = CartDataSource();

  @override
  Future<CartResponse> requestCart() async {
    final json = await _cartDataSource.requestCart();
    return CartResponse.fromJson(json);
  }

  @override
  Future<CartResponse> requestAddCartItem(AddCartItemRequest request) async {
    final json = await _cartDataSource.requestAddCartItem(request);
    return _cartAfterMutation(json);
  }

  @override
  Future<CartResponse> requestUpdateCartItem(
    UpdateCartItemRequest request,
  ) async {
    final json = await _cartDataSource.requestUpdateCartItem(request);
    return _cartAfterMutation(json);
  }

  @override
  Future<CartResponse> requestDeleteCartItem(
    DeleteCartItemRequest request,
  ) async {
    final json = await _cartDataSource.requestDeleteCartItem(request);
    return _cartAfterMutation(json);
  }

  Future<CartResponse> _cartAfterMutation(Map<String, dynamic> json) async {
    if ((json['statusCode'] as int? ?? -2) != 200) {
      return CartResponse.fromJson(json);
    }
    return requestCart();
  }
}
