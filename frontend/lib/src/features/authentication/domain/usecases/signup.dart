import 'package:dartz/dartz.dart';
import 'package:tugas_akhir/service_locator.dart';
import 'package:tugas_akhir/src/core/usecase/usecase.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signup_req.dart';
import 'package:tugas_akhir/src/features/authentication/domain/repository/auth.dart';

class SignupUseCase implements Usecase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
}
