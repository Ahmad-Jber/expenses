import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expenses/services/api_services/base_models.dart';
import 'package:expenses/services/api_services/dio.dart';
import 'package:expenses/services/local_storage.dart';
import 'package:flutter/foundation.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(await buildRequestHeader());
    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token refresh logic.
      final newToken = await _refreshToken();
      if (newToken != null) {
        // Retry the request with the new token
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';
        final response = await createDio().request(
          options.path,
          options: Options(
            method: options.method,
            headers: options.headers,
          ),
        );
        return handler.resolve(response);
      }
    }
    super.onError(err, handler);
  }
}

class ResponseInterceptor extends Interceptor {
  @override
  Future onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      handler.next(response);
      return;
    }

    // If backend doesn't follow BaseResponse
    if (!data.containsKey('success')) {
      handler.next(response);
      return;
    }

    final bool success = data['success'] == true;

    if (success) {
      // ✅ Always return ONLY the result
      response.data = data['result'];
      handler.next(response);
    } else {
      final error = data['error'];
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: ApiException(
            error?['message'] ?? 'Unknown error',
            exceptionType: error?['exceptionType'],
          ),
          type: DioExceptionType.badResponse,
        ),
      );
    }
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('┌──────────────────────────────────────────');
    debugPrint('│ 🚀 REQUEST');
    debugPrint('│ ${options.method} ${options.uri}');
    debugPrint('│ Headers:');
    options.headers.forEach((k, v) {
      debugPrint('│   $k: $v');
    });

    if (options.data != null) {
      debugPrint('│ Body:');
      debugPrint(prettyJson(options.data));
    }

    debugPrint('└──────────────────────────────────────────');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('┌──────────────────────────────────────────');
    debugPrint('│ ✅ RESPONSE');
    debugPrint('│ ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('│ Data:');
    debugPrint(prettyJson(response.data));
    debugPrint('└──────────────────────────────────────────');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('┌──────────────────────────────────────────');
    debugPrint('│ ❌ ERROR');
    debugPrint('│ ${err.requestOptions.method} ${err.requestOptions.uri}');
    debugPrint('│ Status: ${err.response?.statusCode}');
    debugPrint('│ Message: ${err.message}');
    debugPrint('│ Data:');
    debugPrint(prettyJson(err.response?.data));
    debugPrint('└──────────────────────────────────────────');

    handler.next(err);
  }
}

Future<dynamic> _refreshToken() async {}
String prettyJson(dynamic data) {
  try {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  } catch (_) {
    return data.toString();
  }
}
Future<Map<String, String>> buildRequestHeader() async {
  var token = await LocalStorage.readData("AccessToken");
  return {
    "Authorization": "Bearer $token",
  };
}
