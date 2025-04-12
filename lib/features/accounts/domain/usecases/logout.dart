// lib/features/accounts/domain/usecases/logout.dart

import 'package:dartz/dartz.dart';
import 'package:lawbridge_frontend/core/errors/failure.dart';
import '../repositories/accounts_repository.dart';

class Logout {
  final AccountsRepository repository;

  Logout(this.repository);

  Future<Either<Failure, void>> execute() async {
    return await repository.logout();
  }
}
