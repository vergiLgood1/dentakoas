import 'package:dartz/dartz.dart';
import 'package:tugas_akhir/service_locator.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/csrf.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signin_req.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signup_req.dart';
import 'package:tugas_akhir/src/features/authentication/data/source/auth_api_service.dart';
import 'package:tugas_akhir/src/features/authentication/domain/repository/auth.dart';

class AuthRepositoryImpl extends AuthRepository {

  @override
  Future<Either> csrf(CsrfReqParams csrfReq) {
    return sl<AuthApiService>().csrf(csrfReq);
  }
  
  @override
  Future<Either> signin(SigninReqParams signinReq) {
    return sl<AuthApiService>().signin(signinReq);
  }

  @override
  Future<Either> signup(SignupReqParams signupReq) {
    return sl<AuthApiService>().signup(signupReq);
  }

}
