// lib/logic/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(
        username: event.username,
        password: event.password,
      );
      final access = response['access'] as String;
      final refresh = response['refresh'] as String;
      emit(AuthAuthenticated(accessToken: access, refreshToken: refresh));
    } catch (error) {
      emit(AuthError(error: error.toString()));
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.register(
        username: event.username,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        image: event.image,  // optional
      );
      final msg = result['detail'] ?? 'User registered successfully.';
      emit(AuthRegistered(message: msg));
    } catch (error) {
      emit(AuthError(error: error.toString()));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
