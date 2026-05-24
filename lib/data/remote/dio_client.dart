import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' hide FormData;
import 'package:dio/dio.dart' as dio_multipart show FormData;
import 'package:get/get.dart' hide Response, FormData;
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/data/remote/api_response_mapper.dart';

/// When `true` on [RequestOptions.extra], the raw response body is preserved.
const String kSkipResponseMapper = 'skipResponseMapper';

class DioClient extends GetxService {
  late Dio _dio;

  Dio get dio => _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        validateStatus: (status) => true,
        receiveDataWhenStatusError: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['accept'] = 'application/json';
          options.headers['Accept'] = 'application/json';

          final locale = PrefsManager.locale ?? Get.locale?.languageCode ?? 'en';
          options.headers['Accept-Language'] = locale;
          options.headers['Lang'] = locale == 'ar' ? 'rtl' : 'ltr';

          final token = PrefsManager.token;
          if (token?.isNotEmpty == true) {
            options.headers['authorization'] = 'bearer $token';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.requestOptions.extra[kSkipResponseMapper] == true) {
            response.statusCode = 200;
            return handler.next(response);
          }

          response.data = ApiResponseMapper.fromDioResponse(response);
          response.statusCode = 200;
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          if (error.requestOptions.extra[kSkipResponseMapper] == true) {
            return handler.next(error);
          }

          final errorResponse = error.response;
          if (errorResponse != null) {
            errorResponse.data = ApiResponseMapper.fromDioResponse(errorResponse);
            errorResponse.statusCode = 200;
            return handler.resolve(errorResponse);
          }

          final isNoConnection =
              error.type == DioExceptionType.connectionError ||
                  error.type == DioExceptionType.connectionTimeout ||
                  error.type == DioExceptionType.receiveTimeout ||
                  error.type == DioExceptionType.sendTimeout ||
                  error.error is SocketException;

          return handler.resolve(
            Response(
              requestOptions: error.requestOptions,
              statusCode: 200,
              data: {
                'statusCode': isNoConnection ? -1 : -2,
                'message': isNoConnection ? 'noInternetTitle'.tr : null,
                'data': null,
              },
            ),
          );
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        requestHeader: true,
        logPrint: (object) => log(object.toString()),
      ),
    );
  }

  Future<Response> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postForm(
    String path, {
    required Map<String, dynamic> fields,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      post(
        path,
        data: dio_multipart.FormData.fromMap(fields),
        queryParameters: queryParameters,
        options: options,
      );

  /// Legacy `{ variables: ... }` body used by [RemotePost].
  Future<Response> postVariables(
    String path, {
    Map<String, dynamic>? variables,
  }) =>
      post(
        path,
        data: {'variables': variables ?? {}},
        options: Options(extra: {kSkipResponseMapper: true}),
      );
}
