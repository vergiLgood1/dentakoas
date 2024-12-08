import 'package:dio/dio.dart';
import 'package:tugas_akhir/src/variables/constants/api_endpoint.dart';
import 'package:tugas_akhir/src/features/authentication/data/user_model.dart';
import 'package:tugas_akhir/src/network/api_client.dart';
import 'package:tugas_akhir/src/network/api_response.dart';

class AuthRepository {
  final Dio _dio = ApiClient().dio;

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );
      if (apiResponse.success) {
        return apiResponse.data!;
      }
    } catch (e) {
      throw e.toString();
    }
    throw Exception('Login failed');
  }
}
