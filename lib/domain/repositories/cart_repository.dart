import 'package:zay/domain/models/responses/cart_response.dart';
import 'package:zay/domain/models/requests/add_cart_item_request.dart';
import 'package:zay/domain/models/requests/delete_cart_item_request.dart';
import 'package:zay/domain/models/requests/update_cart_item_request.dart';

abstract class CartRepository {
  Future<CartResponse> requestCart();

  Future<CartResponse> requestAddCartItem(AddCartItemRequest request);

  Future<CartResponse> requestUpdateCartItem(UpdateCartItemRequest request);

  Future<CartResponse> requestDeleteCartItem(DeleteCartItemRequest request);
}
