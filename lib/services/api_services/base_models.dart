class ErrorResponse {
  final String? message;
  final String? exceptionType;

  ErrorResponse({
    this.message,
    this.exceptionType,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'],
      exceptionType: json['exceptionType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'exceptionType': exceptionType,
    };
  }
}

class BaseResponse<T> {
  final T? result;
  final ErrorResponse? error;
  final String? message;
  final DateTime requestedAt;
  final bool isAuthenticated;

  BaseResponse({
    this.result,
    this.error,
    this.message,
    DateTime? requestedAt,
    this.isAuthenticated = false,
  }) : requestedAt = requestedAt ?? DateTime.now();

  bool get success => error == null;

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return BaseResponse<T>(
      result: json['result'] != null ? fromJsonT(json['result']) : null,
      error: json['error'] != null
          ? ErrorResponse.fromJson(json['error'])
          : null,
      message: json['message'],
      requestedAt: json['requestedAt'] != null
          ? DateTime.parse(json['requestedAt'])
          : null,
      isAuthenticated: json['isAuthenticated'] ?? false,
    );
  }

  Map<String, dynamic> toJson(
      Object? Function(T value) toJsonT,
      ) {
    return {
      'result': result != null ? toJsonT(result as T) : null,
      'error': error?.toJson(),
      'message': message,
      'requestedAt': requestedAt.toIso8601String(),
      'isAuthenticated': isAuthenticated,
      'success': success,
    };
  }
}

class ApiException implements Exception {
  final String message;
  final String? exceptionType;

  ApiException(this.message, {this.exceptionType});

  @override
  String toString() => message;
}

class ApiRequest<T> {
  final String path;
  final HttpMethod method;
  final Map<String, dynamic>? query;
  final dynamic body;
  final Map<String, dynamic>? headers;
  final T Function(dynamic json)? parser;

  ApiRequest({
    required this.path,
    required this.method,
    this.query,
    this.body,
    this.headers,
    this.parser,
  });
}

enum HttpMethod { get, post, put, delete, patch }
