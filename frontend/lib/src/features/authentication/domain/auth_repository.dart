import 'package:dio/dio.dart';
import 'package:tugas_akhir/src/core/variables/constants/api_urls.dart';
import 'package:tugas_akhir/src/features/authentication/data/auth_model.dart';
import 'package:tugas_akhir/src/core/network/api_services.dart';
import 'package:tugas_akhir/src/core/network/api_response.dart';

class AuthRepository {
  final Dio _dio = ApiService().provideDio();

  Future<String> getToken() async {
    try {
      final response = await _dio.get(ApiUrls.token);
      final csrfToken = response.data;

      if (csrfToken != null && csrfToken['csrfToken'] != null) {
        return csrfToken['csrfToken'];
      } else {
        throw Exception('Token not found');
      }
    } on DioException catch (err) {
      throw Exception('Failed to fetch token: $err');
    }
  }

  Future<SessionModel> getSession() async {
    try {
      final response = await _dio.get(ApiUrls.session);

      final apiResponse = ApiResponse.fromJson(
        response.data,
        (data) => SessionModel.fromJson(data),
      );

      if (apiResponse.success) return apiResponse.data!;
    } on DioException catch (err) {
      throw err.toString();
    }
    throw Exception('Failed to fetch data');
  }

  Future<UserModel> login(String email, String password) async {
    try {
      String csrfToken = await getToken();

      final response = await _dio.post(ApiUrls.login,
          data: {"email": email, "password": password},
          options: Options(headers: {
            'x-csrf-token': csrfToken,
          }));

      final apiResponse = ApiResponse.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      if (apiResponse.success) return apiResponse.data!;
    } on DioException catch (err) {
      throw err.toString();
    }
    throw Exception('Login failed');
  }
}
