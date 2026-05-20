import 'package:get/get.dart';
import 'package:hedma/data/repositories/cart_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/cart_response.dart';
import 'package:hedma/domain/repositories/cart_repository.dart';

class CartUseCase {
  final CartRepository _cartRepository = Get.put(CartRepositoryImpl());

  Future<CartResponse> requestCart() => _cartRepository.requestCart();

  Future<CartResponse> requestRemoveFromCart({required String productId}) =>
      _cartRepository.requestRemoveFromCart(productId: productId);

  Future<BaseResponse> requestCheckout() => _cartRepository.requestCheckout();
}
