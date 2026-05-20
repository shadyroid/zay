import 'package:hedma/data/remote/data_sources/cart_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/cart_response.dart';
import 'package:hedma/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource _cartDataSource = CartDataSource();

  @override
  Future<CartResponse> requestCart() async {
    final json = await _cartDataSource.requestCart();
    return CartResponse.fromJson(json);
  }

  @override
  Future<CartResponse> requestRemoveFromCart({
    required String productId,
  }) async {
    final json = await _cartDataSource.requestRemoveFromCart(
      productId: productId,
    );
    return CartResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestCheckout() async {
    final json = await _cartDataSource.requestCheckout();
    return BaseResponse.fromJson(json);
  }
}
