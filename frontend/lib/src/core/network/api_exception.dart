import 'package:dio/dio.dart';
import 'package:tugas_akhir/src/features/authentication/domain/auth_repository.dart';

class TimeoutException extends DioException {
  TimeoutException({required super.requestOptions});
  @override
  String toString() {
    return "Connection timeout. Please try again later";
  }
}

class UnknownErrorException extends DioException {
  UnknownErrorException({required super.requestOptions});
  @override
  String toString() {
    return "Unknown error occured. Please try again later";
  }
}

class NoInternetException extends DioException {
  NoInternetException({required super.requestOptions});
  @override
  String toString() {
    return "No internet detected, please check your connection";
  }
}

class CustomInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw TimeoutException(requestOptions: err.requestOptions);
      case DioExceptionType.connectionError:
        throw NoInternetException(requestOptions: err.requestOptions);
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        throw UnknownErrorException(requestOptions: err.requestOptions);
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      AuthRepository authRepository = AuthRepository();
      String? accessToken = await authRepository.getToken();

      // Add the token to the request headers if it exists
      if (accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } on DioException catch (err) {
      throw Exception(err);
    }
  }
}
