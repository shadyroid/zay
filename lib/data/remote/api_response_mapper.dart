import 'package:dio/dio.dart';

abstract final class ApiResponseMapper {
  static Map<String, dynamic> fromDioResponse(Response<dynamic> response) {
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
      return _normalizeSuccess(body);
    }

    return {
      'statusCode': httpStatus,
      'message': _extractErrorMessage(body),
    };
  }

  static Map<String, dynamic> _normalizeSuccess(Map<String, dynamic> body) {
    final normalized = <String, dynamic>{
      'statusCode': 200,
      'message': body['message'] as String?,
    };

    final data = body['data'];
    if (data is Map<String, dynamic>) {
      if (data['products'] is List) {
        normalized['data'] = data['products'];
        final pagination = data['pagination'] ?? body['pagination'];
        if (pagination is Map) {
          normalized['totalCount'] = pagination['total'];
        }
      } else {
        normalized['data'] = data;
      }
    } else if (data is List) {
      normalized['data'] = data;
    } else if (body['user'] is Map) {
      normalized['data'] = Map<String, dynamic>.from(body['user'] as Map);
    } else if (body['page'] is Map) {
      final page = Map<String, dynamic>.from(body['page'] as Map);
      normalized['data'] = page['content'] as String? ?? '';
      normalized['title'] = page['title'] as String?;
    } else if (body['product'] is Map) {
      normalized['data'] = Map<String, dynamic>.from(body['product'] as Map);
      if (body['similar_products'] is List) {
        normalized['similarProducts'] = body['similar_products'];
      }
    } else if (body['shop'] is Map) {
      normalized['data'] = Map<String, dynamic>.from(body['shop'] as Map);
    } else if (body['items'] is List) {
      normalized['data'] = body['items'];
    } else if (body['wishlist'] is List) {
      normalized['data'] = body['wishlist'];
      final pagination = body['pagination'];
      if (pagination is Map) {
        normalized['totalCount'] = pagination['total'];
      }
    } else if (body['reviews'] is List) {
      normalized['data'] = body['reviews'];
      if (body['summary'] is Map) {
        normalized['summary'] = body['summary'];
      }
    } else if (body['reasons'] is List) {
      normalized['data'] = body['reasons'];
      normalized['returnPolicy'] = body['return_policy'] as String?;
      normalized['returnWindowDays'] = body['return_window_days'] as int?;
    } else if (body['sizes'] is List) {
      normalized['data'] = body['sizes'];
    } else if (body['categories'] is List) {
      normalized['data'] = body['categories'];
    } else if (body['products'] is List) {
      normalized['data'] = body['products'];
      final pagination = body['pagination'];
      if (pagination is Map) {
        normalized['totalCount'] = pagination['total'];
      }
    } else if (body['shops'] is List) {
      normalized['data'] = body['shops'];
    } else if (body['orders'] is List) {
      normalized['data'] = body['orders'];
    } else if (body['order'] is Map) {
      normalized['data'] = Map<String, dynamic>.from(body['order'] as Map);
    } else if (body['token'] != null) {
      normalized['data'] = {'token': body['token']};
    }

    return normalized;
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
}
