import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' hide FormData;
import 'package:dio/dio.dart' as dio_multipart show FormData;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/preferences/prefs_manager.dart';

class DioClient extends GetxService {
  late Dio _dio;

  Dio get dio => _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        validateStatus: (status) => true,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['accept'] = 'application/json';
          options.headers['Accept'] = 'application/json';

          final locale = PrefsManager.locale ?? Get.locale?.languageCode ?? 'ar';
          options.headers['Accept-Language'] = locale;
          options.headers['Lang'] = locale == 'ar' ? 'rtl' : 'ltr';

          final token = PrefsManager.token;
          if (token?.isNotEmpty == true) {
            options.headers['authorization'] = 'bearer $token';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // return handler.resolve(
          //   Response(
          //     requestOptions: response.requestOptions,
          //     statusCode: 200,
          //     data: {
          //       'statusCode':-1,
          //       'message': 'noInternetTitle'.tr ,
          //       'data': null,
          //     },
          //   ),
          // );
          response.data = _mapResponse(response);
          response.statusCode = 200;
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          final errorResponse = error.response;
          if (errorResponse != null) {
            errorResponse.data = _mapResponse(errorResponse);
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

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: false,
          responseHeader: false,
          error: true,
          requestHeader: true,
          logPrint: (object) => log(object.toString()),
        ),
      );
    }
  }

  static Map<String, dynamic> _mapResponse(Response<dynamic> response) {
    final httpStatus = response.statusCode ?? -2;
    final raw = response.data;

    if (raw is! Map) {
      return {
        'statusCode': httpStatus,
        'message': 'Unexpected response format',
      };
    }

    final body = Map<String, dynamic>.from(raw);

    if (httpStatus >= 200 && httpStatus < 300) {
      return {
        ...body,
        'statusCode': httpStatus,
      };
    }

    return {
      'statusCode': httpStatus,
      'message': _extractErrorMessage(body),
    };
  }

  static String? _extractErrorMessage(Map<String, dynamic> body) {
    final errors = body['errors'];
    if (errors is Map) {
      for (final entry in errors.entries) {
        final messages = entry.value;
        if (messages is List && messages.isNotEmpty) {
          return messages.first.toString();
        }
        if (messages is String && messages.isNotEmpty) {
          return messages;
        }
      }
    }
    return body['message'] as String?;
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
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
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

}
