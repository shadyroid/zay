import 'package:zay/data/remote/data_sources/cart_data_source.dart';
import 'package:zay/domain/models/responses/cart_response.dart';
import 'package:zay/domain/repositories/cart_repository.dart';
import 'package:zay/domain/requests/add_cart_item_request.dart';
import 'package:zay/domain/requests/delete_cart_item_request.dart';
import 'package:zay/domain/requests/update_cart_item_request.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource _cartDataSource = CartDataSource();

  @override
  Future<CartResponse> requestCart() async {
    var json = await _cartDataSource.requestCart();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['items'],
    };
    return CartResponse.fromJson(json);
  }

  @override
  Future<CartResponse> requestAddCartItem(AddCartItemRequest request) async {
    await _cartDataSource.requestAddCartItem(request);
    return requestCart();
  }

  @override
  Future<CartResponse> requestUpdateCartItem(
    UpdateCartItemRequest request,
  ) async {
    await _cartDataSource.requestUpdateCartItem(request);
    return requestCart();
  }

  @override
  Future<CartResponse> requestDeleteCartItem(
    DeleteCartItemRequest request,
  ) async {
    await _cartDataSource.requestDeleteCartItem(request);
    return requestCart();
  }
}
