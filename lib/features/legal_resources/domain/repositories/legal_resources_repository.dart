// lib/features/legal_resources/domain/repositories/legal_resources_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/legal_resource_entity.dart';
import '../entities/favorite_resource_entity.dart';

abstract class LegalResourcesRepository {
  Future<Either<Failure, List<LegalResourceEntity>>> getResources({String? search});
  Future<Either<Failure, LegalResourceEntity>> getResourceDetail(int id);

  Future<Either<Failure, List<FavoriteResourceEntity>>> getFavoriteResources();
  Future<Either<Failure, void>> addFavoriteResource(int resourceId);
  Future<Either<Failure, void>> removeFavoriteResource(int resourceId);
}
