// lib/logic/auth/auth_state.dart
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String accessToken;
  final String refreshToken;

  const AuthAuthenticated({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

class AuthRegistered extends AuthState {
  final String message;
  const AuthRegistered({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final String error;
  const AuthError({required this.error});
  @override
  List<Object?> get props => [error];
}
