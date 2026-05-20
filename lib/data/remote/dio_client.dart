import 'package:dio/dio.dart' hide Response;
import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class DioClient extends GetxService {
  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        validateStatus: (_) => true,
      ),
    );
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? variables,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: {'variables': variables ?? {}},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return BaseResponse(statusCode: -1).toJson();
      }
      return BaseResponse(statusCode: -2).toJson();
    }
  }
}

extension _BaseResponseJson on BaseResponse {
  Map<String, dynamic> toJson() => {
        'message': message,
        'statusCode': statusCode,
      };
}
