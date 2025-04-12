// lib/features/legal_resources/domain/usecases/remove_favorite_resource.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/legal_resources_repository.dart';

class RemoveFavoriteResource {
  final LegalResourcesRepository repository;
  RemoveFavoriteResource(this.repository);

  Future<Either<Failure, void>> execute(int resourceId) {
    return repository.removeFavoriteResource(resourceId);
  }
}
