import 'package:dartz/dartz.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/csrf.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signin_req.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signup_req.dart';

abstract class AuthRepository {
  
  Future<Either> csrf(CsrfReqParams csrfReq);
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SigninReqParams signinReq);
}
