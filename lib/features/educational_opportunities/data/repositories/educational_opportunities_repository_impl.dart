import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/opportunity_entity.dart';
import '../../domain/entities/favorite_opportunity_entity.dart';
import '../../domain/repositories/educational_opportunities_repository.dart';
import '../datasources/educational_opportunities_remote_data_source.dart';
import '../models/opportunity_model.dart';

class EducationalOpportunitiesRepositoryImpl implements EducationalOpportunitiesRepository {
  final IEducationalOpportunitiesRemoteDataSource remoteDataSource;

  EducationalOpportunitiesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<OpportunityEntity>>> getOpportunities({String? search}) async {
    try {
      final List<OpportunityModel> models =
          await remoteDataSource.getOpportunities(search: search);
      return Right(models);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, OpportunityEntity>> getOpportunityDetail(int id) async {
    try {
      final model = await remoteDataSource.getOpportunityDetail(id);
      return Right(model);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteOpportunityEntity>>> getFavoriteOpportunities() async {
    try {
      final models = await remoteDataSource.getFavoriteOpportunities();
      return Right(models);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addFavoriteOpportunity(int opportunityId) async {
    try {
      await remoteDataSource.addFavorite(opportunityId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteOpportunity(int opportunityId) async {
    try {
      await remoteDataSource.removeFavorite(opportunityId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
