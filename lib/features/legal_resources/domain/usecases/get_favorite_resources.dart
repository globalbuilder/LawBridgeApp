// lib/features/legal_resources/domain/usecases/get_favorite_resources.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/favorite_resource_entity.dart';
import '../repositories/legal_resources_repository.dart';

class GetFavoriteResources {
  final LegalResourcesRepository repository;
  GetFavoriteResources(this.repository);

  Future<Either<Failure, List<FavoriteResourceEntity>>> execute() {
    return repository.getFavoriteResources();
  }
}
