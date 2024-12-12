import 'package:dartz/dartz.dart';
import 'package:tugas_akhir/service_locator.dart';
import 'package:tugas_akhir/src/core/usecase/usecase.dart';
import 'package:tugas_akhir/src/features/authentication/data/models/csrf.dart';
import 'package:tugas_akhir/src/features/authentication/domain/repository/auth.dart';

class CsrfUseCase implements Usecase<Either, CsrfReqParams> {
  @override
  Future<Either> call({CsrfReqParams? param}) async {
    return sl<AuthRepository>().csrf(param!);
  }
}
