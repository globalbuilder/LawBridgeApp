import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/legal_resource_entity.dart';
import '../../domain/entities/favorite_resource_entity.dart';
import '../../domain/repositories/legal_resources_repository.dart';
import '../datasources/legal_resources_remote_data_source.dart';
import '../models/legal_resource_model.dart';

class LegalResourcesRepositoryImpl implements LegalResourcesRepository {
  final ILegalResourcesRemoteDataSource remote;
  LegalResourcesRepositoryImpl({required this.remote});

  @override
  Future<Either<Failure, List<LegalResourceEntity>>> getResources(
      {String? search}) async {
    try {
      final List<LegalResourceModel> models =
          await remote.getResources(search: search);
      return Right(models);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LegalResourceEntity>> getResourceDetail(int id) async {
    try {
      final model = await remote.getResourceDetail(id);
      return Right(model);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteResourceEntity>>>
      getFavoriteResources() async {
    try {
      final list = await remote.getFavoriteResources();
      return Right(list);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addFavoriteResource(int resourceId) async {
    try {
      await remote.addFavorite(resourceId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteResource(int resourceId) async {
    try {
      await remote.removeFavorite(resourceId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
