// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tugas_akhir/src/features/authentication/application/auth_state.dart';
// import 'package:tugas_akhir/src/features/authentication/application/auth_event.dart';
// import 'package:tugas_akhir/src/features/authentication/domain/auth_repository.dart';
// import 'package:tugas_akhir/src/features/authentication/domain/auth_use_case.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginUseCase loginUseCase;
//   final GetSessionUseCase getSessionUseCase;

//   AuthBloc({required this.getSessionUseCase, required this.loginUseCase, required AuthRepository authRepository})
//       : super(AuthInitial()) {
//     on<LoginRequested>(_onLogin);
//     on<GetSessionEvent>(_onGetSession);
//   }

//   Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final user = await loginUseCase.execute(event.email, event.password);
//       emit(AuthAuthenticated(user: user));
//     } catch (e) {
//       emit(AuthError(message: e.toString()));
//     }
//   }

//   Future<void> _onGetSession(
//       GetSessionEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final session = await getSessionUseCase.execute();
//       emit(AuthSessionFetched(sessionData: session.toString()));
//     } catch (e) {
//       emit(AuthError(message: e.toString()));
//     }
//   }
// }
