import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
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

  Future<Map<String, dynamic>> requestProducts(ProductsRequest request) async {
    final response = await _dioClient.post(
      Constants.productsPath,
      data: request.image != null
          ? FormData.fromMap({
              'image': await MultipartFile.fromFile(
                request.image!.path,
                filename: request.image!.name,
              ),
              ...request.toJson(),
            })
          : request.toJson(),
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
    final response = await _dioClient.post(
      '${Constants.wishlistPath}/${request.productId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestUnFavorite(
    ProductIdRequest request,
  ) async {
    final response = await _dioClient.post(
      '${Constants.wishlistPath}/${request.productId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestTryProduct(
    TryProductRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.tryProductPath,
      data: FormData.fromMap({
        'product_id': request.productId,
        'photo': await MultipartFile.fromFile(
          request.image.path,
          filename: request.image.name,
        ),
      }),
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
