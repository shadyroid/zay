import 'package:dio/dio.dart' as dio_multipart show MultipartFile;
import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dio_client.dart';
import 'package:hedma/domain/requests/product_details_request.dart';
import 'package:hedma/domain/requests/product_id_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/domain/requests/try_product_request.dart';

class ProductsDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestCategories() async {
    final response = await _dioClient.get(Constants.categoriesPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestSizes() async {
    final response = await _dioClient.get(Constants.sizesPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestProducts({
    ProductsRequest request = const ProductsRequest(),
  }) async {
    if (request.image != null && request.image!.isNotEmpty) {
      final fields = Map<String, dynamic>.from(request.toQueryParameters());
      fields['image'] = await dio_multipart.MultipartFile.fromFile(
        request.image!,
      );
      final response = await _dioClient.post(
        Constants.productsPath,
        data: fields,
      );
      return Map<String, dynamic>.from(response.data as Map);
    }

    final response = await _dioClient.get(
      Constants.productsPath,
      queryParameters: request.toQueryParameters(),
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestProductDetails(
    ProductDetailsRequest request,
  ) async {
    final response = await _dioClient.get(
      '${Constants.productDetailsPath}/${request.productId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestFavorites() async {
    final response = await _dioClient.get(Constants.wishlistPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestFavorite(ProductIdRequest request) async {
    final response =
        await _dioClient.post('${Constants.wishlistPath}/${request.productId}');
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestUnFavorite(
    ProductIdRequest request,
  ) async {
    final response =
        await _dioClient.post('${Constants.wishlistPath}/${request.productId}');
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestTryProduct(
    TryProductRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.tryProductPath,
      data: {
        'product_id': request.productId,
        'photo': await dio_multipart.MultipartFile.fromFile(
          request.imagePath,
          filename: request.imagePath.split('/').last,
        ),
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
