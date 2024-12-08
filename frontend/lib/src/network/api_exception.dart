import 'package:dio/dio.dart';

class DioException implements Exception {
  final String message;

  DioException(this.message);

  static String _handleDioError(DioException error) {
    switch (error) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Request timeout. Please try again.";
      case DioExceptionType.receiveTimeout:
        return "Response timeout. Please try again.";
      case DioExceptionType.badResponse:
        return "Server error: ${error.message}";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.unknown:
        return "Unexpected error: ${error.message}";
      default:
        return "Something went wrong. Please try again.";
    }
  }

  static DioException fromDioError(DioException error) {
    return DioException(_handleDioError(error));
  }

  @override
  String toString() => message;
}
