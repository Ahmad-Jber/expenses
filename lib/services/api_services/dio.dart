import 'package:dio/dio.dart';
import 'package:expenses/services/api_services/base_models.dart';
import 'package:expenses/services/api_services/interceptors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String localUrl = dotenv.env["BASE_LOCAL_URL"] ?? "";
String stagingUrl = dotenv.env["BASE_SERVER_URL"] ?? "";
Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: localUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  return dio;
}

class ApiClient {
  final Dio _dio;

  ApiClient(Dio dio):_dio=dio{
    dio.interceptors.addAll(
        [
          AuthenticationInterceptor(),
          ResponseInterceptor(),
          LoggingInterceptor(),
        ]
    );
  }

  Future<T> send<T>(ApiRequest<T> request) async {
    final response = await _dio.request(
      request.path,
      data: request.body,
      queryParameters: request.query,
      options: Options(
        method: request.method.name.toUpperCase(),
        headers: request.headers,
      ),
    );

    final data = response.data;

    if (request.parser != null) {
      return request.parser!(data);
    }

    return data as T;
  }
}
