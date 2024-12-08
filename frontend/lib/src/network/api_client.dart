import 'package:dio/dio.dart';
import 'package:tugas_akhir/env.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: Env.apiTimeOut,
        receiveTimeout: Env.apiTimeOut,
        headers: {
          'Content-Type': Env.applicationJson,
          'Accept': Env.applicationJson,
        }));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onResponse: (response, handler) => handler.next(response),
      onError: (DioException error, ErrorInterceptorHandler handler) {
        // Convert DioError to custom DioException
        DioException dioException =
            DioException(requestOptions: error.requestOptions);

        // Now pass the exception along
        return handler.next(
            dioException); // Pass error to handler (continuing error processing)
      },
    ));
  }

  Dio get dio => _dio;
}
