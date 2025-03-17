// lib/logic/auth/auth_event.dart
import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;
  const LoginRequested({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}

class RegisterRequested extends AuthEvent {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final File? image; // optional

  const RegisterRequested({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.image,
  });

  @override
  List<Object?> get props => [username, password, firstName, lastName, image];
}

class LogoutRequested extends AuthEvent {}
