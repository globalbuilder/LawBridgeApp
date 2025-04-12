// lib/features/accounts/domain/usecases/login.dart

import 'package:dartz/dartz.dart';
import 'package:lawbridge_frontend/core/errors/failure.dart';
import '../repositories/accounts_repository.dart';

class Login {
  final AccountsRepository repository;

  Login(this.repository);

  Future<Either<Failure, String>> execute(String username, String password) async {
    return await repository.login(username, password);
  }
}
