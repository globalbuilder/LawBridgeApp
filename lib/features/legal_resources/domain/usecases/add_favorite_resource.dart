// lib/features/legal_resources/domain/usecases/add_favorite_resource.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/legal_resources_repository.dart';

class AddFavoriteResource {
  final LegalResourcesRepository repository;
  AddFavoriteResource(this.repository);

  Future<Either<Failure, void>> execute(int resourceId) {
    return repository.addFavoriteResource(resourceId);
  }
}
