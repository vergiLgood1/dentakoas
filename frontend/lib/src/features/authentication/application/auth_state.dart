import 'package:equatable/equatable.dart';
import 'package:tugas_akhir/src/features/authentication/data/auth_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthSessionFetched extends AuthState {
  final String sessionData;

  AuthSessionFetched({required this.sessionData});

  @override
  List<Object?> get props => [sessionData];
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
