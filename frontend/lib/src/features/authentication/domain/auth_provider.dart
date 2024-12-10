import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_akhir/src/features/authentication/application/auth_bloc.dart';
import 'package:tugas_akhir/src/features/authentication/domain/auth_repository.dart';
import 'package:tugas_akhir/src/features/authentication/domain/auth_use_case.dart';

final authRepository = AuthRepository();

final authProviders = [
  BlocProvider(
    create: (context) => AuthBloc(
      authRepository: authRepository,
      getSessionUseCase: GetSessionUseCase(authRepository),
      loginUseCase: LoginUseCase(authRepository),
    ),
  ),
];
