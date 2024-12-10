import 'package:tugas_akhir/src/features/authentication/data/auth_model.dart';
import 'package:tugas_akhir/src/features/authentication/domain/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<UserModel> execute(String email, String password) async {
    return await authRepository.login(email, password);
  }
}

class GetSessionUseCase {
  final AuthRepository authRepository;

  GetSessionUseCase(this.authRepository);

  Future<SessionModel> execute() async {
    return await authRepository.getSession();
  }
}
