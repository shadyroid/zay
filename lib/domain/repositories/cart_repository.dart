import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/cart_response.dart';

abstract class CartRepository {
  Future<CartResponse> requestCart();

  Future<CartResponse> requestRemoveFromCart({required String productId});

  Future<BaseResponse> requestCheckout();
}
