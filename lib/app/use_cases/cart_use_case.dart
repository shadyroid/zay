import 'package:get/get.dart';
import 'package:zay/data/repositories/cart_repository_impl.dart';
import 'package:zay/domain/models/responses/cart_response.dart';
import 'package:zay/domain/repositories/cart_repository.dart';
import 'package:zay/domain/models/requests/add_cart_item_request.dart';
import 'package:zay/domain/models/requests/delete_cart_item_request.dart';
import 'package:zay/domain/models/requests/update_cart_item_request.dart';

class CartUseCase {
  final CartRepository _cartRepository = Get.put(CartRepositoryImpl());

  Future<CartResponse> requestCart() => _cartRepository.requestCart();

  Future<CartResponse> requestAddCartItem(AddCartItemRequest request) =>
      _cartRepository.requestAddCartItem(request);

  Future<CartResponse> requestUpdateCartItem(UpdateCartItemRequest request) =>
      _cartRepository.requestUpdateCartItem(request);

  Future<CartResponse> requestDeleteCartItem(DeleteCartItemRequest request) =>
      _cartRepository.requestDeleteCartItem(request);
}
