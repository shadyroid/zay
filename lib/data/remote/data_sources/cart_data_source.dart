import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/remote/dio_client.dart';
import 'package:zay/domain/models/requests/add_cart_item_request.dart';
import 'package:zay/domain/models/requests/delete_cart_item_request.dart';
import 'package:zay/domain/models/requests/update_cart_item_request.dart';

class CartDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestCart() async {
    final response = await _dioClient.get(Constants.cartPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestAddCartItem(
    AddCartItemRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.cartItemsPath,
      data: {
        'product_id': request.productId,
        'product_size_id': request.productSizeId,
        'quantity': request.quantity,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestUpdateCartItem(
    UpdateCartItemRequest request,
  ) async {
    final response = await _dioClient.post(
      '${Constants.cartItemsPath}/${request.cartItemId}',
      data: {'quantity': request.quantity},
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestDeleteCartItem(
    DeleteCartItemRequest request,
  ) async {
    final response = await _dioClient.delete(
      '${Constants.cartItemsPath}/${request.cartItemId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
