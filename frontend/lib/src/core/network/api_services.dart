import 'package:dio/dio.dart';
import 'package:tugas_akhir/env.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tugas_akhir/src/core/network/api_exception.dart';

class ApiService {
  late Dio _dio;

  ApiService._internal();

  static final ApiService _apiService = ApiService._internal();

  factory ApiService() => _apiService;

  Dio provideDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Env.baseUrl,
      receiveTimeout: Env.apiTimeOut,
      connectTimeout: Env.apiTimeOut,
      sendTimeout: Env.apiTimeOut,
    );

    PrettyDioLogger prettyDioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
    Interceptor customInterceptor = CustomInterceptor();

    _dio = Dio(baseOptions);

    // Add the Interceptors here
    _dio.interceptors.addAll({
      prettyDioLogger,
      customInterceptor,
    });

    return _dio;
  }
}
