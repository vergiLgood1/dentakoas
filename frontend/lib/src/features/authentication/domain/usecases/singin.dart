import 'package:dartz/dartz.dart';
import 'package:tugas_akhir/service_locator.dart';
import 'package:tugas_akhir/src/core/usecase/usecase.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/signin_req.dart';
import 'package:tugas_akhir/src/features/authentication/domain/repository/auth.dart';

class SigninUseCase implements Usecase<Either, SigninReqParams> {
  @override
  Future<Either> call({SigninReqParams? param}) async {
    return sl<AuthRepository>().signin(param!);
  }
}
