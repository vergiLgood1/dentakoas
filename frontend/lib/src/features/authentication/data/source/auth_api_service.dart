import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tugas_akhir/service_locator.dart';
import 'package:tugas_akhir/src/core/network/dio_client.dart';
import 'package:tugas_akhir/src/utils/constants/api_urls.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/csrf.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signin_req.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signup_req.dart';

abstract class AuthApiService {
  Future<Either> csrf(CsrfReqParams csrfReq);
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SigninReqParams signinReq);
}

class AuthApiServiceImpl extends AuthApiService {
  String? _csrfToken; // Variable untuk menyimpan csrfToken

  @override
  Future<Either> csrf(CsrfReqParams csrfReq) async {
    try {
      var response = await sl<DioClient>().get(ApiUrls.csrf);
      _csrfToken = response.data['csrfToken']; // Simpan csrfToken
      return Right(_csrfToken);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error');
    }
  }

  Future<void> _ensureCsrfToken() async {
    // Pastikan csrfToken tersedia
    if (_csrfToken == null) {
      final csrfResult = await csrf(CsrfReqParams());
      csrfResult.fold(
        (error) => throw Exception('Failed to fetch csrfToken: $error'),
        (token) => _csrfToken = token,
      );
    }
  }

  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      await _ensureCsrfToken(); // Pastikan csrfToken tersedia
      var response = await sl<DioClient>().post(
        ApiUrls.signup,
        data: signupReq.toMap(),
        options: Options(
          headers: {
            'X-CSRF-Token': _csrfToken
          }, // Tambahkan csrfToken ke header
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error');
    }
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {
      await _ensureCsrfToken(); // Pastikan csrfToken tersedia
      print('CSRF Token: $_csrfToken'); // Debug nilai csrfToken
      var response = await sl<DioClient>().post(
        ApiUrls.signinCredentials,
        data: signinReq.toMap(),
        options: Options(
          headers: {
            'X-CSRF-Token': _csrfToken
          }, // Tambahkan csrfToken ke header
        ),
      );
      print('Response Headers: ${response.headers}');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error');
    }
  }
}

