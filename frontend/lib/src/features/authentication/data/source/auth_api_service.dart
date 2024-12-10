import 'package:dartz/dartz.dart';
import 'package:tugas_akhir/service_locator.dart';
import 'package:tugas_akhir/src/core/network/dio_client.dart';

abstract class AuthApiService {
  Future<Either> signup();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup() {
    try {
      sl<DioClient>().post(
        
      );
    } catch (e) {}
  }
}
