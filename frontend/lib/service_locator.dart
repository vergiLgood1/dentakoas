import 'package:get_it/get_it.dart';
import 'package:tugas_akhir/src/core/network/dio_client.dart';
import 'package:tugas_akhir/src/features/authentication/data/repository/auth.dart';
import 'package:tugas_akhir/src/features/authentication/data/source/auth_api_service.dart';
import 'package:tugas_akhir/src/features/authentication/domain/repository/auth.dart';
import 'package:tugas_akhir/src/features/authentication/domain/usecases/csrf.dart';
import 'package:tugas_akhir/src/features/authentication/domain/usecases/signup.dart';
import 'package:tugas_akhir/src/features/authentication/domain/usecases/singin.dart';


final sl = GetIt.instance;

void setupServiceLocator() {

  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(
    AuthApiServiceImpl(),
  );

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  // Use Cases
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase(),
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase(),
  );

  sl.registerSingleton<CsrfUseCase>(
    CsrfUseCase(),
  );
}
